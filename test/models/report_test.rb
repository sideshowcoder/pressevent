require 'test_helper'

describe Report do
  before do
    @wp = WPInstallation.new(name: 'test',
                             url: 'http://test.com',
                             api_key: '12345')
  end

  it 'must have a associated WPInstallation' do
    Report.new.wont_be :valid?
  end

  it 'provides name' do
    Report.new(wp_installation: @wp).name.must_equal @wp.name
  end

  it 'gets updates' do
    client = mock('WPUpdaterApiClient')
    raw_updates = { core: [], plugins: [] }
    WPUpdaterAPIClient.stubs(:new).with(@wp.url, @wp.api_key).returns(client)
    client.expects(:available_updates).returns(raw_updates)
    Report.new(wp_installation: @wp).generate
  end

  describe 'are updates available' do
    before do
      @raw_updates = { core: [], plugins: [] }
      client = stub(available_updates: @raw_updates)
      WPUpdaterAPIClient.stubs(:new).with(@wp.url, @wp.api_key).returns(client)
    end

    it 'reports false for core and plugins empty' do
      Report.new(wp_installation: @wp).generate!.updates_available?.must_equal false
    end

    it 'reports true for core non-empty' do
      @raw_updates.merge! core: [{ installed: 'x', current: 'y'}]
      Report.new(wp_installation: @wp).generate!.updates_available?.must_equal true
    end

    it 'reports true for core or plugins non-empty' do
      plugin_update = { plugin: 'xyz', installed: 'x.x.x', current: 'y.y.y'}
      @raw_updates.merge! plugins: [plugin_update]
      Report.new(wp_installation: @wp).generate!.updates_available?.must_equal true
    end
  end

  describe 'generate update lists' do
    before do
      @raw_updates = { core: [], plugins: [] }
      client = stub(available_updates: @raw_updates)
      WPUpdaterAPIClient.stubs(:new).with(@wp.url, @wp.api_key).returns(client)
    end

    it 'generates update list for core' do
      @raw_updates.merge! core: [{ installed: 'x', current: 'y'}]
      report = Report.new(wp_installation: @wp)
      report.generate
      report.core_updates.any? { |u| u.name == 'core' }.must_equal true
    end

    it 'generates update list for plugins' do
      plugin_update = { plugin: 'xyz', installed: 'x.x.x', current: 'y.y.y'}
      @raw_updates.merge! plugins: [plugin_update]
      report = Report.new(wp_installation: @wp)
      report.generate
      report.plugin_updates.any? { |u| u.name == 'xyz' }.must_equal true
    end
  end
end

