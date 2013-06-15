class User < ActiveRecord::Base
  has_many :wp_installations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.with_autochecking_installations
    joins(:wp_installations)
    .where(wp_installations: { auto_checking: true })
    .uniq
  end

  def installations_need_checking
    wp_installations.with_autochecking
  end
end
