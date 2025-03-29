{ programs, pkgs, ... }:

{
	programs = {
		zsh = {
			enable = true;
			autosuggestion.enable = true;
			syntaxHighlighting.enable = true;
			autocd = true;

			shellAliases = {
				hmb = "home-manager build";
				hms = "home-manager switch";
				ncg = "nix-collect-garbage";
			};
			
			plugins = [
			{
				name = "pure";
				src = pkgs.fetchFromGitHub {
					owner = "sindresorhus";
					repo = "pure";
					rev  = "v1.23.0";
					sha256 = "1jcb5cg1539iy89vm9d59g8lnp3dm0yv88mmlhkp9zwx3bihwr06";
				};
			}
			];
		};

		fzf.enable = true;
		fd.enable = true;
		ripgrep.enable = true;
	};
}
