FROM owasp/zap2docker-stable

USER root
COPY ./wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh
USER zap
