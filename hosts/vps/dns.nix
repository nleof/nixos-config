{ config, ... }:

{
  services.unbound = {
    enable = true;
    settings = { port = "5353"; };
  };

  services.adguardhome = {
    enable = true;
    # openFirewall = true;
    # mutableSettings = true;
    settings = {
      http = { address = "127.0.0.1:8053"; };
      dns = {
        bind_hosts = [ "127.0.0.1" "::1" "100.64.0.3" ];
        upstream_dns = [ "127.0.0.1:5353" ];
        enable_dnssec = true;
        ratelimit = 0;
      };
      querylog = { interval = "24h"; };
      statistics = { interval = "720h"; };
      filters = [
        {
          enabled = true;
          url =
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          name = "AdGuard DNS filter";
          id = 1;
        }
        {
          enabled = true;
          url =
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt";
          name = "AdAway Default Blocklist";
          id = 2;
        }
        {
          enabled = true;
          url =
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_27.txt";
          name = "OISD Blocklist Big";
          id = 1710751540;
        }
        {
          enabled = true;
          url =
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_7.txt";
          name = "Perflyst and Dandelion Sprout's Smart-TV Blocklist";
          id = 1710751541;
        }
        {
          enabled = true;
          url =
            "https://adguardteam.github.io/HostlistsRegistry/assets/filter_33.txt";
          name = "Steven Black's List";
          id = 1710751542;
        }
      ];
    };
  };

  services.nginx.virtualHosts."dns.lan.yawp.dev" = {
    forceSSL = true;
    useACMEHost = "lan.yawp.dev";
    locations."/" = {
      proxyPass = "http://${config.services.adguardhome.settings.http.address}";
    };
  };
}
