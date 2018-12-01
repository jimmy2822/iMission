require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:user) { User.create(email: 'aaa', password: '1234') }

  before do
    visit "/login"
    fill_in "email", with: "aaa"
    fill_in "password", with: "1234"
    click_button "確認送出"
  end

  scenario "Open task list" do
    visit "/tasks"

    expect(page).to have_text("新增任務")
  end

  scenario "Create a Task" do
    visit "/tasks"
    
    click_link "新增任務"
    fill_in "task_title", with: "Rspec Testing Task"
    fill_in "task_description", with: "Testing description"
    fill_in "task_tag_list", with: "testing"
    select "進行中", from: "task_state"
    select "高", from: "task_priority"
    
    click_button "新增任務"
    expect(page).to have_text("新增任務成功")
  end

  scenario "Read a Task" do
    visit "/tasks"
    
    click_link "新增任務"
    fill_in "task_title", with: "Rspec Testing Task"
    fill_in "task_description", with: "Testing description"
    fill_in "task_tag_list", with: "testing"
    select "進行中", from: "task_state"
    select "高", from: "task_priority"
    
    click_button "新增任務"

    click_link "檢視"
    expect(page).to have_link("回到任務列表")
  end

  scenario "Update a Task" do
    click_link "新增任務"
    fill_in "task_title", with: "Rspec Testing Task"
    fill_in "task_description", with: "Testing description"
    fill_in "task_tag_list", with: "testing"
    select "進行中", from: "task_state"
    select "高", from: "task_priority"
    click_button "新增任務"

    click_link "編輯"
    fill_in "task_title", with: "編輯任務囉"
    
    click_button "更新任務"
    expect(page).to have_text("更新任務成功")
  end

  scenario "Delete a Task", :js => true  do
    click_link "新增任務"
    fill_in "task_title", with: "Rspec Testing Task"
    fill_in "task_description", with: "Testing description"
    fill_in "task_tag_list", with: "testing"
    select "進行中", from: "task_state"
    select "高", from: "task_priority"
    click_button "新增任務"

    click_link "刪除"
    accept_alert

    expect(page).to have_text("刪除任務成功")
  end

  describe "order by Created time" do
    let!(:old_task) { Task.create!(title: "old task", created_at: 1.day.ago, user: user) }
    let!(:new_task) { Task.create!(title: "new task", created_at: 1.day.from_now, user: user) }

    scenario "asc" do
     visit "/tasks?created_at=desc" 
      
     click_link "任務建立日期"
     results = page.all("table tbody tr .created_at").map(&:text)
     expect(results).to match_array([old_task.created_at.to_s, new_task.created_at.to_s])
    end
  end

  describe "order by Deadline" do
    let!(:old_task) { Task.create!(title: "old task", deadline: 1.day.ago, user: user) }
    let!(:new_task) { Task.create!(title: "new task", deadline: 1.day.from_now, user: user) }

    scenario "asc" do
     visit "/tasks?deadline=desc" 
      
     click_link "任務截止日期"
     results = page.all("table tbody tr .deadline").map(&:text)
     expect(results).to match_array([old_task.deadline.to_s, new_task.deadline.to_s])
    end
  end

  describe "Querying" do
    let!(:target_task) { Task.create!(title: "taskNo.1", state: 2, deadline: 1.day.ago, user: user) }
    let!(:target_task_2) { Task.create!(title: "taskNo.2", state: 1, deadline: 1.day.ago, user: user) }

    scenario "querying" do
      visit "/tasks"
      fill_in "title", with: "taskNo.1"
      select "已完成", from: "search_state"
      click_button "搜尋"

      results = [page.all("table tbody tr .title").map(&:text), page.all("table tbody tr .state").map(&:text)]
      expect(results).to match_array([[target_task.title.to_s], [I18n.t("states.#{target_task.state.to_s}")]])
    end
  end
    
  describe "order by Priority" do
    let!(:low_task) { Task.create!(title: "low task", priority: 0, user: user) }
    let!(:high_task) { Task.create!(title: "high task", priority: 2, user: user) }

    scenario "asc" do
     visit "/tasks?priority=desc" 
      
     click_link "任務優先度"
     results = page.all("table tbody tr .priority").map(&:text)
     expect(results).to match_array([I18n.t("priorities.#{low_task.priority.to_s}"), I18n.t("priorities.#{high_task.priority.to_s}")])
    end
  end
end
