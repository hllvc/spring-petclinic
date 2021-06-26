FROM openjdk:latest

WORKDIR /tmp/

COPY . .

RUN ./mvnw package

EXPOSE 8080

CMD  ./mvnw spring-boot:run
