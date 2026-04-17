FROM maven:3.8.6-amazoncorretto-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM amazoncorretto:17-alpine
WORKDIR /app

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
COPY log4j2-weather.yml log4j2-weather.yml
COPY application.properties application.properties

COPY check_env.sh .
COPY weather-app-cron .
COPY entrypoint.sh .

RUN chmod +x check_env.sh entrypoint.sh

RUN crontab weather-app-cron

ENV WEATHER_APP_MONITORING=DEACTIVATE

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
