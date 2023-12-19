{ self
, lib
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

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
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
}
