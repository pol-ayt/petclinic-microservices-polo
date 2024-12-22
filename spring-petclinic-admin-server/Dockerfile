FROM amazoncorretto:17
ARG JAR_FILE=/target/*.jar
COPY ${JAR_FILE} app.jar
ENV SPRING_PROFILES_ACTIVE docker,mysql
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "/app.jar"]
