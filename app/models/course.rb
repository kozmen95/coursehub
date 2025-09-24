# app/models/course.rb
class Course < ApplicationRecord
  belongs_to :instructor, class_name: "User"

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :title, presence: true
  validates :capacity, numericality: { greater_than: 0 }, allow_nil: true
end
