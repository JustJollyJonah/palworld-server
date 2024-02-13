###########################################################
# Dockerfile that builds a Palworld Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="jonah.vandenbos@gmail.com"

ENV STEAMAPPID 2394010
ENV STEAMAPP palworld
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY etc/entry.sh "${HOMEDIR}/entry.sh"
COPY etc/DefaultPalWorldSettings.ini "${STEAMAPPDIR}/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	# Add entry script
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/* 

FROM build_stage AS bullseye-base

ENV PALWORLD_SERVERNAME="New \"${STEAMAPP}\" Server" \
    PALWORLD_SERVERDESC="New \"${STEAMAPP}\" Server" \
	STEAMUSER="anonymous" \
    PALWORLD_PORT=8211 \
    PALWORLD_MAXPLAYERS=32 \
    PALWORLD_ADMINPW="changeme" \
    PALWORLD_SERVERPASSWORD="changeme" \
    PALWORLD_PUBLICPORT=8211 \
    PALWORLD_PUBLICIP="0.0.0.0" \
    PALWORLD_COMMUNITY_SERVER="False" \
    PALWORLD_ENABLERCON="False" \
    PALWORLD_RCONPORT=25575 \
	PALWORLD_DIFFICULTY="None" \
	PALWORLD_ENABLE_RAIDING="False" \
    PALWORLD_ADDITIONAL_ARGS=""

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# 27015/udp = game traffic
# 27015/tcp = rcon traffic
EXPOSE 25575/tcp \
	8211/udp