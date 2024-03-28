# Use a Java 11 base image
FROM tomcat:jre11

# Set the working directory inside the container
RUN mv webapps webapps2
RUN mv webapps.dist webapps
RUN mkdir webapps/fajri
# Copy the JAR file into the container
COPY target/spring-1.jar /usr/local/tomcat/webapps/fajri
EXPOSE 8080
# Command to run the application when the container starts
CMD ["catalina.sh", "run"]
