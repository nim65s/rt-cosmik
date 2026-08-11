{
  description = "Real-Time Constrained and Open-Source Multibody Inverse Kinematics";

  inputs.gepetto.url = "github:gepetto/nix";

  outputs =
    inputs:
    inputs.gepetto.lib.mkFlakoboros inputs (
      { ... }:
      {
        pyPackages.rtcosmik = ./package.nix;
      }
    );
}
