{ pkgs, ... }:

{
  home.packages = with pkgs; [ nixfmt ];
}