class WordpressInstance < ActiveRecord::Base
  belongs_to :user
  validates :url, presence: true
  validates :user, presence: true
  validates :api_key, presence: true
end
