class Task < ApplicationRecord
    has_and_belongs_to_many :roles, :join_table => :tasks_roles
    has_and_belongs_to_many :users, :join_table => :task_users

    
end
