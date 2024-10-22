FROM openjdk:17
ARG WAR_FILE=target/trioffice-0.0.1-SNAPSHOT.war
COPY ${WAR_FILE} app.war
ENTRYPOINT ["java","-jar","-Dspring.profiles.active=prod","/app.war"]