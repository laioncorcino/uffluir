FROM openjdk:17-jdk AS build

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget -q https://services.gradle.org/distributions/gradle-7.4-bin.zip && \
    unzip -d /opt gradle-7.4-bin.zip && \
    rm gradle-7.4-bin.zip

ENV GRADLE_HOME=/opt/gradle-7.4
ENV PATH=$PATH:/opt/gradle-7.4/bin

WORKDIR /app

COPY . .

RUN ./gradlew clean build

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/build/libs/*.jar /app/app.jar

WORKDIR /app

ENTRYPOINT ["java", "-jar", "app.jar"]
