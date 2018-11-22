class Task < ApplicationRecord

  #關係處理
  belongs_to :user
  #驗證相關
  validates :title, presence: true 
  #任務狀態以及優先度 Enum 設定
  enum state: { 
    created: 0,
    progressing: 1,
    completed: 2
  }

  enum priority: {
    low: 0,
    normal: 1,
    high: 2
  }

  
end
