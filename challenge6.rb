require 'fog'

ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

# What our container will be named on the CDN
cdn_container_name = "cdn_test"

# Establish connection
connection = Fog::Storage.new({
    :provider => 'Rackspace'
})

# Create our container with the name shown above
container = connection.directories.create(
    :key => cdn_container_name,
    :public => true
)

#TODO Error handling
#TODO argument instead of static.
