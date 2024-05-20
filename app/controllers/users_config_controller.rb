# UsersConfigController
class UsersConfigController < ApplicationController
  before_action :authenticate_user!

  def edit
    @config = UserConfig.find_or_initialize_by(user_id: current_user.id)
  end

  def create
    @config = current_user.user_config.build(user_params)
    if @config.save
      redirect_to attendances_path
    else
      render :edit
    end
  end

  def update
    @config = UserConfig.find_or_initialize_by(user_id: current_user.id)
    if config.update(answer_params)
      redirect_to attendance_path
    else
      render :edit
    end
  end
end
