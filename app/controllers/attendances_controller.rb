class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @attendances = Attendance.find_by(user_id: @user.id)
  end

  def new; end

  def create
    @attendance = Attendance.new(params[:attendance])
    @attendance.user_id = current_user.id
    if @attendance.save
      redirect_to @attendance
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @attendances = Attendance.find('4')
    if @attendance.save
      redirect_to @attendance
    else
      render 'edit'
    end
  end
end
