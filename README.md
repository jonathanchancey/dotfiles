# Minimal openSUSE Tumbleweed dotfiles

![](https://github.com/jonathanchancey/assets/blob/main/images/suse-wsl.png)

## Some Quick Essentials
```bash
xi neovim ranger net-tools-deprecated openssh bind-utils
```


```bash
mkdir ~/.config/ansible-vault
vim ~/.config/ansible-vault/vault.secret
chmod 600 ~/.config/ansible-vault/vault.secret
```

To then encrypt values with your vault password use the following:

```bash
ansible-vault encrypt_string --vault-password-file $HOME/.config/ansible-vault/vault.secret "mynewsecret" --name "MY_SECRET_VAR"

cat myfile.conf | ansible-vault encrypt_string --vault-password-file $HOME/.config/ansible-vault/vault.secret --stdin-name "myfile"
```

Uses the Ansible dotfiles strategy from [TechDufus](https://github.com/TechDufus/dotfiles/)
