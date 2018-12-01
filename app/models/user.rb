class User < ApplicationRecord
  #建立關係
  has_many :tasks, :dependent => :destroy
  #驗證欄位相關
  validates :email, presence: true, uniqueness: true
  #使用 Rails 內建密碼安全處理 Bcrypt
  has_secure_password
  #管理員刪除的 callback 處理
  before_destroy :admin_exist_check

  #使用者權限劃分
  enum role: {
    normal: 0,
    admin: 99
  }

  private

  #管理員剩餘一人不可刪除
  def admin_exist_check
    throw :abort if User.where(role: 99).count <= 1
  end
end
