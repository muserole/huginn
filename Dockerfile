FROM ruby
WORKDIR /app
COPY . /app
RUN bundle install
ENV CI true
ENV CONTAINER_HOSTNAME "service-65ec6cc5ee24a2bdfb71f844"
