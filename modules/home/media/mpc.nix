{ pkgs, ... }:

{
  programs.beets = {
    enable = true;
    settings = {
      directory = "/mnt/media01/music";
      library = "~/Music/beets.db";
      import = { copy = false; };
      plugins = [ "fetchart" ];
      fetchart = { sources = "itunes *"; };
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "/mnt/media01/music";
  };

  programs.ncmpcpp = {
    enable = true;
    settings = { media_library_primary_tag = "album_artist"; };
  };
}
