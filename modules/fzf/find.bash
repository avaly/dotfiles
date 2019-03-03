ff() {
  find * \
    -name node_modules -prune -o \
    -iname "*$1*" -print 2> /dev/null \
    | fzf +m
}
