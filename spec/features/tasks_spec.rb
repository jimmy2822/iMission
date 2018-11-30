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
end
