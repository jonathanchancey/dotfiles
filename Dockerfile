FROM opensuse/tumbleweed

RUN zypper dup --skip-interactive --no-confirm

RUN zypper install --skip-interactive --no-confirm \
    git
    ansible
    python3.12
    python312-pip

RUN mkdir $HOME/git

RUN git clone https://github.com/jonathanchancey/dotfiles $HOME/git/dotfiles

WORKDIR $HOME/git/dotfiles

RUN git checkout eerie-fog

