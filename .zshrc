

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


autoload -Uz is-at-least
if is-at-least 4.3.7; then
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable svn git
    zstyle ':vcs_info:git:*' formats '[%r:%b]'
    zstyle ':vcs_info:svn:*' formats '[%r]'
    zstyle ':vcs_info:*' actionformats '[%r:%b|%a]'
    preexec() {
        _pre="$1"
    }
    precmd () {
        case "${_pre}" in
            cd*|svn*|git*)
                psvar=()
                LANG=C vcs_info
                [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
                ;;
        esac
        return ${_r}
    }
    RPROMPT="%1(v|%F{default}%1v%f|)"
fi


HISTFILE=~/.zhistory
SAVEHIST=100000
HISTSIZE=10000
setopt HIST_IGNORE_DUPS

#setopt prompt_subset
autoload -U colors
colors
autoload -U compinit
compinit
setopt auto_pushd

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

# lessがeucjp扱えないのでlv
export PAGER='lv'
export LV='-Ou8'
alias less='lv'
alias source-highlight='source-highlight --failsafe'
function lvc() {
    source-highlight --infer-lang -f esc --style-file=esc.style -o STDOUT -i $1 | /usr/bin/lv -c
}
alias lv='lvc'

function ssh_screen(){
	eval server=\${$#}
	screen -t $server ssh "$@"
}
if [ x$TERM = xscreen ]; then
	alias ssh=ssh_screen
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#if [ -e ~/.keychain/$HOST-sh ]; then
#	source ~/.keychain/$HOST-sh
#else
#	keychain -q -k
#	keychain -q --nogui ~/.ssh/id_rsa.pxv id_rsa.monooki id_rsa.fluxflex
#	source ~/.keychain/$HOST-sh
#fi
#function exit() {
#	keychain -k
#	builtin exit
#}
