# UserConfig
class UserConfig < ApplicationRecord
  belongs_to :user
  enum gender: { male: 1, female: 2, other: 3 }
  enum employment_status: { regular_employee: 1, contract_employee: 2, part_time_job: 3 }
end
