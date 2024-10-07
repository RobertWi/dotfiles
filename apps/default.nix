{ pkgs, ... }: rec {

  # Rebuild
  rebuild = import ./rebuild.nix { inherit pkgs; };

  # Encrypt secret for all machines
  encrypt-secret = import ./encrypt-secret.nix { inherit pkgs; };

  # Re-encrypt secrets for all machines
  reencrypt-secrets = import ./reencrypt-secrets.nix { inherit pkgs; };

  # Run neovim as an app
  neovim = import ./neovim.nix { inherit pkgs; };
  nvim = neovim;
}