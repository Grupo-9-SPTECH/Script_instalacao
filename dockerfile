# container java
FROM openjdk:11-jre
#caminho
COPY . /tech-health-api-java-1.0-SNAPSHOT-jar-with-dependencies.jar
#rodar no terminal
CMD ["java", "-jar", "tech-health-api-java-1.0-SNAPSHOT-jar-with-dependencies.jar"]