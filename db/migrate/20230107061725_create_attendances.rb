class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.string :user_id
      t.string :attendance_time
      t.datetime :date
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :end_default_time
      t.datetime :rest_time
      t.datetime :actual_time
      t.datetime :overtime
      t.boolean :approval_flag
      t.timestamps
    end
  end
end
