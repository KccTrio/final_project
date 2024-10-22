FROM openjdk:17-jdk-slim

# 비대화식 모드 설정
ENV DEBIAN_FRONTEND=noninteractive

# tzdata 설치
RUN apt-get update && apt-get install -y tzdata

# 시간대 설정
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG WAR_FILE=target/trioffice-0.0.1-SNAPSHOT.war
COPY ${WAR_FILE} app.war

# Java 애플리케이션 실행 시 시간대 설정
ENTRYPOINT ["java", "-Duser.timezone=Asia/Seoul", "-jar", "-Dspring.profiles.active=prod", "/app.war"]