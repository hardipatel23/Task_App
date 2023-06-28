class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :assignee_id
      t.integer :approver_id

      t.timestamps
    end
    add_foreign_key :tasks, :users, column: :assignee_id
    add_foreign_key :tasks, :users, column: :approver_id
  end
end
