FROM openjdk:17-jdk AS build

# Instalação do Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget -q -P /tmp https://services.gradle.org/distributions/gradle-7.4-bin.zip && \
    unzip -d /opt /tmp/gradle-7.4-bin.zip && \
    rm /tmp/gradle-7.4-bin.zip

WORKDIR /app

COPY . .

# Uso do Gradle Wrapper
RUN /opt/gradle-7.4/bin/gradle clean build

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /app/build/libs/*.jar /app/app.jar

WORKDIR /app

ENTRYPOINT ["java", "-jar", "app.jar"]
