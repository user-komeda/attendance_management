# UsersConfigController
class UsersConfigController < ApplicationController
  before_action :authenticate_user!

  def edit
    @config = UserConfig.find_or_initialize_by(user_id: current_user.id)
  end

  def create
    @config = current_user.build_user_config(config_params)
    if @config.save
      redirect_to attendances_path
    else
      render :edit
    end
  end

  def update
    @config = UserConfig.find_or_initialize_by(user_id: current_user.id)
    @config.assign_attributes(update_params)
    if @config.save
      redirect_to attendances_path
    else
      render :edit
    end
  end

  private

  def config_params
    params.require(:user_config).permit(:id, :name, :default_start_time, :default_end_time, :default_rest_time,
                                        :default_total_working_hours, :default_normal_hourly_rate, :default_late_night,
                                        :gender, :employment_status, :default_monthly_salary)
  end

  def update_params
    params.require(:user_config).permit(:name, :default_start_time, :default_end_time, :default_rest_time,
                                        :default_total_working_hours, :default_normal_hourly_rate, :default_late_night,
                                        :gender, :employment_status, :default_monthly_salary)
  end
end
