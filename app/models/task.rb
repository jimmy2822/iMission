class Task < ApplicationRecord
  validates :title, presence: true 
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
