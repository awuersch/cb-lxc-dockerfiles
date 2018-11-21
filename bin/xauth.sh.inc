#
# source this file on a remote server connected to via ssh -X or ssh -XC
# before starting docker containers using X11 via "run_this_remote"
#
XAUTH=/tmp/.docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | sudo xauth -f $XAUTH nmerge -
sudo chmod 700 $XAUTH
sudo chown debian:debian /tmp/.docker.xauth
