# https://junegunn.kr/2016/07/fzf-git/
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 80% "$@" --border
}

function gfi() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ |
  fzf-down --ansi --multi --preview-window "right:70%" \
    --preview 'git l --color=always $(echo {} | cut -d" " -f1) | head -'$LINES
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window "right:70%" \
    --preview 'git show --color=always {} | head -'$LINES
}

gc() {
  is_in_git_repo || return
  git l --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

gbr() {
  is_in_git_repo || return
  git branch -D $(gb)
}

gbs() {
  is_in_git_repo || return
  git checkout $(gb)
}

gcs() {
  is_in_git_repo || return
  git show $(gc)
}

bind '"\er": redraw-current-line'
bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
