#!/bin/sh

crond -f -l 8 &

exec java -jar app.jar
