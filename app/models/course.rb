  # app/models/course.rb
  class Course < ApplicationRecord
    belongs_to :instructor, class_name: "User"

    has_one_attached :cover_image

    has_many :lessons, dependent: :destroy
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments, source: :user

    validates :title, presence: true
    validates :capacity, numericality: { greater_than: 0 }, allow_nil: true
    validates :price_cents, numericality: { greater_than: 0 }
    accepts_nested_attributes_for :lessons, allow_destroy: true

    def confirmed_count
      enrollments.confirmed.count
    end
    def full?
      enrollments.confirmed.count >= capacity
    end
  end
