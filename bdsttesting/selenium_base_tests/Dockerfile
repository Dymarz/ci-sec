FROM python

RUN pip3 install selenium

RUN selenium install chromedriver

COPY tests/* user/src/app/

COPY wait-for-it.sh /usr/src/app
RUN chmod +x /usr/src/app/wait-for-it.sh

RUN mkdir -p /results

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]