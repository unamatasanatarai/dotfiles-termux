export PATH="$HOME/bin:$PATH"
# Start sshd if not already running
pgrep -x sshd > /dev/null || sshd


USERNAME=$(whoami)
DEVICE_IP=$(ip -4 addr show | awk '/inet / && !/127\.0\.0\.1/ {print $2}' | cut -d/ -f1 | grep '^192\.168' | head -n1)
SSH_PORT=8022
echo "ssh ${USERNAME}@${DEVICE_IP} -p ${SSH_PORT}"
echo "scp -P $SSH_PORT <FROM> ${USERNAME}@${DEVICE_IP}:~/storage/downloads" 
