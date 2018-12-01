require 'rails_helper'

RSpec.describe Task, type: :model do
  it "Title can't be null" do
    
    new_task = Task.new(title: "")
    new_task.valid?

    expect(new_task.errors.messages[:title]).to include("不可為空白")

  end

  it "Search by title and state" do
    user = User.create(email: "123", password: "123")
    
    target_task = Task.create(title: "myTask", state: 2, user_id: user.id)
    
    results = Task.where(title: "myTask", state: 2)

    expect(results).to match_array [target_task]
  end
end
