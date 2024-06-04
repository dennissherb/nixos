{ config, pkgs, inputs, lib,... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    protonup
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
      "\${HOME}/.steam/root/compatibilitytools.d";
    MOZ_DISABLE_RDD_SANDBOX = "1"; 
    LIBVA_DRIVER_NAME = "nvidia";
  };

  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.bash = {
	  shellAliases = {
   		open = "xdg-open";
   		switch = "sudo nixos-rebuild switch --flake /etc/nixos#default";
		vim = "nvim";
		discordup = "nix-env -f https://github.com/NixOS/nixpkgs/archive/master.tar.gz -iA discord";
		sudo = "sudo ";
	  };
  };

  #Firefox
  programs.firefox.enable = true;
  programs.firefox = {
    profiles = 
    {
      dennis =
      {
        bookmarks = 
	[
	  #Wikipedia
	  {
	    name = "MySites";
	    toolbar = true;
	    bookmarks = 
	    [ 
	      {
    	        name = "wikipedia";
  	        tags = [ "wiki" ];
  	        keyword = "wiki";
  	        url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
	      }
	    ];
	  }
        ];
	search.default = "DuckDuckGo";

	settings = 
	{
	  "media.ffmpeg.vaapi.enabled" = true;  
	  "media.rdd-ffmpeg.enabled" = true;
	  "media.av1.enabled" = true;
	  "gfx.x11-egl.force-enabled" = true;
	  "widget.dmabuf.force-enabled" = true;
	};
      };
    };
  };

    # Custom activation script to delete search.json.mozlz4
  home.activation.deleteSearchJson = lib.hm.dag.entryAfter ["writeBoundary"] ''
    search_file="$HOME/.mozilla/firefox/dennis/search.json.mozlz4"
    if ls $search_file 1> /dev/null 2>&1; then
      rm -f $search_file
    fi

    search_file="$HOME/.config/discord/settings.json"
    if ls $search_file 1> /dev/null 2>&1; then
      rm -f $search_file
    fi
  '';

}

