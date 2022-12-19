FROM ruby

RUN apt-get update && apt-get install curl chromium chromium-driver -y
RUN gem install selenium-webdriver rspec

COPY ./wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

WORKDIR /app
COPY . .

RUN mkdir ./results

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]