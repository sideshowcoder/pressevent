class WPInstallation < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  validates :user, presence: true
  validates :api_key, presence: true

  def self.with_autochecking
    where(auto_checking: true)
  end
end
