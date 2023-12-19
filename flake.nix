{

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
    in
    {

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixpkgs-fmt);

      devShells = forAllSystems (system: {
        default = nixpkgsFor.${system}.callPackage
          ({ mkShell, python3, ... }:
            mkShell {
              buildInputs = [
                (python3.withPackages (p: with p; [
                  colorama
                  requests
                ]))
              ];
            })
          { };
      });

      overlays.default = final: prev: {
        bonn-mensa = final.callPackage
          ({ lib, python3 }:

            python3.pkgs.buildPythonApplication {
              pname = "bonn-mensa";
              version = (lib.strings.removePrefix ''__version__ = "'' (lib.strings.removeSuffix ''"
              ''
                (builtins.readFile "${self}/src/bonn_mensa/version.py")
              ));
              pyproject = true;

              src = self;

              nativeBuildInputs = with python3.pkgs; [
                setuptools
              ];

              propagatedBuildInputs = with python3.pkgs; [
                colorama
                requests
              ];

              pythonImportsCheck = [ "bonn_mensa" ];

              meta = with lib; {
                description = "Meal plans for university canteens in Bonn";
                homepage = "https://github.com/alexanderwallau/bonn-mensa";
                license = licenses.mit;
                maintainers = with maintainers; [ alexanderwallau MayNiklas ];
                mainProgram = "mensa";
              };
            })
          { };
      };

      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system}; in {
          default = pkgs.bonn-mensa;
          bonn-mensa = pkgs.bonn-mensa;
        });

    };
}
