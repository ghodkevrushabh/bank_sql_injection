FROM tomcat:9.0

RUN rm -rf /usr/local/tomcat/webapps/*

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
    -O /usr/local/tomcat/lib/mysql-connector-j.jar && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
