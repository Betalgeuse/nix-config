{
  userConfig,
  config,
  pkgs,
  ...
}:
let
  lua51 = pkgs.lua5_1;
  luarocks51 = pkgs.lua51Packages.luarocks;
  courseNvim = pkgs.writeShellScriptBin "course-nvim" ''
    exec ${pkgs.neovim}/bin/nvim --noplugin \
      -u ${userConfig.nixConfig}/modules/shared/files/nvim-course/init.lua "$@"
  '';
in
{
  home.packages = with pkgs; [
    imagemagick
    ghostscript
    tectonic
    mermaid-cli
    websocat
    grpcurl
    nixd
    courseNvim

    (pkgs.writeShellScriptBin "lua5.1" ''exec ${lua51}/bin/lua "$@"'')
    (pkgs.writeShellScriptBin "luarocks5.1" ''exec ${luarocks51}/bin/luarocks "$@"'')
  ];

  programs.neovim = {
    enable = true;
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${userConfig.nixConfig}/modules/shared/files/nvim";
    recursive = true;
  };

  home.file.".local/bin/course-nvim".source = "${courseNvim}/bin/course-nvim";
}
