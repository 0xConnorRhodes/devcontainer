{ config, pkgs, ... }:

{
  # Define a user named 'connor'
  users.users.connor = {
    isNormalUser = true;
    home = "/home/connor";
    shell = pkgs.fish;
    extraGroups = ["wheel"]; # Add to 'wheel' group to allow sudo access
  };

  # Enable sudo for the wheel group
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Install packages
  environment.systemPackages = with pkgs; [
    fish
    powershell
  ];