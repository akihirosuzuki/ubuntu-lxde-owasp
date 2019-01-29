# ubuntu lxde-desktop

## os

ubuntu 18.04

## desktop

LXDE

## include

* owasp zap 2.7.0
* jmetor 5.0

## Usage (example)

docker run -it -p 5901:5901 --env USER=devuser -m 2048m erwinuy/ubuntu-lxde-owasp:latest bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /home/devuser/.vnc/*.log"
