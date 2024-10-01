#!/bin/sh


cd /root/git/sd-webui-infinite-image-browsing

# listen on 0.0.0.0 in docker
sed -i s/'default_host = '".*"/'default_host = '\"0.0.0.0\"/ app.py


echo checking default_host line in app.py:
grep "^default_host" app.py
echo

# disable filesystem access
echo "IIB_ACCESS_CONTROL=enable" > .env
echo checking .env file:
cat .env
echo

echo checking python version
python --version
echo


echo launching app.py
python app.py --sd_webui_config="/config.json" $EXTRA_OPTIONS
