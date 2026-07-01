FROM eclipse-temurin:21-jdk AS builder
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ=UTC
ARG DB_IP
ARG DB_PORT
ARG DB_SCHEMA
ARG DB_USER
ARG DB_PASSWORD
WORKDIR /build
COPY . /build
# Run the Maven package ONCE during 'docker build'
RUN ./mvnw clean package -Pdocker,mysql -DskipTests

FROM eclipse-temurin:21-jre
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV TZ=UTC
WORKDIR /app
EXPOSE 8180
EXPOSE 8443
COPY --from=builder /build/target/steve.war /app/steve.war
# Start the application instantly using environment variables at runtime
CMD ["java", "-XX:MaxRAMPercentage=85", "-Dspring.profiles.active=docker,mysql", "-jar", "steve.war"]