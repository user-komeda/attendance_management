# AttendancesControllerF
class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user

    @attendances = Attendance.where(user_id: @user.id)

    @attendances
  end

  def edit
    @attendances = Attendance.find(params[:id])
  end

  def create
    @attendance = current_user.attendance.build(user_params)

    if @attendance.save

      redirect_to action: :index

    else

      render 'index'

    end
  end

  def update
    @attendances = Attendance.find(params[:id])

    @attendances.assign_attributes(update_parameters)

    if @attendances.save

      redirect_to action: :index, status: :see_other

    else

      render 'index'

    end
  end

  def user_params
    params.require(:attendance).permit(
      :id, :start_time, :end_time, :attendances_time, :date, :end_default_time,
      :rest_time, :actual_time, :overtime, :attendances_flag
    )
  end

  def update_parameters
    params.require(:attendance).permit(:end_time, :actual_time)
  end
end
