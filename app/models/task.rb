class Task < ApplicationRecord
    rolify
    has_and_belongs_to_many :roles, :join_table => :tasks_roles

end
