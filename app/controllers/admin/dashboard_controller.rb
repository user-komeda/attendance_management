module Admin
  # DashboardController
  class DashboardController < ApplicationController
    def index
      authorize :dashboard, :view?
      render 'admins/dashboard/index'
    end
  end
end
