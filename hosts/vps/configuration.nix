{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  zramSwap.enable = true;
  networking.hostName = "debian-4gb-nbg1-1";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCat4US33j/Fwkt043xnC+qMGeUdIc8es923e8oniAIlwa8DlsByXzU2iOPqhfE3yrPO1Z4NUJVRjdTKATRyhpkiJ3P8zu7sjNzUB9RgmEcxnt8LBMJUoA6lzpqgVfztqVSCSk358VHRYCxWwwUtxZhqEw228jOGUKBVeaD/ONy0krXjhxRVkLSLopI5Gd6A/elhj1Ua57G1SZt8S9Xd5iJHvYmDBWylLW4s+yNECKLoxpJfEfIzItGfysFSxuogQtkYODzL6zIB97SYdTRaIufRQV4ssvK0woSMDXAzgbV+xO+ErtDITiVEv4gtBe9HVKAG0jTHp4IWaCRtAZbm42VMGHvpzfczPwwKGbbu5w/uqpNv4VmZuCEXPkO4hukzU7KSt26SGijOIVWZK2Kocv6xPgjkZTV/5dy2WqgNSfzCi+uJacs0pwFByMVPYQ7sHth8+G1m1wOZikVYKuj0Tc1bgfc10FFY14ahSfqmc9oF4Yq0mPFqT8iUW6YJTL9Lh987MV4xyKlg9TI11QegfbRJ71z0Ac1hM2nSO1mZBvLdHpEXZnpmKc21rDnObl7l4JJtDTwoLhvtc+s39429bpWRvfWetKf9otN9PKKVyx0jZpn6gvrowclnfeOSYtMnQISYBqjMKX70Uph+SV1bDfggZ9oDnP6WqaSKDRxTpXW8w=="
  ];
  system.stateVersion = "23.11";

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "alexandre@yawp.fr";
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."yawp.fr" = {
      forceSSL = true;
      enableACME = true;
      globalRedirect = "www.yawp.fr";
    };

    virtualHosts."www.yawp.fr" = {
      forceSSL = true;
      enableACME = true;
      globalRedirect = "www.yawp.dev";
    };

    virtualHosts."yawp.dev" = {
      forceSSL = true;
      enableACME = true;
      globalRedirect = "www.yawp.dev";
    };

    virtualHosts."www.yawp.dev" = {
      forceSSL = true;
      enableACME = true;
      root = "/srv/www/yawp";
    };
  };
}
