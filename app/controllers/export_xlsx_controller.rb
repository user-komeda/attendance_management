# ExportXlsxController
class ExportXlsxController < ApplicationController
  def export_xlsx
    send_data(create_data.stream.read, filename: 'attendance.xlsx')
  end

  private

  def create_data
    data_list = get_data
    work_book = RubyXL::Workbook.new
    sheet = work_book[0]
    header_list = Attendance.column_names
    header_list.each_with_index do |d, i|
      sheet.add_cell(0, i, d)
    end

    data_list.each_with_index do |d, i|
      sheet.add_cell(i + 1, 0, d.id)
      sheet.add_cell(i + 1, 1, d.user_id)
      sheet.add_cell(i + 1, 2, d.attendance_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 3, d.date)
      sheet.add_cell(i + 1, 4, d.start_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 5, d.end_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 6, d.end_default_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 7, d.rest_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 8, d.actual_time&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 9, d.overtime&.strftime('%H:%M'))
      sheet.add_cell(i + 1, 10, d.approval_flag)
    end
    work_book
  end

  def get_data
    @attendances = Attendance.all
  end
end
