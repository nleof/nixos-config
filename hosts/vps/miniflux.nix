{ config, ... }:

{
  age.secrets.miniflux.file = ../../secrets/miniflux.age;
  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.miniflux.path;
    config = {
      LISTEN_ADDR = "localhost:8080";
      BASE_URL = "https://reader.lan.yawp.dev";
    };
  };

  services.nginx.virtualHosts."reader.lan.yawp.dev" = {
    forceSSL = true;
    useACMEHost = "lan.yawp.dev";
    locations."/" = {
      proxyPass = "http://${config.services.miniflux.config.LISTEN_ADDR}";
    };
  };
}
