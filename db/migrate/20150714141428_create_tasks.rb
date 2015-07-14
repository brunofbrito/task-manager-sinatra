class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |table|
      table.string :title
      table.string :status
      table.timestamps null: false
    end
  end
end