{
  description = "ACME liba (dev flake)";

  inputs = {
    acmepkgs.url = "github:nixcademy/acmepkgs";
    acmepkgs.inputs.acme-liba.follows = "acme-liba";

    # Bend acmepkgs's pin of acme-liba to this local working tree.
    acme-liba = {
      url = "path:.";
      flake = false;
    };
  };

  outputs = inputs: {
    packages = builtins.mapAttrs (system: pkgs: {
      liba = pkgs.acme.liba;
      default = pkgs.acme.liba;
    }) inputs.acmepkgs.legacyPackages;

    devShells = builtins.mapAttrs (system: pkgs: {
      default = pkgs.mkShell {
        inputsFrom = [
          pkgs.acme.liba
        ];
      };
    }) inputs.acmepkgs.legacyPackages;
  };
}
