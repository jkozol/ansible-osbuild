#!/bin/bash
set -euxo pipefail

BASEDIR=/tmp/ansible-osbuild

# Install some basic packages.
dnf -y install git python3 python3-pip 
pip3 install wheel
pip3 install ansible

# Clone the latest testing code
rm -rf $BASEDIR
git clone https://github.com/osbuild/ansible-osbuild $BASEDIR

# Write out a basic hosts file.
echo "[deployer]" > ${BASEDIR}/hosts.ini
echo "localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3" >> ${BASEDIR}/hosts.ini

# Run the playbook
export ANSIBLE_CONFIG=${BASEDIR}/ansible.cfg
ansible-playbook -i ${BASEDIR}/hosts.ini ${BASEDIR}/playbook.yml
