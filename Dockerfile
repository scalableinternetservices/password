# Create ruby environment and dependencies. Postgres
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential apt-utils 
RUN apt-get install -y postgresql-client
RUN apt-get install -y yarn
RUN gem install bundler


# Create the working directory
RUN mkdir /password
WORKDIR /password
COPY Gemfile /password/Gemfile
COPY Gemfile.lock /password/Gemfile.lock
RUN bundle install
COPY . /password

# Create an entrypoint to be started everytime. Needed because of a rails issue according to Docker
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN brew services start postgresql
RUN rake db:setup
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
