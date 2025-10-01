FROM dspace/dspace:dspace-7_x

# Esto le indica al contenedor que habitualmente usa 8080 (informativo)
EXPOSE 8080

# Copiamos el script que parchea server.xml al arrancar
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Ejecutamos nuestro script que parchea el puerto y luego arranca Tomcat
CMD ["/start.sh"]
