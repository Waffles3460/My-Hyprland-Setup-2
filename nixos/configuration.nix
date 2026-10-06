
{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true;

   networking = { nameservers = [ "127.0.0.1" "::1" ]; };

   services.dnscrypt-proxy = { enable = true; settings = { listen_addresses = [ "127.0.0.1:53" "[::1]:53" ]; }; };

   services.zapret = { enable = true; params = [ "--dpi-desync=fake" "--dpi-desync-ttl=8" ]; };

   security.pki.certificateFiles = [
     ./fatih.crt
  ]; 

  time.timeZone = "Europe/Istanbul";

  i18n.defaultLocale = "tr_TR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

xdg.portal = {
  enable = true;
  extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.kdePackages.xdg-desktop-portal-kde
    pkgs.xdg-desktop-portal-gtk
  ];
  config = {
    common = {
      default = [ "gtk" ];
    };
    hyprland = {
      default = [ "hyprland" "gtk" ];
    };
    kde = {
      default = [ "kde" "gtk" ];
    };
  };
};
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  hardware.nvidia = {
  modesetting.enable = true;
  open = false; 
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  powerManagement.enable = false;

  prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
};

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
 
  hardware.enableAllFirmware = true;

  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };

  console.keyMap = "trq";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.blueman.enable = true;

  services.flatpak.enable = true;

  users.users."kayra" = {
    isNormalUser = true;
    description = "Kayra";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      firefoxpwa
	vscode
	fastfetch
	btop
	alacritty
	cava
	pipes
	obs-studio
	kdePackages.kdenlive
	kitty
        libnotify
	catppuccin-gtk
  	papirus-icon-theme
	rofi
  	lxappearance
	onlyoffice-desktopeditors
	psmisc
	audacity
	bibata-cursors
	xwinwrap
	mpv
	git
	unzip
  	zip
  	p7zip
	xarchiver
	conky
	pciutils
	picom
        obsidian
  	appimage-run
 	vesktop
	gcc
  	clang
  	llvm
  	gnumake 
  	cmake
	gdb
	zsh
	kdePackages.bluedevil
	cmatrix
	clock-rs
	fish
	yt-dlp
	jdk17
	steam-run
	zoom-us
	waybar
	dunst
	hyprpaper
	grim
  	slurp
	wl-clipboard
	swaybg
	pavucontrol
	hyprlock
	unityhub
	r2modman
	kdePackages.spectacle
	hyprshot
	imagemagick
	flameshot
	monocraft
	playerctl
	gpu-screen-recorder
    ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
  jetbrains-mono
  nerd-fonts.jetbrains-mono
  nerd-fonts.fira-code
  noto-fonts
  noto-fonts-color-emoji
  font-awesome
];

  programs.firefox = {
	enable = true;
	nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
};

   programs.steam.enable = true;

   programs.zsh.enable = true;

   programs.nix-ld.enable = true;

   programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    
    enabledExtensions = with spicePkgs.extensions; [
      adblock            
      shuffle            
      fullAppDisplay     
      hidePodcasts       
    ];
  };

   programs.gamemode.enable = true;
 
   programs.gpu-screen-recorder.enable = true;		

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  system.stateVersion = "26.05"; 

}
