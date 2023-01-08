# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:

  # :lockable, :timeoutable, :trackable and :omniauthable

  has_many :attendance
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
