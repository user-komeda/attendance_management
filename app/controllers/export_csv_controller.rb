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
          a.attendance_time&.strftime('%H:%M'),
          a.date,
          a.start_time&.strftime('%H:%M'),
          a.end_time&.strftime('%H:%M'),
          a.end_default_time&.strftime('%H:%M'),
          a.rest_time&.strftime('%H:%M'),
          a.actual_time&.strftime('%H:%M'),
          a.overtime&.strftime('%H:%M'),
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
