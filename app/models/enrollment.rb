# app/models/enrollment.rb
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }
  validates :user_id, uniqueness: { scope: :course_id }
end
