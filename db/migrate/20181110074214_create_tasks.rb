class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.integer :priority
      t.integer :state 
        
      t.timestamps
    end
  end
end
