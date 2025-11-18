{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.05";
  inputs.systems.url = "github:nix-systems/default";
  inputs.flake-utils = {
    url = "github:numtide/flake-utils";
    inputs.systems.follows = "systems";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
   #    r-inla = pkgs.rPackages.buildRPackage {
   #      name = "R-INLA";
   #      src = pkgs.fetchFromGitHub{
   #        owner = "hrue";
   #        repo = "r-inla";
   #        rev = "daf931c988cadd7567c07cae23ff75eb7e6ad02d";
   #        sha256 = "1ll6azffga02kxqygalj4d03xplj7xb98qjwrdm7v17lznlamvx9";
   #      };
   # propagatedBuildInputs = with pkgs.rPackages; [bslib evaluate Matrix sp INLAspacetime fmesher jsonlite knitr stringr tinytex yaml xfun];
   #    };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          buildInputs = with pkgs; [
            R
            chromium
            pandoc
            # r-inla
            texlive.combined.scheme-full
            rstudio
            (with rPackages; [
              RColorBrewer
              SpatialEpi
              basemaps
              chirps
              dismo
              dodgr
              elevatr
              fields
              flowmapblue
              forcats
              gapminder
              geoR
              geodata
              geodist
              ggspatial
              ggiraph
              ggmap
              ggpattern
              gstat
              htmlwidgets
              janitor
              leaflet
              leaflet_extras
              leaflet_extras2
              leafpop
              leafsync
              maps
              mapview
              osmdata
              pagedown
              patchwork
              plotly
              prettymapr
              raster
              rcartocolor
              rmapshaper
              rnaturalearth
              rnaturalearthdata
              scales
              sf
              shiny
              sp
              spData
              spatstat
              spdep
              terra
              thematic
              tidycensus
              tidygeocoder
              tidyterra
              tidyverse
              tmap
              viridis
            ])
          ];
        };
      }
    );
}
