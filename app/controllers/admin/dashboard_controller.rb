module Admin
  # DashboardController
  class DashboardController < ApplicationController
    def index
      authorize :dashboard, :view?
    end
  end
end
