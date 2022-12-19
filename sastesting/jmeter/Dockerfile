FROM justb4/jmeter

USER root

COPY ./wait-for-it.sh /
RUN chmod +x /wait-for-it.sh

WORKDIR /app
COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh
RUN mkdir /results
COPY ./tests ./

ENTRYPOINT [ "./entrypoint.sh" ]