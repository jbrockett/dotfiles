{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$sudo$git_branch$git_status$git_metrics$fill$aws$cmd_duration\n$character";
      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red) ";
      };

      cmd_duration = {
        min_time = 5000;
        format = "[$duration](bold yellow)";
      };

      directory.truncate_to_repo = true;

      fill.symbol = " ";

      git_status = {
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        up_to_date = "";
        untracked = "🤷";
        stashed = "";
        modified = "📝";
        staged = "[++\\($count\\)](green)";
        renamed = "👅";
        deleted = "🗑";
        disabled = false;
      };

      nix_shell = {
        disabled = false;
        impure_msg = "devbox";
        format = "via [$symbol$state](bold blue) ";
      };

      aws = {
        format = "[$symbol($profile )(\($region\) )]($style)";
        symbol = "☁️ ";
        style = "bold yellow";
        disabled = false;
      };
    };
  };
}
