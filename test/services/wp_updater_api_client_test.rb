require 'test_helper'

describe WPUpdaterAPIClient do

  describe 'with updates available' do
    before do
      VCR.insert_cassette 'wp-updater-api'
      url = 'http://wp-test.dev'
      api_key = 'U3sMgZPcClgFkvR486dIQZ6cDynhHYlk'
      @client = WPUpdaterAPIClient.new(url, api_key)
    end

    after do
      VCR.eject_cassette
    end

    it 'gets updates from remote' do
      updates = @client.available_updates
      expected_core = [{ "installed" => "3.5", "current" => "3.5.1" }]
      expected_plugins = [{ "plugin" => "Akismet",
                            "installed" => "2.5.6",
                            "current" => "2.5.7"}]
      updates[:core].must_equal expected_core
      updates[:plugins].must_equal expected_plugins
    end

    it 'gets the core version' do
      @client.core_version.must_equal "installed" => "3.5", "current" => "3.5.1"
    end
  end

  describe "invalid api key" do
    before do
      VCR.insert_cassette "wp-updater-api-invalid-key"
      url = 'http://wp-test.dev'
      api_key = 'invalid_key'
      @client = WPUpdaterAPIClient.new(url, api_key)
    end

    it "does raise an error" do
      -> { @client.available_updates }.must_raise WPUpdaterAPIClient::InvalidCredentialsException
    end
  end

  describe 'with no updates available' do
    before do
      VCR.insert_cassette 'filmspieler-updater-api'
      url = 'http://filmspieler.com'
      api_key = 'zYTGNmya0aO6pconi1LmHLyONovKu5sN'
      @client = WPUpdaterAPIClient.new(url, api_key)
    end

    after do
      VCR.eject_cassette
    end

    it 'gets an empty list if no updates are available' do
      updates = @client.available_updates
      updates[:core].must_be :empty?
      updates[:plugins].must_be :empty?
    end
  end

end
