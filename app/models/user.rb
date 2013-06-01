class User < ActiveRecord::Base
  has_many :wp_installations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
