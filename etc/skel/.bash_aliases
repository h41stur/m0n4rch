###########################
# CUSTOM ALIASES
###########################

alias bat="bat --theme Dracula"
alias ta="tmux a -t"
alias tnew="tmux new -s"
alias tte="tmuxinator edit"
alias tts="tmuxinator start"
alias tenv="grep setenv ~/.tmux/tmux.conf --color"
alias checkip="while :; do clear; curl ip-api.com; sleep 30; done"
alias untar="tar -zxvf"
alias grep='grep --color'
alias ls="exa -lh --icons  --classify --sort=ext --group-directories-first -S --color-scale"
alias lr="exa -lR  --classify --sort=ext --group-directories-first -S --color-scale"
alias https='openssl s_client -connect'
alias aliasconf='vim ~/.bash_aliases'
alias knockpy='python3 /opt/knock/knockpy.py'
alias photon='python3 /opt/Photon/photon.py'
alias sudomy='/opt/Sudomy/sudomy'
alias jsscanner='python3 /opt/JSScanner/JSScanner.py'
alias xnLinkFinder='python3 /opt/xnLinkFinder/xnLinkFinder.py'
alias sqlmap='python3 /opt/sqlmap-dev/sqlmap.py'
alias weather="curl https://wttr.in"
alias theHarvester="python3 /opt/theHarvester/theHarvester.py"
complete -W "\$(gf -list)" gf
