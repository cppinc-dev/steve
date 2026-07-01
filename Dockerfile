FROM eclipse-temurin:21-jre
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ=UTC
WORKDIR /app
EXPOSE 8080
EXPOSE 8443

COPY target/steve.war /app/steve.war

CMD ["java", "-XX:MaxRAMPercentage=85", "-Dspring.profiles.active=docker,mysql", "-jar", "steve.war"]