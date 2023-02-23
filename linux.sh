#!/bin/bash

echo enable-ssh-support >> $HOME/.gnupg/gpg-agent.conf

cat <<EOF >> $HOME/.bashrc
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
EOF

echo 1AD175DA64B1F7B61781A498D91B4E2A69F3879F >> $HOME/.gnupg/sshcontrol

source $HOME/.bashrc
echo "check if key is loaded:"
ssh-add -l
