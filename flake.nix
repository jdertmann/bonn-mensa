{

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems =
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
    in
    {

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixpkgs-fmt);

      overlays.default = final: prev:
        let pkgs = nixpkgsFor.${final.system};
        in {

          bonn-mensa = pkgs.python3Packages.callPackage
            ({ lib
             , buildPythonApplication

               # buildInputs
             , setuptools

               # propagates
             , colorama
             , requests
             }:

              buildPythonApplication {
                pname = "bonn-mensa";
                version = "0.0.1";
                pyproject = true;

                src = self;

                nativeBuildInputs = [ setuptools ];

                propagatedBuildInputs = [ colorama requests ];

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
        let pkgs = nixpkgsFor.${system};
        in {
          default = pkgs.bonn-mensa;
          bonn-mensa = pkgs.bonn-mensa;
        });

    };
}
