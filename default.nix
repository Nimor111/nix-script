{ sources ? import ./nix/sources.nix { }, pkgs ? import sources.nixpkgs { }, ...
}:
let gitignore = pkgs.callPackage sources.gitignore { };
in rec {
  nix-script-bash = pkgs.stdenv.mkDerivation {
    name = "nix-script-bash";

    buildInputs = [ pkgs.makeWrapper ];
    unpackPhase = "true";
    buildPhase = "true";

    installPhase = ''
      mkdir -p $out

      makeWrapper ${nix-script}/bin/nix-script $out/bin/nix-script-bash \
        --argv0 nix-script-bash \
        --set BUILD_COMMAND 'chmod +x $SCRIPT_FILE' \
        --set INTERPETER bash
    '';
  };
}
