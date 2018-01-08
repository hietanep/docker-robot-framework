FROM fedora:27

MAINTAINER Xyllix
LABEL description Robot Framework in Docker.

VOLUME /opt/robotframework/reports
VOLUME /opt/robotframework/tests

ENV SCREEN_COLOUR_DEPTH 24
ENV SCREEN_HEIGHT 1080
ENV SCREEN_WIDTH 1920

RUN dnf upgrade -y\
	&& dnf install -y\
		chromedriver-63.0.3239.108-1.fc27\
		chromium-63.0.3239.108-1.fc27\
		firefox-57.0-0.8.fc27\
		python2-pip-9.0.1-11.fc27\
		which-2.21-4.fc27\
		xorg-x11-server-Xvfb-1.19.5-1.fc27\
		wget\
	&& dnf clean all

RUN pip install robotframework==3.0.2\
	robotframework-seleniumlibrary==3.0.0\
	robotframework-selenium2library==3.0.0\
	robotframework-httplibrary==0.4.2\
	robotframework-faker==4.0.0

ADD drivers/geckodriver-v0.19.1-linux64.tar.gz /opt/robotframework/drivers/

COPY bin/chromedriver.sh /opt/robotframework/bin/chromedriver
COPY bin/chromium-browser.sh /opt/robotframework/bin/chromium-browser
COPY bin/run-tests-in-virtual-screen.sh /opt/robotframework/bin/

ARG DIR_RF=/opt/robotframework/tests
ARG GIT_URL=http://ptgit:10080/ptturva/rf-testit/repository/archive.zip?ref=master
RUN cd $DIR_RF
RUN wget --no-check-certificate -O master.zip $GIT_URL
RUN unzip $DIR_RF/master.zip
RUN rm $DIR_RF/master.zip

# FIXME: below is a workaround, as the path is ignored
RUN mv /usr/lib64/chromium-browser/chromium-browser /usr/lib64/chromium-browser/chromium-browser-original\
	&& ln -sfv /opt/robotframework/bin/chromium-browser /usr/lib64/chromium-browser/chromium-browser

ENV PATH=/opt/robotframework/bin:/opt/robotframework/drivers:$PATH

#CMD ["run-tests-in-virtual-screen.sh"]