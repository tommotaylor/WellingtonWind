class User < ActiveRecord::Base
  has_many :favourites, -> { order (:list_order) }
  validates_presence_of :name
  validates_presence_of :password_digest
  validates_presence_of :email
  validates_uniqueness_of :email
end