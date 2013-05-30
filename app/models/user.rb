class User < ActiveRecord::Base
  has_many :wordpress_instances

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
