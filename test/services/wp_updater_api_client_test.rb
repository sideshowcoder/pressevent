require 'test_helper'

describe WPUpdaterAPIClient do

  describe 'valid api key' do
    before do
      VCR.insert_cassette "report_localhost_valid_key"
      url = 'http://localhost:9292'
      api_key = 'ijX9nOdkfdjKvuXzqS3bzqL5jAMYkFwe'
      @client = WPUpdaterAPIClient.new(url, api_key)
    end
    after { VCR.eject_cassette }

    it 'gets updates from remote' do
      updates = @client.available_updates
      updates[:plugins].must_equal [{"plugin"=>"Akismet", "installed"=>"3.0.2", "current"=>"3.0.3"}]
    end

    it 'gets an empty list if no updates are available' do
      updates = @client.available_updates
      updates[:core].must_be :empty?
    end
  end

  describe "invalid api key" do
    before do
      VCR.insert_cassette "report_localhost_invalid_key"
      url = 'http://localhost:9292'
      api_key = 'invalid_key'
      @client = WPUpdaterAPIClient.new(url, api_key)
    end

    after { VCR.eject_cassette }

    it "does raise an error" do
      -> { @client.available_updates }.must_raise WPUpdaterAPIClient::InvalidCredentialsException
    end
  end
end
