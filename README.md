# ansible-scaffold-terraform

Local ansible playbook to set up Terraform/Terragrunt configurations for an AWS account.

Let's say you have an AWS account that you've nicknamed "testo". The `setup` role creates a dir called `testo` with a structure like this:

```
brock@host:~/terraform/testo$ tree
.
├── README.md
├── osu-testo-terragrunt-policies
│   ├── README.md
│   └── terraform.tfvars
├── osu-testo-terragrunt-state
│   ├── README.md
│   └── terraform.tfvars
├── terraform-modules
│   ├── terragrunt-policies
│   │   ├── input.tf
│   │   └── main.tf-example
│   └── terragrunt-state-role
│       ├── input.tf
│       └── main.tf
└── terraform.tfvars
```

## Configuration

In `host_vars/127.0.0.1`:

```
---
terraform_config_home: /home/changeme/terraform
configs:
  testo: osu-testo-terragrunt
  project: osu-project-terragrunt
terragrunt_state:
  aws_region: us-east-2
```

## Usage

```
$ ansible-playbook setup.yml
```
