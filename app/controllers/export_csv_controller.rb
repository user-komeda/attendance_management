# ExportCsvController
class ExportCsvController < ApplicationController
  require 'csv'
  def export_csv
    columuns_name = Attendance.column_names
    data = export_get_data
    csv_data = CSV.generate do |csv|
      csv << columuns_name
      data.each do |a|
        columuns_value = [
          a.id,
          a.user_id,
          a.attendance_time,
          a.date,
          a.start_time,
          a.end_time,
          a.end_default_time,
          a.rest_time,
          a.actual_time,
          a.overtime,
          a.approval_flag
        ]
        csv << columuns_value
      end
    end
    send_data(csv_data, filename: 'attendance.csv')
  end

  private

  def export_get_data
    @attendances = Attendance.all
  end
end
