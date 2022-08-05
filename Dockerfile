FROM debian:10-slim

RUN apt-get update
RUN apt install -y mono-complete cron unzip curl wget tmux

RUN mkdir /terraria-server && \
    mkdir -p /root/.local/share/Terraria/tModLoader/Worlds && \
    mkdir -p /terraria-server/steamapps/workshop/content/1281930

WORKDIR /terraria-server

#Get always latest tModLoader an add executable rights for shell scripts
RUN curl -LO https://github.com/tModLoader/tModLoader/releases/latest/download/tModLoader.zip && \
    unzip -o tModLoader.zip && \
    rm tModLoader.zip

COPY start-server.sh .
COPY worlds /root/.local/share/Terraria/tModLoader/Worlds
COPY mods /terraria-server/steamapps/workshop/content/1281930
COPY serverconfig.txt .

RUN chmod +x ./*.sh && \
    chmod +x ./LaunchUtils/*.sh

# Start Server 
ENTRYPOINT ["./start-server.sh"]
