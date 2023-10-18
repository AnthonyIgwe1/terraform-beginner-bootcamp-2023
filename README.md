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

https://www.gitpod.io/docs/configure/workspaces/tasks



### working with Env vars

we can list out all Environmental variable (Env Vars) usinf `env` command

we can filter specific env vars using eg. `env | grep AWS_`

### setting and Unsetting Env Vars

In the terminal we can set using `export HELLO=`world`

In the terminal we can unset using `unset HELLO`

we can set env var temporaly when just running a command

```sh
HELLO=`world` ./bin/print_message
```
within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO=`world

echo $HELLO
```

### Printing Vars

we can print an env var using echo eg, `echo $HELLO`

### Scoping of Env Vars

when you opennew bash terminals in VScode it will not be aware of env that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that open your need to set env varsin your bash profile eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod secrets storage.

```
gp env HELLO=world`
```

All future worlspaces launched will set the env vars for all bash terminals opened in workspaces.

You can also set env Vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)

[Getting started in aws installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html
we can check if our AWS credentials is configured correctly by the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If its successful you should see a json playload return that looks like this:

```json
{
    "UserId": "AIDA3F2DPAKAF2R2A6KVZ",
    "Account": "768403767936",
    "Arn": "arn:aws:iam::768403767936:user/terraform-beginner-bootcamp"
}

we will need to generate AWS CLI credits from IAM user in order to use AWS CLI.

## Terraform Basics


### Terraform registry

Terraform sources their providers and modules from the terraform reigistry which located at [registry.terraform.io](http://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to refactor or make large amount of terraform code modular, protable and sharable.

[Random terraform providers](https://registry.terraform.io/providers/hashicorp/random)


### Terraform console

We can see a list of all terraform commands by simply typing `terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan
`terraform plan`

This will genrate out a changeset, about the state of our infrastructure and what will be changed.

we can output this changeset ie."plan" to be passed to an apply, but often you can just ignore outputting.

### Terraform apply

`terraform plan`

This will run a plan and pass the chageset to be executed by terraform, apply should prompt us yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform app,y --auto-approve`

#### Terraform destroy

`terraform destroy`
This will destroy resources.

you can also use auto approve flag to skip the approve prompt eg. `terraform apply --auto-approve`


### Terraform lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

### Terraform state files

`terraform.tfstate` contain  information about the current state of your infrastructure.

This files **should not be committed** to your VCS.

This file can contain sensitive date.

If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previuos state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers

## issues with terraform cloud login and gitpod workspace

when attempting to run `terraform login` it will launch bash a wiswig view to generate a token. However it does not work expected in gitpod Vscode in the browser.

The workaround is manually generate a yoken in terraform cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:
```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```
Provide the following  code (replace your token in the file):
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
``````