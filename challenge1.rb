require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

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

	puts server_name

	suffix +=1
end


	
