FROM  maven:3.8.4-openjdk-11 AS Build

WORKDIR /apps

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package


FROM tomcat:8.5.76-jdk11-openjdk-slim as Deploy

COPY --from=Build apps/target/*.war  /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["catalina.sh", "run"]
