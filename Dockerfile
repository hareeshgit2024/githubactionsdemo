# Use Eclipse Temurin JDK 17 as base image
FROM openjdk:22-jdk

# Set working directory
WORKDIR /app

# Copy Maven Wrapper scripts and the .mvn directory
COPY mvnw ./
COPY .mvn/ .mvn/
RUN chmod +x mvnw

# Copy the Maven build files to cache dependencies


COPY pom.xml .
COPY src ./src

# Build the application
RUN ./mvnw package -DskipTests

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/githubactionsdemo-0.0.1-SNAPSHOT.jar"]
