export PATH="$HOME/bin:$PATH"
./.termux/boot/start-sshd


USERNAME=$(whoami)
DEVICE_IP=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | grep '^192.168' | head -n 1)
SSH_PORT=8022
echo "ssh ${USERNAME}@${DEVICE_IP} -p ${SSH_PORT}"
echo "scp -P $SSH_PORT <FROM> ${USERNAME}@${DEVICE_IP}:~/storage/downloads" 
