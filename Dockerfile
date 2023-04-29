FROM ubuntu:22.10 AS jenkins-build
RUN apt-get update
RUN apt-get install -y gnupg curl
RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
RUN apt-get update
RUN apt-get install -y openjdk-11*
RUN apt-get install -y jenkins


FROM ubuntu:latest AS apache-build
RUN apt-get update
RUN apt-get install -y apache2

FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y systemctl
COPY --from=jenkins-build /var/lib/jenkins /var/lib/jenkins
COPY --from=apache-build /etc/init.d/apache2 /etc/init.d/apache2
EXPOSE 8080 80
RUN /etc/init.d/apache2 restart
