class User < ActiveRecord::Base
  has_many :favourites, -> { order (:list_order) }
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  has_secure_password
end