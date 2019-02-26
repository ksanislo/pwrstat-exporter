# pwrstat-exporter
CyberPower pwrstat to prometheus exporter.


Run via docker with:

docker run --privileged -v /dev/usb/hiddev0:/dev/usb/hiddev0 -p 9546:9546 ksanislo/pwrstat-exporter
