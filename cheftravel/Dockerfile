FROM ruby:2.7.5

# Put all this application's files in a directory called /src.
# This directory name is arbitrary and could be anything.
ADD . /src
WORKDIR /src

# Run this command. RUN can be used to run anything. In our
# case we're using it to install our dependencies.
RUN bundle install

# Tell Docker to listen on port 4567.
EXPOSE 4567

# Tell Docker that when we run "docker run", we want it to
# run the following command:
CMD ["/bin/bash"]
