FROM alpine:latest

# Instala dnsmasq
RUN apk add --no-cache dnsmasq

# Copia el archivo de configuración de dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf

# Expone el puerto DNS estándar (53)
EXPOSE 53/udp

# Ejecuta dnsmasq en modo foreground al iniciar el contenedor
CMD ["dnsmasq", "-k"]
