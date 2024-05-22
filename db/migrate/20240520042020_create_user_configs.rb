class CreateUserConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_configs do |t|
      t.belongs_to :user
      t.string :name
      t.datetime :default_start_time
      t.datetime :default_end_time
      t.datetime :default_rest_time
      t.integer :default_total_working_hours
      t.integer :default_normal_hourly_rate
      t.integer :default_late_night
      t.integer :default_monthly_salary
      t.integer :employment_status
      t.integer :gender
      t.timestamps
    end
  end
end
