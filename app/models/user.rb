class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { student: 0, instructor: 1, admin: 2 }

  # zapisane kursy (jako student)
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  # kursy prowadzone (jako instruktor)
  has_many :taught_courses, class_name: "Course", foreign_key: :instructor_id, dependent: :destroy

  has_one_attached :avatar
end
