{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, pytestCheckHook
, cython
, numpy
, scipy
, matplotlib
, networkx
, nibabel
}:

buildPythonPackage rec {
  pname = "nitime";
  version = "0.9";
  disabled = isPy27;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-bn2QrbsfqUJim84vH5tt5T6h3YsGAlgu9GCMiNQ0OHQ=";
  };

  nativeCheckInputs = [ pytestCheckHook ];
  buildInputs = [ cython ];
  propagatedBuildInputs = [ numpy scipy matplotlib networkx nibabel ];

  disabledTests = [
    # https://github.com/nipy/nitime/issues/197
    "test_FilterAnalyzer"
  ];

  meta = with lib; {
    homepage = "https://nipy.org/nitime";
    description = "Algorithms and containers for time-series analysis in time and spectral domains";
    license = licenses.bsd3;
    maintainers = [ maintainers.bcdarwin ];
  };
}
