root = "#{File.expand_path("..", Dir.pwd)}"
# The directory to operate out of.
# The default is the current directory.

#directory "#{root}"

# Load “path” as a rackup file.
# The default is “config.ru”.

#rackup "#{root}/config.ru"

# Set the environment in which the rack's app will run. The value must be a string.
# The default is “development”.

environment 'production'

# Daemonize the server into the background. Highly suggest that
# this be combined with “pidfile” and “stdout_redirect”.
# The default is “false”.

daemonize
daemonize false


# Disable request logging.
# The default is “false”.

quiet


bind 'unix:///tmp/sockets/simple_blog.sock'
