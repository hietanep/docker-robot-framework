FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y python-pip python-dev gcc phantomjs firefox
RUN pip install robotframework
RUN pip install robotframework-sshlibrary
RUN pip install robotframework-selenium2library
ADD xvfb_init /etc/init.d/xvfd
RUN chmod a+x /etc/init.d/xvfb
ADD xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run