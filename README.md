# Terraform Beginner Bootcamp 2023

## semantic versioning :mage:

This project is going to utilise semantic vversioning for its tagging
[semver .org](http://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the terraform CLI

The Terraform CLI installation instructions have changed due to gpg keyring changes. so we needed  refer to the latest install CLI instructions via Terraform documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)



### Consideration for Linux Distribution

This project is built against ubuntu.
Please consider checking your Distribution and change accordingly to distrubtion needs.

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
```sh
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into bash scripts

while fixing the terraform CLI gpg depreciation issues we notice that bash scripts steps were a consideriable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/  install_terraform_cli](./bin/  install_terraform_cli)

- This will keep the Gitpod Task file[.gitpod.yml](.gitpod.yml) tidy
- This allow us an easier to debug  and execute manually Terraform CLI istall.
- This will allow better portability fot other projects that need to install Terraform CLI

### shebang

A shebang (pronuons she-bang) tells bash script what program that will interpret the script. eg. `#!/bin/bash`

ChatGPT recommended this formant for distribution: `#!/usr/bin/env bash`

- for portability for different OS distributions.
- will search the user`s PATH for the bash executable



https://en.wikipedia.org/wiki/Shebang_(Unix)


####  Execution considerations

when executing the bash script we use the `./` shorthand notiation to execute the bash script.

eg.`./bin/stall_terraform_cli`

### Linux permissions considerations

In order to make our bash script executable we need to change linux permission for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Github Lifecycle (Before, Init, Command)

we need to be careful when using the Init because it will not run if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks