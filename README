# Terraform Module for Create Droplet on DigitalOcean

This module create a droplet on DigitalOcean with some additional features:

- Create a local OS User with SSH key
- Disable root login for SSH
- Add Login Banner
- WIP: Install Docker
- WIP: Add firewall rules for SSH

## Usage

```HCL
module "droplet" {
  source = "../"

  droplet_name_prefix = "lds001"
  droplet_tags        = ["loodos", "lds", "001", "staging"]
  ssh_key_names       = ["emrah@Emrahs-MacBook-Pro.local", "emrah@DESKTOP-T7UP1C1"]
  initial_user  = "loodos"
  banner_path   = "./files/sshd_banner"
  user_data     = "echo \"hello\nworld\n\" > \"/home/loodos/hello\""

  region = "ams3"
  size   = "s-1vcpu-1gb"
}
```

## Inputs (Variables)

`*` required

| name           | description                                                                                                  | default          |
| -------------- | ------------------------------------------------------------------------------------------------------------ | ---------------- |
| do_token `*`   | Personal AccessToken for DigitalOcean API                                                                    | ""               |
| droplet_name   | Name of the Droplet                                                                                          | lds              |
| image_name     | Base image name                                                                                              | ubuntu-18-04-x64 |
| region         | Droplet will be created in this region                                                                       | ams3             |
| size           | Choose a droplet plan on DigitalOcean                                                                        | s-1vcpu-1gb      |
| droplet_tags   | List of tags to apply to this Droplet. These tags `will be created`.                                         | []               |
| ssh_key_names  | List of `already registered` SSH Key Names on DigitalOcean.                                                  | []               |
| ssh_keys       | List of new SSH Keys to register on DigitalOcean.                                                            | []               |
| ssh_key_path   | Path of the private SSH key.                                                                                 | ""               |
| initial_user   | Create a initial local OS User. If it's not `root` account, PermitRootLogin will be disabled in sshd_config. | "root"           |
| docker_version | Choose the docker version to install. Leave blank to ignore.                                                 | ""               |
| banner_path    | Path ot the banner file to display before login                                                              | ""               |
| user_data      | A string of the desired User Data for the Droplet                                                            | ""               |
|                |                                                                                                              |                  |

### Available options

#### region

```bash
$ doctl compute region list

Slug    Name               Available
nyc1    New York 1         true
sgp1    Singapore 1        true
lon1    London 1           true
nyc3    New York 3         true
ams3    Amsterdam 3        true
fra1    Frankfurt 1        true
tor1    Toronto 1          true
sfo2    San Francisco 2    true
blr1    Bangalore 1        true
```

#### size

```bash
$ doctl compute size list

Slug               Memory    VCPUs    Disk    Price Monthly    Price Hourly
512mb              512       1        20      5.00             0.007440
s-1vcpu-1gb        1024      1        25      5.00             0.007440
1gb                1024      1        30      10.00            0.014880
s-1vcpu-2gb        2048      1        50      10.00            0.014880
s-1vcpu-3gb        3072      1        60      15.00            0.022320
...
```

#### banner_path

You can create banner with this tool:
http://patorjk.com/software/taag/#p=display&f=Ivrit&t=loodos

## Outputs

| name           | description                    |
| -------------- | ------------------------------ |
| ipv4_address   | The public IPv4 address        |
| ssh_connection | The command for ssh connection |
|                |                                |

## Authors

This module managed by [Emrah Çetiner](https://github.com/emrahcetiner) [@Loodos](https://github.com/Loodos)

## License

This module is licensed under the [Apache License 2.0](./LICENSE).
Copyright (c) 2019 [Loodos](https://github.com/Loodos)
