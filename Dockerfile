FROM amazonlinux:latest
RUN yum -y install aws-cli 
ARG AWS_DEFAULT_REGION 
ARG AWS_ACCESS_KEY_ID 
ARG AWS_SECRET_ACCESS_KEY 
ARG AWS_SESSION_TOKEN 
RUN echo $AWS_DEFAULT_REGION 
RUN echo $AWS_ACCESS_KEY_ID 
RUN echo $AWS_SECRET_ACCESS_KEY 
RUN echo $AWS_SESSION_TOKEN 
RUN aws sts get-caller-identity 
RUN aws secretsmanager get-secret-value --secret-id tutorials/AWSExampleSecret
# maintained by
LABEL maintainer="carelle" 

# update our OS
RUN yum -y update && yum clean all
# install apache package
RUN yum install -y httpd

# copying file to html folder
COPY index.html /var/www/html/
# port on which the container should litsen
EXPOSE 80
# run the httpd service like systemctl start httpd
ENTRYPOINT [ "/usr/sbin/httpd" ]
# run httpd service in the background
CMD [ "-D" , "FOREGROUND"]