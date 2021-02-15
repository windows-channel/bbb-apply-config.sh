#!/bin/bash

# Pull in the helper functions for configuring BigBlueButton
source /etc/bigbluebutton/bbb-conf/apply-lib.sh

enableUFWRules

yq w -i $HTML5_CONFIG public.app.skipCheck true
yq w -i $HTML5_CONFIG public.app.clientTitle "MyZoneGo"
yq w -i $HTML5_CONFIG public.app.appName "MyZoneGo HTML5 Client"
yq w -i $HTML5_CONFIG public.app.copyright "©2021 MyZoneGo Inc."
yq w -i $HTML5_CONFIG public.kurento.autoShareWebcam true
yq w -i $HTML5_CONFIG public.kurento.skipVideoPreview true
yq w -i $HTML5_CONFIG public.chat.startClosed true

apt-get -qq install wget
wget -nv https://live.myzonego.com/favicon.ico -O /var/www/bigbluebutton-default/favicon.ico
