{ pkgs, ... }: {


  type = "app";

  program = builtins.toString (pkgs.writeShellScript "encrypt-secret" ''
    printf "\nEnter the secret data to encrypt for all hosts...\n\n" 1>&2
    read -p "Secret: " secret
    printf "\nEncrypting...\n\n" 1>&2
    tmpfile=$(mktemp)
    echo "''${secret}" > ''${tmpfile}
    ${pkgs.age}/bin/age --encrypt --armor --recipients-file ${
      builtins.toString ../public-keys
    } $tmpfile
    rm $tmpfile
  '');

}