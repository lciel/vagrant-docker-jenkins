FROM ubuntu:14.04
MAINTENER Shunichi Matsuda "louis@jubilee.works"

# Install packages
RUN mkdir /setup
ADD ./install_packages.sh /setup/install_packages.sh
RUN /setup/install_packages.sh && rm -rf /setup

ENV JENKINS_HOME /jenkins
ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
CMD [""]
