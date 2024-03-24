{ config, lib, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9090;
    listenAddress = "127.0.0.1";

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" "processes" ];
        listenAddress = "100.64.0.3";
        port = 9100;
      };
    };

    scrapeConfigs = [{
      job_name = "node_exporter";
      static_configs = [{
        targets = [
          "100.64.0.2:${
            toString config.services.prometheus.exporters.node.port
          }"
          "100.64.0.3:${
            toString config.services.prometheus.exporters.node.port
          }"
        ];
      }];
    }];
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 8030;
        domain = "lan.yawp.dev";
      };
    };
  };

  services.nginx.virtualHosts."prometheus.lan.yawp.dev" = {
    forceSSL = true;
    useACMEHost = "lan.yawp.dev";
    locations."/" = {
      proxyPass =
        "http://127.0.0.1:${toString config.services.prometheus.port}";
    };
  };

  services.nginx.virtualHosts."grafana.lan.yawp.dev" = {
    forceSSL = true;
    useACMEHost = "lan.yawp.dev";
    locations."/" = {
      proxyPass =
        "http://${toString config.services.grafana.settings.server.http_addr}:${
          toString config.services.grafana.settings.server.http_port
        }";
      proxyWebsockets = true;
    };
  };
}
