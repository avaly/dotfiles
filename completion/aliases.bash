# kubectl
# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-bash-linux/
complete -o default -F __start_kubectl kb

# docker
# https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker
complete -F _docker dk

# docker-compose
# https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose
complete -F _docker_compose dkc
