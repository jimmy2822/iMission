class AddTasksIndex < ActiveRecord::Migration[5.2]
  def change
    change_table :tasks, bulk: true do |t|
      t.index :title
      t.index [:state, :priority]
    end
  end
end
