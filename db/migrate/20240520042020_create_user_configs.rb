class CreateUserConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_configs do |t|
      t.belongs_to :user
      t.datetime :default_start_time
      t.datetime :default_end_time
      t.datetime :default_rest_time
      t.datetime :default_total_working_hours
      t.datetime :default_monthly_salary
      t.timestamps
    end
  end
end
