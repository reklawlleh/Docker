FROM debian:10-slim

RUN apt-get update
RUN apt install -y mono-complete cron unzip curl wget tmux

RUN mkdir /terraria-server && \
    mkdir -p /root/.local/share/Terraria/tModLoader/Worlds && \
    mkdir -p /terraria-server/steamapps/workshop/content/1281930 &&\
    mkdir -p /root/.local/share/Terraria/tModLoader/Mods

WORKDIR /terraria-server

#Get always latest tModLoader an add executable rights for shell scripts
RUN curl -LO https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip && \
    unzip -o tModLoader.zip && \
    rm tModLoader.zip  && \
    chmod +x ./*.sh && \
    chmod +x ./LaunchUtils/*.sh

COPY start-server.sh .
COPY worlds /root/.local/share/Terraria/tModLoader/Worlds
COPY mods /root/.local/share/Terraria/tModLoader/Mods
COPY serverconfig.txt .

# Start Server 
ENTRYPOINT ["./start-server.sh"]
