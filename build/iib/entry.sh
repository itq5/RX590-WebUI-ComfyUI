#!/bin/sh


cd /root/git/sd-webui-infinite-image-browsing

# listen on 0.0.0.0 in docker
sed -i s/'default_host = '".*"/'default_host = '\"0.0.0.0\"/ app.py

# set defaults for port and extra_paths if set as env variables
if [ -z "$PORT" ]; then
  PORT="8080"
fi

ARG_EXTRA_PATHS=""
if [ -z "$EXTRA_PATHS" ]; then
  EXTRA_PATHS="/comfyui"
fi

# display variables
echo "variables set as follows:"
echo "PORT = $PORT"
echo "EXTRA_PATHS = $EXTRA_PATHS"
echo "EXTRA_OPTIONS = $EXTRA_OPTIONS"
#echo "HOST = $HOST"
echo

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
python app.py --port=$PORT --extra_paths="$EXTRA_PATHS" --sd_webui_config="/applib/config.json" $EXTRA_OPTIONS
