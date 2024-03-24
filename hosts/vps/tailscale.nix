{ config, ... }:

{
  environment.systemPackages = [ config.services.headscale.package ];

  services.headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 8022;
    settings = {
      server_url = "https://tailscale.yawp.dev";
      dns_config = {
        nameservers = [ "100.64.0.3" "2a01:4f8:c0c:4f02::" ];
        base_domain = "lan.yawp.dev";
        override_local_dns = true;
      };
      logtail.enabled = false;
    };
  };

  services.nginx.virtualHosts."tailscale.yawp.dev" = {
    forceSSL = true;
    useACMEHost = "yawp.dev";
    locations."/" = {
      proxyPass = "http://localhost:${toString config.services.headscale.port}";
      proxyWebsockets = true;
    };
  };
}
