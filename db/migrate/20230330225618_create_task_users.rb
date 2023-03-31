class CreateTaskUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:task_users, :id => false) do |t|
      t.references :task
      t.references :user
    end
    add_index(:task_users, [ :task_id, :user_id ])
  end
end
