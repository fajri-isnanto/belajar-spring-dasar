# Use a Java 11 base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/belajar-spring-dasar-0.0.1-SNAPSHOT.jar /app/belajar-spring-dasar-0.0.1-SNAPSHOT.jar

# Command to run the application when the container starts
CMD ["java", "-jar", "your-application.jar"]