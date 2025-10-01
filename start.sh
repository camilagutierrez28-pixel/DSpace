#!/bin/sh
set -e

echo "Start script: looking for server.xml to patch port..."

# Si PORT no está seteado, por defecto usamos 8080
: "${PORT:=8080}"

# Buscamos server.xml en lugares razonables (primero en tomcat, luego en todo el contenedor)
CANDIDATES="/usr/local/tomcat/conf/server.xml /opt/tomcat/conf/server.xml /usr/local/apache-tomcat/conf/server.xml"
FILE=""

for f in $CANDIDATES; do
  if [ -f "$f" ]; then
    FILE="$f"
    break
  fi
done

# Si no lo encontramos en rutas comunes, buscamos en todo el sistema (silenciando errores)
if [ -z "$FILE" ]; then
  FILE=$(find / -type f -name server.xml 2>/dev/null | head -n 1 || true)
fi

if [ -n "$FILE" ]; then
  echo "Patching $FILE to use port $PORT"
  # Hacemos la sustitución del atributo port="8080" -> port="$PORT"
  sed -i "s/port=\"8080\"/port=\"$PORT\"/g" "$FILE"
else
  echo "Warning: server.xml not found; Tomcat may still listen on 8080"
fi

echo "Starting Tomcat..."
# Ejecuta el comando estándar de DSpace/Tomcat
exec catalina.sh run
