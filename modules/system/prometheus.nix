{
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" "processes" ];
        listenAddress = "100.64.0.2";
        port = 9100;
      };
    };
  };
}
