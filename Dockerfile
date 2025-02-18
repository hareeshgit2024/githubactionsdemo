# Stage 1: Build the application
FROM maven:3.8.4-openjdk-22 AS builder

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and make it executable
COPY mvnw /app/mvnw
RUN chmod +x /app/mvnw

# Copy the Maven build files to cache dependencies
COPY pom.xml ./
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:22-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/githubactionsdemo-0.0.1-SNAPSHOT.jar /app/githubactionsdemo.jar

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "githubactionsdemo.jar"]
