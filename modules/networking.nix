{ }:
{
  #DANGER: networking

  networking.networkmanager = {
    enable = false;
    #   wifi.scanRandMacAddress = true;
  };

  networking.hostName = "serverless"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  /*
    networking.wireless = {
      enable = true;
      networks = {
        "ADSL-2.4" = {
          psk = "301F482016E8"; # Replace with your actual Wi-Fi password
        };
      };
    };
  */

  networking.interfaces = {
    /*
      wlp2s0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.50";
            prefixLength = 24;
          }
        ];
      };
    */
    enp1s0 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.1.51";
          prefixLength = 24;
        }
      ];
    };
  };
  networking.nameservers = [
    "94.140.14.14"
    /*
      "9.9.9.9"
      "1.1.1.3"
      "1.1.1.2"
    */
  ];

  networking.defaultGateway = {
    address = "192.168.1.1";
    interface = "enp1s0";
  };
  networking.nat = {
    enable = true;
    # externalInterface = "enp1s0";
    internalInterfaces = [ "wg0" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [
      51820
    ];
    allowedUDPPortRanges = [
      {
        from = 60000;
        to = 60004;
      }
    ];
  };
  # Or disable the firewall altogether.
}
