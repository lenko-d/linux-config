# Make a module from emacs, it kindoff bleeds over into other stuff
# and we need a bunch of programs on path for it to function properly

{ config, pkgs, ... }:
let
  aspell_with_dict = pkgs.aspellWithDicts(ps: [ps.nl ps.en]);
in {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
	  systemPackages = with pkgs; [
        # emacs
        pkgs.silver-searcher # when configuring my emacs they told me to use this: https://github.com/ggreer/the_silver_searcher#installation
        pkgs.ripgrep # better silver searcher?
        aspell_with_dict # I can't spell
        pkgs.rustracer
        pkgs.haskellPackages.stylish-haskell
        pkgs.haskellPackages.brittany
        pkgs.haskellPackages.hindent
        pkgs.haskellPackages.hlint
        shfmt
        html-tidy
        pkgs.nodePackages.prettier
        pkgs.python37Packages.sqlparse # sqlforamt
	  ];
  };

  services = {
		emacs = {
			enable = true; # deamon mode
			package = (import ./emacs.nix { inherit pkgs; });
		};
  };
}
