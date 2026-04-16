#!/bin/sh

if [ "$WEATHER_APP_MONITORING" != "ACTIVE" ]; then
  echo "Warning: Environment variable WEATHER_APP_MONITORING is not set to 'ACTIVE'." >&2
fi
