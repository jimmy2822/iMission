class Task < ApplicationRecord
  enum state: { 
    未完成: 0,
    進行中: 1,
    已完成: 2
  }

  enum priority: {
    一般: 0,
    中等: 1,
    緊急: 2
  }
end
