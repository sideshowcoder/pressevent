require 'xmlrpc/client'

class WPUpdaterAPIClient
  attr_accessor :api_key, :client

  def initialize(url, key)
    uri = URI(url).tap { |u|
      u.scheme = 'http' if u.scheme.empty?
      u.path = '/xmlrpc.php' if u.path.empty?
    }

    @client = XMLRPC::Client.new_from_uri(uri)
    @api_key = key
  end

  def available_updates
    { core: available_core_updates, plugins: available_plugin_updates }
  end

  def available_core_updates
    update = client.call('getCoreUpdatesAvailable', api_key)
    update.empty? ? [] : [update]
  end

  def available_plugin_updates
    client.call('getPluginUpdatesAvailable', api_key)
  end

  def core_version
    client.call('getCoreVersion', api_key)
  end
end

