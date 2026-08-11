{
  lib,
  buildPythonPackage,
  uv-build,
  casadi,
  example-robot-data,
  meshcat,
  opencv-python,
  packaging,
  pinocchio,
  pynput,
  quadprog,
  scipy,
  ultralytics,
  torch,
  torchvision,
  nix-update-script,
  argcomplete,
  installShellFiles,
}:

buildPythonPackage (finalAttrs: {
  pname = "rtcosmik";
  version = "packaging";
  pyproject = true;
  __structuredAttrs = true;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./pyproject.toml
      ./README.md
      ./src
      ./tests
      ./weights
    ];
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail '"casadi>=' '#"casadi>=' \
      --replace-fail '"example-robot-data-loaders>=' '#"example-robot-data>=' \
      --replace-fail '"pin>=' '#"pin>='
  '';

  build-system = [
    uv-build
  ];

  dependencies = [
    argcomplete
    casadi
    example-robot-data
    meshcat
    opencv-python
    packaging
    pinocchio
    pynput
    quadprog
    scipy
    torch
    torchvision
    ultralytics
  ];

  pythonImportsCheck = [
    "rtcosmik"
  ];

  passthru.updateScript = nix-update-script { };

  nativeBuildInputs = [
    installShellFiles
    argcomplete
  ];

  postInstall = ''
    installShellCompletion --cmd rtcosmik \
      --bash <(register-python-argcomplete --shell bash rtcosmik) \
      --fish <(register-python-argcomplete --shell fish rtcosmik) \
      --zsh <(register-python-argcomplete --shell zsh rtcosmik)
  '';

  dontCheckPythonMetadata = true;

  meta = {
    description = "Real-Time Constrained and Open-Source Multibody Inverse Kinematics";
    homepage = "https://github.com/gepetto/rt-cosmik";
    license = lib.licenses.bsd2;
    mainProgram = "rtcosmik";
    maintainers = with lib.maintainers; [ nim65s ];
  };
})
