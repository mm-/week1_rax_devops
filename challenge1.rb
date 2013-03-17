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



# The start of our numbering suffix ie: web1, and the amount of servers
# that we're going to create and number that way, in this case 3
suffix = 1
server_limit = 3

until suffix > server_limit
	# Create the servers name out of the label and suffix we specified
	server_name = server_label+suffix.to_s

	# Actually go out and build the server with our label, suffix, image and flavor from above
	server = connection.servers.create(:name => server_name, :flavor_id => flavor_id, :image_id => image_id)

	# Grab the password for our newly created server	
	password = server.password

	puts server_name
	puts "----------------------"
	puts "Username: root"
	puts "Password: "+password
	puts
	
	suffix +=1
end


	
