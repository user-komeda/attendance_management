class ChangeDatatypeAttendances < ActiveRecord::Migration[6.1]
  def up
    change_column :attendances, :attendance_time, :time
    change_column :attendances, :date, :date
    change_column :attendances, :start_time, :time
    change_column :attendances, :end_time, :time
    change_column :attendances, :end_default_time, :time
    change_column :attendances, :rest_time, :time
    change_column :attendances, :actual_time, :time
    change_column :attendances, :overtime, :time
    add_index :attendances, :user_id
  end

  def down
    change_column :attendances, :attendance_time, :string
    change_column :attendances, :date, :datetime
    change_column :attendances, :start_time, :datetime
    change_column :attendances, :end_time, :datetime
    change_column :attendances, :end_default_time, :datetime
    change_column :attendances, :rest_time, :datetime
    change_column :attendances, :actual_time, :datetime
    change_column :attendances, :overtime, :datetime
  end
end
