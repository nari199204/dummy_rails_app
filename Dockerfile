# Use an official Ruby image as a base image
FROM ruby:3.3.6

# Install system dependencies (Node.js, Yarn, PostgreSQL client)
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  postgresql-client

# Set the working directory inside the container
WORKDIR /dummy_app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the entire Rails app into the container
COPY . .

# Precompile assets for production (optional)
# RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose port 3000 to the outside world
EXPOSE 3000

# Command to start the Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
