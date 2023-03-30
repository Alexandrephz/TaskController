class CreateTasksRoles < ActiveRecord::Migration[7.0]
  def change
    create_table(:tasks_roles , :id => false) do |t|
      t.references :task
      t.references :role
    end
    add_index(:tasks_roles, [ :task_id, :role_id ])
  end
end
