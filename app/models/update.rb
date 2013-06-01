class Update
  include ActiveModel::Model

  validates :name, presence: true
  validates :installed, presence: true
  validates :current, presence: true

  attr_accessor :name, :installed, :current

  def persisted?
    false
  end
end
