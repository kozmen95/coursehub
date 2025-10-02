# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Użyj nowego, jasnego zapisu z nazwą atrybutu jako pierwszym argumentem
  enum :role, { student: 0, instructor: 1, admin: 2 }

  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :instructor_courses, class_name: "Course", foreign_key: :instructor_id

   has_one_attached :avatar
end
