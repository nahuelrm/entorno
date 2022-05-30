#!/bin/sh

sudo modprobe v4l2loopback devices=1 card_label="OBS Cam" \  exclusive_caps=1
