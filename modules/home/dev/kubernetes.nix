{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    kubectx
    dive
    stern
    cmctl
  ];
}
