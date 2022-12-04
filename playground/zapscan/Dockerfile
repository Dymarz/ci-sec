FROM owasp/zap2docker-stable:latest

USER root
COPY ./wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh
USER zap
