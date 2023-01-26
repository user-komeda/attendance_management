# AttendancesController
class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    @attendances = Attendance.where(user_id: @user.id)

    @attendances
  end

  def new; end

  def edit; end

  def create
    @attendance = current_user.attendance.build(user_params)

    if @attendance.save

      redirect_to action: :index

    else

      render 'index'

    end
  end

  def update
    @attendances = Attendance.find('4')

    if @attendance.save

      redirect_to @attendance

    else

      render 'edit'

    end
  end

  def user_params
    params.require(:attendance).permit(:start_time, :end_time, :attendances_time, :date, :end_default_time, :rest_time,
                                       :actual_time, :overtime, :attendances_flag)
  end
end
