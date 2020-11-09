class User < ApplicationRecord
  has_secure_password
  has_many :menu_items
end
