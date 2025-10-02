# app/models/enrollment.rb
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }
  validates :user_id, uniqueness: { scope: :course_id }
  validate :course_has_capacity, on: :create

  private


 def course_has_capacity
    return unless course.present? && course.capacity.present?
    if course.full?
      errors.add(:base, "Brak miejsc w tym kursie 🚫")
    end
  end
end