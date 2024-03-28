# Use a Java 11 base image
FROM tomcat:jre11

# Set the working directory inside the container
RUN mv webapps webapps2
RUN mv webapps.dist webapps

# Copy the JAR file into the container
ADD target/spring-1.jar /usr/local/tomcat/webapps
RUN chmod 777 /usr/local/tomcat/webapps/spring-1.jar
EXPOSE 8080
# Command to run the application when the container starts
CMD ["catalina.sh", "run"]
