class Task < ApplicationRecord

  #關係處理
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings
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

  #Tag 相關方法擴充
  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks if Tag.find_by(name: name) 
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
