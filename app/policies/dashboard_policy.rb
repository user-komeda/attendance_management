# DashboardPolicy
class DashboardPolicy
  attr_reader :user

  # `_record` in this example will be :dashboard
  def initialize(user, _record)
    @user = user
  end

  def view?
    user.has_role? :admin
  end
end
