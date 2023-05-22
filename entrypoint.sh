#!/bin/sh

# sshd wipes envs for new login sessions, so store K8s ones for kubectl
env | grep ^KUBERNETES_ >/etc/k8s-env
echo 'export $(xargs </etc/k8s-env)' > /etc/profile.d/k8s-env.sh

# adjust htop layout for machines with low CPU count
if [ $(nproc) -le 2 ]; then
  sed -i 's/CPUs2/CPUs/' /root/.config/htop/htoprc
fi

# allow this to be used with docker/kubectl run -i, or as daemonset container
if tty >/dev/null; then
  exec /bin/zsh
else
  exec /usr/sbin/sshd -eD
fi
