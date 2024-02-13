#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Download Updates

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login "${STEAMUSER}" \
				+app_update "${STEAMAPPID}" \
				+quit

sed -i -e "s/{{SERVER_HOSTNAME}}/${PALWORLD_SERVERNAME}/g" \
	-e "s/{{SERVER_PW}}/${PALWORLD_SERVERPASSWORD}/g" \d
	-e "s/{{SERVER_ADMIN_PW}}/${PALWORLD_ADMINPW}/g" \
	-e "s/{{SERVER_MAXPLAYERS}}/${PALWORLD_MAXPLAYERS}/g" "${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini" \


# Switch to server directory
cd "${STEAMAPPDIR}"

# Start Server
./PalServer.sh \
	-port=${PALWORLD_PORT} \
	-players=${PALWORLD_MAXPLAYERS} \
	-useperfthreads \
    -NoAsyncLoadingThread \
    -UseMultithreadForDS \
    -publicip=${PALWORLD_PUBLICIP} \
    -publicport=${PALWORLD_PUBLICPORT} \
    ${PALWORLD_COMMUNITY_SERVER:+"EpicApp=PalServer"} \
	"${PALWORLD_ADDITIONAL_ARGS}"