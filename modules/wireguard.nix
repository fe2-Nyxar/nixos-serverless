{ pkgs, config, ... }:

{

  networking.wireguard.enable = true;
  networking.wireguard.interfaces =
    let
      Net_interface = "enp1s0";
    in
    {
      # "wg0" is the network interface name. You can name the interface arbitrarily.
      wg0 = {
        # Determines the IP address and subnet of the server's end of the tunnel interface.
        ips = [ "10.100.0.1/24" ];
        # generatePrivateKeyFile = true;
        # The port that WireGuard listens to. Must be accessible by the client.
        listenPort = 51820;
        privateKeyFile = "/home/baryon/wireguard-keys/private";
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ${Net_interface} -j MASQUERADE
        '';
        # This undoes the above command
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ${Net_interface} -j MASQUERADE
        '';
        mtu = 1280;
        peers = [
          {
            #Nyxar (nixos)
            publicKey = "S/JXC+8QZ7Zn3zpOLIvzSHwU00CRA9FYLTPWNzgLgjw=";
            allowedIPs = [ "10.100.0.2/32" ];
          }
          {
            # android (oppo)
            publicKey = "8omTwpMeqJKFXQfufVotB1VgQHSe7l9/XAnXnEMywBo=";
            allowedIPs = [ "10.100.0.3/32" ];

          }
          /*
            {
              # waydroid
              publicKey = "A5ficiXROHjIAWoe52BVFVkqIli4iSRa+ShULctB1Qg=";
              allowedIPs = [ "10.100.0.3/32" ];
            }
          */
        ];
      };
    };
}
