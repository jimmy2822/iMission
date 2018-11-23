class User < ApplicationRecord
  #建立關係
  has_many :tasks
  #驗證欄位相關
  validates :email, presence: true, uniqueness: true
  #使用 Rails 內建密碼安全處理 Bcrypt
  has_secure_password

  #使用者權限劃分
  enum role: {
    normal: 0,
    admin: 99
  }, _prefix: :role_check
end
