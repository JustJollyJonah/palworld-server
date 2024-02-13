#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Download Updates

bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "${STEAMAPPDIR}" \
				+login "${STEAMUSER}" \
				+app_update "${STEAMAPPID}" \
				+quit

sed -i -e "s/{{SERVER_NAME}}/${PALWORLD_SERVERNAME}/g" \
	-e "s/{{SERVER_PW}}/${PALWORLD_SERVERPASSWORD}/g" \
	-e "s/{{SERVER_ADMIN_PW}}/${PALWORLD_ADMINPW}/g" \
	-e "s/{{SERVER_DIFFICULTY}}/${PALWORLD_DIFFICULTY}/g" \
	-e "s/{{SERVER_RAIDING}}/${PALWORLD_ENABLE_RAIDING}/g" \
	-e "s/{{SERVER_ENABLE_RCON}}/${PALWORLD_ENABLERCON}/g" \
	-e "s/{{SERVER_RCON_PORT}}/${PALWORLD_RCONPORT}/g" \
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