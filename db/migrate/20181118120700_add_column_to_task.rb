class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user_id, :integer
  end
end
