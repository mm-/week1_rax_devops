require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

# Distro and size of the servers we're going to build
# In this case centos 6.3 on 512MB servers
image_id = 'c195ef3b-9195-4474-b6f7-16e5bd86acd0'
flavor_id = '2'

# Name of the servers, will be iterated ie: web1, web2, web3
server_label = 'web'


# Create a connection
connection = Fog::Compute.new({
	:provider		=> 'Rackspace',
	:version		=> :v2,
#	:rackspace_region	=> :dfw,
})



# The start of our numbering ie: web1, and the amount of servers
# that we're going to create and number that way, in this case 3
suffix = 1
server_limit = 3

until suffix > server_limit
	server_name = server_label+suffix.to_s

	server = connection.servers.create(:name => server_name, :flavor_id => flavor_id, :image_id => image_id)
	
	puts "Creating"+server_name

	suffix +=1
end


	
