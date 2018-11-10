class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name 
      t.integer :role

      t.timestamps
    end
  end
end
