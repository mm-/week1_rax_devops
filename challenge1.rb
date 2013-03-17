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
# that we're going to create (server_limit) and number that way, in this case 3
suffix = 1
server_limit = 3
spawned_servers = []
server_passwords = []

until suffix > server_limit
	# Create the servers name out of the label and suffix we specified
	server_name = server_label+suffix.to_s

	# Actually go out and build the server with our label, suffix, image and flavor from above
	server = connection.servers.create(:name => server_name, :flavor_id => flavor_id, :image_id => image_id)

	# Grab the password for our newly created server	
	server_passwords << server.password
	spawned_servers << server.id
		

	suffix +=1
end

suffix = 1

# Iterate through the arrays of our new server passwords and uuids
spawned_servers.zip(server_passwords).each do |server_id, password|

	# Get the correct server+suffix
	current_server = connection.servers.get server_id
	current_server.reload

	# Set the correct server_name from label and suffix
	server_name = server_label+suffix.to_s


	# Uses the fog wait_for to wait until the IP address is comissioned.
	# I seems that just waiting on the first one will throw nill errors
	# because it's not fully initialized, so we immediately wait on the 
	# first[addr] value afterwards
	current_server.wait_for { !addresses["public"].nil?}
        current_server.wait_for { !addresses["public"].first["addr"].nil?}


	# Sets the server ip finally
	server_ip = current_server.addresses["public"].first["addr"].to_s
	

	# Output the server name,password and IP to the terminal
	puts server_name
	puts "---------------"
	puts "Username: root"
	puts "Password: "+password
	puts "IP: "+server_ip
	puts

	suffix +=1

end
