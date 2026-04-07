FROM maven:3.9.9-eclipse-temurin-17 AS build
ADD . /app
WORKDIR /app
RUN mvn package 


FROM openjdk:17-jdk-slim  AS runtime
LABEL myproject=java
LABEL author=devops
ARG username=spc
ENV JAVA_HOME=/usr/lib/jvm/
RUN useradd -m -d /usr/share/aws -s /bin/bash ${username}
USER ${username}
WORKDIR /usr/share/aws
COPY --from=build /app/target/*.jar devi.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","devi.jar"]