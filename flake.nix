{
  # The document, and the suite that proves it. `bin/generate-specs` turns
  # every operation described here into an openapi-ruby example;
  # `rspec` aims them at a real RT.
  inputs.mine.url = "github:n-at-han-k/flake.nix";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { mine, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lib = mine.lib.${system};
        gems = lib.buildGemset { name = "openapi-schema-rt"; src = ./.; };

        # Everything per-endpoint the suite needs -- which object to aim an
        # operation at, what body to send, what has to exist first -- is
        # decided from THIS DOCUMENT by the generator, not written by hand
        # beside the specs. javac against the CLI's own jar and an SPI entry;
        # no Maven, no checkout of the generator.
        rspec-codegen = pkgs.stdenv.mkDerivation {
          name = "rt-rspec-codegen";
          src = ./generators/rspec;

          nativeBuildInputs = [ pkgs.jdk ];

          buildPhase = ''
            mkdir -p classes
            javac -nowarn -proc:none \
              -cp ${pkgs.openapi-generator-cli}/share/java/openapi-generator-cli.jar \
              -d classes $(find src -name '*.java')
            cp -r resources/. classes/
            jar cf rt-rspec-codegen.jar -C classes .
          '';

          installPhase = ''
            install -Dm644 rt-rspec-codegen.jar $out/share/java/rt-rspec-codegen.jar
          '';
        };

        # The packaged CLI runs `java -jar`, which ignores -cp; a generator on
        # the classpath needs the main class named.
        openapi-generator-rt-rspec = pkgs.writeShellApplication {
          name = "openapi-generator-rt-rspec";
          runtimeInputs = [ pkgs.jre ];
          text = ''
            exec java -cp ${rspec-codegen}/share/java/rt-rspec-codegen.jar:${pkgs.openapi-generator-cli}/share/java/openapi-generator-cli.jar \
              org.openapitools.codegen.OpenAPIGenerator "$@"
          '';
        };
      in
      {
        packages = { inherit rspec-codegen openapi-generator-rt-rspec; };

        devShells.default = lib.mkRubyShell {
          buildInputs = [
            gems
            gems.wrappedRuby

            # bin/generate-specs (`-g rt-rspec`).
            openapi-generator-rt-rspec

            # The lint upstream's CI runs.
            pkgs.vacuum-go
          ];
        };
      }
    );
}
