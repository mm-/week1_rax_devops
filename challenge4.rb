require 'fog'
require 'trollop'


ENV['FOG_RC'] = '~/.rackspace_cloud_credentials'

opts = Trollop::options do
  opt :ip, "IP address for A record", :type => :string
  opt :fqdn, "FQDN to add the record for", :type => :string

end

ip = opts[:ip]
fqdn = opts[:fqdn]




dns = Fog::DNS.new({
    :provider => 'Rackspace',
    #:rackspace_email => 'mithofrose@gmail.com',
                 })



zone = dns.zones.create(
    :domain => "#{fqdn}",
    :email => 'lol@topseller.org'
)


record = zone.records.create(
    :value => "#{ip}",
    :name => "#{fqdn}",
    :type => 'A'
)


