class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  #使用 Rails 內建密碼安全處理
  has_secure_password
end
