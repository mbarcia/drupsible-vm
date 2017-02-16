# Update the box
apt-get -y update
apt-get -y install linux-headers-$(uname -r) build-essential
apt-get -y install zlib1g-dev libssl-dev libreadline-gplv2-dev libffi-dev
apt-get -y install curl unzip

# Add Ansible
apt-get -y install git python python-dev python-setuptools python-pip python-netaddr
# Make sure setuptools are installed crrectly.
pip install --upgrade pip
pip install setuptools setupext-pip --upgrade
pip install cryptography --upgrade
pip install paramiko PyYAML Jinja2 httplib2 six markupsafe
pip install ansible==2.0.2.0
# Add Debops
pip install debops

# Set up sudo
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant

# Tweak sshd to prevent DNS resolution (speed up logins)
echo 'UseDNS no' >> /etc/ssh/sshd_config

# Remove 5s grub timeout to speed up booting
cat <<EOF > /etc/default/grub
# If you change this file, run 'update-grub' afterwards to update
# /boot/grub/grub.cfg.

GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_DISTRIBUTOR=`lsb_release -i -s 2> /dev/null || echo Debian`
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
GRUB_CMDLINE_LINUX="debian-installer=en_US"
EOF

update-grub
