require 'xmlrpc/client'

class WPUpdaterAPIClient
  INVALID_CREDENTIAL_RESPONSES = ["Invalid API Key"]
  class InvalidCredentialsException < StandardError; end

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
    update = api_call('getCoreUpdatesAvailable')
    update.empty? ? [] : [update]
  end

  def available_plugin_updates
    api_call('getPluginUpdatesAvailable')
  end

  def core_version
    api_call('getCoreVersion')
  end

  private
  def api_call(name)
    resp = client.call(name, api_key)
    if INVALID_CREDENTIAL_RESPONSES.include? resp
      raise InvalidCredentialsException.new(resp)
    else
      resp
    end
  end
end

