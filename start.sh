#!/bin/sh

echo -e "Launching server..."
/home/pzserver/start-server.sh -servername ${SERVERNAME} -serverpassword ${SERVERPASSWORD}  -steamport1 ${STEAMPORT1} -steamport2 ${STEAMPORT2} -adminpassword ${ADMINPASSWORD}
