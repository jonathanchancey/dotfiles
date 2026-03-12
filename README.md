# dotfiles

![example neofetch on opensuse](https://github.com/jonathanchancey/assets/blob/main/images/suse-wsl.png)

## Introduction

This repo serves as a personal project and as inspiration for others.

Please don't blindly execute code.

## Docker

You can use Docker to ~~blindly execute code~~ rapidly draft Ansible config.

Testing can be as simple as:

```bash
docker build . -t dotfiles && docker run -it dotfiles
```

## Ansible

Enable/disable roles in `group_vars/all.yml`

Customize automation in the `roles/` folder. Take the `go` folder for example. In `./roles/go/tasks/` there is `main.yml` which will always run if present in `all.yml`, and `suse.yml` which will run only on distros in the Suse family.

## Credits

Uses the Ansible dotfiles strategy from [TechDufus](https://github.com/TechDufus/dotfiles/)
