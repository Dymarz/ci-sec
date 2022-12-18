FROM ruby

RUN apt-get update && apt-get upgrade -y
RUN apt-get install chromium chromium-driver -y
RUN apt-get install libffi-dev
RUN gem update
RUN gem install selenium-webdriver \
                webdrivers \
                rspec \
                ffi

COPY ./wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

WORKDIR /app
COPY . .