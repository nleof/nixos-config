{ pkgs, config, lib, ... }:

let
  host = "192.168.0.17";
  opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
    "user,users"
    "uid=1000,gid=1000"
    "credentials=${config.age.secrets.samba.path}"
  ];
in {
  environment.systemPackages = [ pkgs.cifs-utils ];

  age.secrets.samba.file = ../../secrets/samba.age;

  fileSystems."/mnt/home" = {
    device = "//${host}/home";
    fsType = "cifs";
    options = opts;
  };
  fileSystems."/mnt/media01" = {
    device = "//${host}/media01";
    fsType = "cifs";
    options = opts;
  };
  fileSystems."/mnt/media02" = {
    device = "//${host}/media02";
    fsType = "cifs";
    options = opts;
  };
}
