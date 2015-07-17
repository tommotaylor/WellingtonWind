class User < ActiveRecord::Base
  has_many :favourites, -> { order (:list_order) }
end