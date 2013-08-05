class Report
  class GenerationError < StandardError; end

  include ActiveModel::Model

  validates :wp_installation, presence: true

  attr_accessor :wp_installation, :updates
  delegate :name, to: :wp_installation
  delegate :url, to: :wp_installation

  def initialize *args
    super
    self.updates ||= []
  end

  def core_updates
    updates.select { |u| u.name == 'core' }
  end

  def plugin_updates
    updates.reject { |u| u.name == 'core' }
  end

  def updates_available?
    plugin_updates.present? || core_updates.present?
  end

  def generate
    generate!
  rescue GenerationError
    false
  end

  def generate!
    process_updates raw_updates
    self
  rescue Exception => e
    raise GenerationError.new(e.message)
  end

  private
  def client
    @client ||= WPUpdaterAPIClient.new(wp_installation.url, wp_installation.api_key)
  end

  def raw_updates
    client.available_updates.with_indifferent_access
  end

  def process_updates(raw_updates)
    self.updates += raw_updates[:core].map { |u| process_core_update u }
    self.updates += raw_updates[:plugins].map { |u| process_plugin_update u }
  end

  def process_core_update(data)
    Update.new(data.merge name: 'core')
  end

  def process_plugin_update(data)
    data[:name] = data.delete(:plugin)
    Update.new(data)
  end

end
