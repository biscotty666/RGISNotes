{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.11";
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
        
      rspat= pkgs.rPackages.buildRPackage {
        name = "rspatial";
        src = pkgs.fetchFromGitHub{
          owner = "rspatial";
          repo = "rspat";
          rev = "a423fb341fedad728900bd720efe305008eb16fd";
          sha256 = "06qdpm40fv65w15kc0n9jpxzn1zb2j2f85lybkq7knkrrb8qigaf";
        };
   propagatedBuildInputs = with pkgs.rPackages; [bslib evaluate terra jsonlite knitr stringr tinytex yaml xfun];
      };
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
            rspat
            # r-inla
            texlive.combined.scheme-full
            rstudio
            (with rPackages; [
              RColorBrewer
              SpatialEpi
              basemaps
              chirps
              climate
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
              ggforce
              ggspatial
              ggiraph
              ggmap
              ggpattern
#              ggvoronoi
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
#              sfext
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
