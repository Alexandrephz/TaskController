class Task < ApplicationRecord
    has_and_belongs_to_many :roles, :join_table => :tasks_roles
    has_and_belongs_to_many :users, :join_table => :task_users
    has_many :comments, dependent: :destroy


    before_create :set_default_status

    private
  
    def set_default_status
      self.task_status ||= true
    end
  end