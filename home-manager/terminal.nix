{ programs, ... }: 

{
	programs = {
		ghostty = {
			enable = true;
		};

		tmux.enable = true;
	};
}
