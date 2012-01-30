

export LANG=ja_JP.UTF8
export LC_ALL=ja_JP.UTF8
set convert-meta off set output-meta on set input-meta on
# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# シェルのプロセスごとに履歴を共有
setopt share_history
# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst


autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '[%r:%b]'
zstyle ':vcs_info:*' actionformats '[%r:%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{grey}%1v%f|)"


HISTFILE=~/.zhistory
SAVEHIST=500

#setopt prompt_subset
autoload -U colors
colors
# Con
#PROMPT="[%{${fg[white]}%}%n@%{${fg[green]}%}%d%{${fg[white]}%}%{${fg[default]}%}]%#"
PROMPT="[%{${fg[default]}%}%n@%m:%{${fg[green]}%}%(5~,%-2~/.../%2~,%~)%{${fg[default]}%}%{${fg[default]}%}]%#"

unsetopt auto_param_slash
setopt no_clobber
setopt correct correct_all
compctl -g '(|.)*(-/)' cd pushed
compctl -g '(|.)*(-/)' ls pushed

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'

alias nslookup='nslookup -sil'
#alias ls='ls -Fh'
alias reload="source ~/.zshrc"
#alias ssh='ssh -o StrictHostKeyChecking no'

export PERL_BADLANG=0
export GREP_OPTIONS="--color=auto"

function ssh_screen(){
	eval server=\${$#}
	screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
	alias ssh=ssh_screen
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -e ~/.keychain/$HOST-sh ]; then
	source ~/.keychain/$HOST-sh
else
	keychain -q -k
	keychain -q --nogui ~/.ssh/id_rsa.pxv id_rsa.monooki id_rsa.fluxflex
	source ~/.keychain/$HOST-sh
fi
function exit() {
	keychain -k
	builtin exit
}
