{ pkgs, ... }:
{
    programs.tmux = {
        enable = true;
        mouse = true;
        keyMode = "vi";
        terminal = "xterm-256color";

        plugins = with pkgs.tmuxPlugins; [
            { 
                plugin = rose-pine;
                extraConfig = ''
                    set -g @rose_pine_variant 'moon'
                '';
            }
        ];
    };
}
