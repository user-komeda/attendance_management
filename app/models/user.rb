# frozen_string_literal: true

# User
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:

  # :lockable, :timeoutable, :trackable and :omniauthable

  has_many :attendance, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
