{ config, pkgs, lib, ... }: {

  options.kubernetes.enable = lib.mkEnableOption "Kubernetes tools.";

  config = lib.mkIf config.kubernetes.enable {
    home-manager.users.${config.user} = {

      home.packages = with pkgs; [
        kubectl 
        eksctl
        kubernetes-helm 
        ssm-session-manager-plugin
        saml2aws
        aws-sso-cli
        aws-sso-creds
        granted
        awsume
        awslogs
        eksctl
        kcat
        kubectx
        kubetail
        kubectl-doctor
        tfk8s
        #openlens
        velero
        node2nix
        # aws-azure-login pulls in chromium no aarch64-darwin available
        sternsa
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
              headless = false;
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