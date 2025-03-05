{pkgs, ...}: {
  # https://devenv.sh/packages/
  packages = with pkgs; [
    git
    gnupg
    lazygit
    commitizen
  ];

  # Generally will use LaTeX, but I do want to learn and migrate to Typst at
  # some point!
  languages.typst.enable = true;
  processes.typst.exec = "typst watch main.typ";

  devcontainer = {
    enable = true;
    settings = {
      image = "ghcr.io/cachix/devenv:latest";
      customizations.vscode.extensions = [
        "vscodevim.vim"
        "mkhl.direnv"
        "christian-kohler.path-intellisense"
        "tonybaloney.vscode-pets"
        "james-yu.latex-workshop"
        "myriad-dreamin.tinymist"
      ];
    };
  };

  # https://devenv.sh/pre-commit-hooks/
  git-hooks.hooks = {
    # Nix
    alejandra.enable = true;
    deadnix.enable = true;

    # Git
    commitizen.enable = true;

    # General
    check-merge-conflicts.enable = true;
    end-of-file-fixer.enable = true;
    trim-trailing-whitespace.enable = true;

    # Typst
    typstyle.enable = true;
  };

  # See full reference at https://devenv.sh/reference/options/
}
