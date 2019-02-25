ff() {
  find * \
    -name node_modules -prune -o \
    -name "*$1*" -print 2> /dev/null \
    | fzf +m
}
