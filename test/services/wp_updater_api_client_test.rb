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
      updates[:core].wont_be_nil
      updates[:plugins].wont_be_nil
    end

    it 'gets the core version' do
      @client.core_version.wont_be_nil
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
