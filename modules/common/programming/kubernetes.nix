{ config, pkgs, lib, ... }: {

  options.kubernetes.enable = lib.mkEnableOption "Kubernetes tools.";

  config = lib.mkIf config.kubernetes.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        kubectl # Basic Kubernetes queries
        kubernetes-helm # Helm CLI
        fluxcd # Bootstrap clusters with Flux
        kustomize # Kustomize CLI (for Flux)
      ];

      programs.fish.shellAbbrs = {
        k = "kubectl";
        pods = "kubectl get pods -A";
        nodes = "kubectl get nodes";
        deploys = "kubectl get deployments -A";
        dash = "kube-dashboard";
        ks = "k9s";
      };

      # Terminal Kubernetes UI
      programs.k9s = {
        enable = true;
        settings = {
          k9s = {
            ui = {
              enableMouse = true;
              headless = true;
              logoless = true;
              crumbsless = false;
              skin = "main";
            };
          };
        };
      };
    };
  };
}