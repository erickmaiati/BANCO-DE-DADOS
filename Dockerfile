# Multi-stage Dockerfile for the erp-system backend
# Build stage
FROM maven:3.9.6-eclipse-temurin-25 as build
WORKDIR /workspace
COPY pom.xml mvnw mvnw.cmd .mvn/ ./
COPY src ./src
# Use Maven to build the project (skip tests for faster image build)
RUN mvn -B -DskipTests package

# Runtime stage
FROM eclipse-temurin:25-jre
WORKDIR /app
ARG JAR_PATH=target/*.jar
COPY --from=build /workspace/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
