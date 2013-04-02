require 'fog'
require 'trollop'


ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'


# Accept --ip and --fqdn as arguments
opts = Trollop::options do
  opt :ip, "IP address for A record", :type => :string
  opt :fqdn, "FQDN to add the record for", :type => :string

end

ip = opts[:ip]
fqdn = opts[:fqdn]


#TODO Make these arguments mandatory so the script won't run without them


# Connect to RSC DNS
dns = Fog::DNS.new({
    :provider => 'Rackspace',
    #:rackspace_email => 'mithofrose@gmail.com',
                 })


# Create the zone
zone = dns.zones.create(
    :domain => "#{fqdn}",
    :email => 'lol@topseller.org'
)

# Create the record
record = zone.records.create(
    :value => "#{ip}",
    :name => "#{fqdn}",
    :type => 'A'
)


