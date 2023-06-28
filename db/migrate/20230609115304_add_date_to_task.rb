class AddDateToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :start_date, :date
    add_column :tasks, :end_date, :date
    add_column :tasks, :repeat_task, :boolean
    add_column :tasks, :frequency, :string
    add_column :tasks, :due_date, :date
  end
end
