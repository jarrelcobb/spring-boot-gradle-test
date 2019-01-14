FROM gradle:5.1.0-jdk11 as builder
COPY --chown=gradle:gradle . /source
WORKDIR /source
RUN gradle build

FROM openjdk:11-jdk-slim
ENV PORT 8080
EXPOSE 8080
COPY --from=builder /source/build/libs/*.jar /opt/app.jar
WORKDIR /opt
CMD ["java", "-jar", "app.jar"]