#!/bin/sh

( while true; do /usr/sbin/pwrstatd; done ) &
/usr/src/pwrstat-exporter/pwrstat-exporter 
