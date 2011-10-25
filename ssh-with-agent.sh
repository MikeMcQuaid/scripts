#!/bin/sh
# If no SSH agent can be found create one and add default keys.
# This can either be used standalone as an SSH wrapper or aliased to ssh/scp.

check_ssh_agent() {
	[ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent) && ssh-add
}

[ -z "$SSH_COMMAND" ] && SSH_COMMAND="ssh"
check_ssh_agent
$SSH_COMMAND $@
