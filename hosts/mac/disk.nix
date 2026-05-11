{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-APPLE_SSD_AP0512Z_0ba01e4b200c5206";
        destroy = false;

        content = {
          type = "gpt";

          partitions = {
            iBootSystemContainer = {
              label = "iBootSystemContainer";
              priority = 1;
              type = "AF0B";
              uuid = "692be901-bf96-4b52-85da-4b828acad811";
            };

            Container = {
              label = "Container";
              priority = 2;
              type = "AF0A";
              uuid = "f862810c-dadc-4458-a8b0-46f121aa17d4";
            };

            NixOSContainer = {
              priority = 3;
              type = "AF0A";
              uuid = "050e466e-de7b-49ef-8d52-936489596070";
            };

            ESP = {
              priority = 4;
              type = "EF00";
              uuid = "7545fc03-8de8-496c-84c9-19dcd4f54d21";

              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "20G";
                    };
                  };
                };
              };
            };

            RecoveryOSContainer = {
              label = "RecoveryOSContainer";
              priority = 5;
              type = "AF0C";
              uuid = "85d06b1d-d623-4384-adc7-4f48a4c20dca";
            };
          };
        };
      };
    };
  };
}
