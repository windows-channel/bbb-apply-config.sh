#!/bin/bash

# Pull in the helper functions for configuring BigBlueButton
source /etc/bigbluebutton/bbb-conf/apply-lib.sh

enableUFWRules

yq w -i $HTML5_CONFIG public.app.listenOnlyMode false
yq w -i $HTML5_CONFIG public.app.skipCheck true
yq w -i $HTML5_CONFIG public.app.clientTitle "MyZoneGo"
yq w -i $HTML5_CONFIG public.app.appName "MyZoneGo HTML5 Client"
yq w -i $HTML5_CONFIG public.app.copyright "©2021 MyZoneGo Inc."
yq w -i $HTML5_CONFIG public.kurento.autoShareWebcam true
yq w -i $HTML5_CONFIG public.kurento.skipVideoPreview true
yq w -i $HTML5_CONFIG public.chat.startClosed true
yq w -i $HTML5_CONFIG public.layout.autoSwapLayout true

apt-get -qq install wget
wget -nv https://bbb-assets.nyc3.cdn.digitaloceanspaces.com/favicon.ico -O /var/www/bigbluebutton-default/favicon.ico
wget -nv https://bbb-assets.nyc3.cdn.digitaloceanspaces.com/guest-wait/index.html -O /var/www/bigbluebutton/client/guest-wait-customized.html

sudo sed -i 's/^defaultGuestWaitURL=.*/defaultGuestWaitURL=\${bigbluebutton\.web\.serverURL}\/client\/guest-wait-customized\.html/' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^beans.presentationService.defaultUploadedPresentation=.*/beans.presentationService.defaultUploadedPresentation=https:\/\/bbb-assets\.nyc3\.cdn\.digitaloceanspaces\.com\/default-presentation\.jpg/' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^defaultWelcomeMessage=.*/defaultWelcomeMessage=Bienvenido a <b>\%\%CONFNAME\%\%<\/b>!<br><br>Para unirte al canal de audio haz clic en el bot\&oacute;n del tel\&eacute;fono\. Utiliza unos auriculares para no causar ruido de fondo a los dem\&aacute;s\./' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^defaultWelcomeMessageFooter=.*/defaultWelcomeMessageFooter=Gracias por usar <a href="https:\/\/solutions\.myzonego\.com" target="_blank"><u>MyZoneGo<\/u><\/a>\./' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^meetingExpireIfNoUserJoinedInMinutes=.*/meetingExpireIfNoUserJoinedInMinutes=5/' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^meetingExpireWhenLastUserLeftInMinutes=.*/meetingExpireWhenLastUserLeftInMinutes=3/' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i 's/^allowRequestsWithoutSession=.*/allowRequestsWithoutSession=true/' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sudo sed -i $'s/proxy_set_header Connection "Upgrade";$/proxy_set_header Connection "Upgrade"; proxy_set_header Accept-Encoding ""; sub_filter_types *; sub_filter_once off; sub_filter \'\<\/head\>\' \'\<link rel="stylesheet" type="text\/css" href="https:\/\/bbb-assets\.nyc3\.digitaloceanspaces\.com\/styles\.css"\>\<\/head\>\';/g' /etc/bigbluebutton/nginx/bbb-html5.nginx
