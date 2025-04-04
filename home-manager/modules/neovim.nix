{ config, ... }: 
{
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		vimdiffAlias = true;
	};

	xdg.configFile."nvim" = {
		source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
	};
}
