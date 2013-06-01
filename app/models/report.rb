class Report
  include ActiveModel::Model

  validates :wp_installation, presence: true

  attr_accessor :wp_installation, :updates
  delegate :name, to: :wp_installation

  def initialize *args
    super
    self.updates = []
  end

  def core_updates
    updates.select { |u| u.name == 'core' }
  end

  def plugin_updates
    updates.reject { |u| u.name == 'core' }
  end

  def generate
    client = WPUpdaterAPIClient.new(wp_installation.url,
                                    wp_installation.api_key)
    begin
      raw_updates = client.available_updates.with_indifferent_access
    rescue Exception => e
      return false
    end
    process_updates(raw_updates)
    true
  end

  private
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
