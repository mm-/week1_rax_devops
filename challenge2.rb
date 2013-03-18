require 'fog'

# Set our custom fog credentials file:
ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

# Size of the servers we're going to build
flavor_id = '2'

# Server UUID to build our image from
server_id = '71356c7a-c9ae-4e44-a47e-92f90363ee8b'

# Create a connection
connection = Fog::Compute.new({
	:provider		=> 'Rackspace',
	:version		=> :v2,
#	:rackspace_region	=> :dfw,
})

# Our original server to clone from, using the UUID provided above
original_server = connection.servers.get server_id

puts "Creating image..."

# Image the the server the server for cloning
image = original_server.create_image "#{original_server.name}-clone"

# Wait for our image to go from SAVING to ACTIVE
image.wait_for { ready? }

# Grab the UUID of our image
image_id = image.id

puts "Building clone from image..."

# Actually build our clone with the previously created image
server = connection.servers.create(:name => "#{original_server.name}-clone", :flavor_id => flavor_id, :image_id => image_id)

# Grab the password for our new server
server_password = server.password

puts "Waiting for IP to be comissioned.."

# Uses the fog wait_for to wait until the IP address is comissioned.
server.wait_for { !addresses["public"].nil?}

# The above wait_for leaves our ipv4 addy still uncommissioned, sadface
until server.ipv4_address.length > 0
        server.reload
end

# Sets the server ip finally using the now non-empty ipv4_address
server_ip = server.ipv4_address

# Grab server name of the new clone
server_name = server.name

# Throw back the details for our new clone
	puts "Clone details:"
	puts
        puts server_name
        puts "---------------"
        puts "Username: root"
        puts "Password: "+server_password
        puts "IP: "+server_ip
        puts


