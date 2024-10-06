{ pkgs, ... }: rec {

  # Rebuild
  rebuild = import ./rebuild.nix { inherit pkgs; };

  # Load the SSH key for this machine
  #loadkey = import ./loadkey.nix { inherit pkgs; };

  # Encrypt secret for all machines
  encrypt-secret = import ./encrypt-secret.nix { inherit pkgs; };

  # Re-encrypt secrets for all machines
  reencrypt-secrets = import ./reencrypt-secrets.nix { inherit pkgs; };

}