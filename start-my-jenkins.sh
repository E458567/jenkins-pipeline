docker run -u root --rm -d -p 8080:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --env JAVA_OPTS="-Xmx2048m -XX:MaxPermSize=512m" my-jenkins-image
