FROM dspace/dspace:dspace-7_x-jdk11-test

EXPOSE 8080

CMD ["catalina.sh", "run"]

