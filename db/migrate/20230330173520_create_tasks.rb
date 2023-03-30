class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :task_content
      t.date :task_expire
      t.string :task_files, array: true
      t.integer :task_urgency

      t.timestamps
    end
  end
end
