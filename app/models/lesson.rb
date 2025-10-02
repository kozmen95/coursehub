class Lesson < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :date, presence: true
  has_many_attached :materials

  after_create :schedule_reminder

  private

  def schedule_reminder
    # 1 godzinę przed rozpoczęciem lekcji
    LessonReminderWorker.perform_at(self.date - 1.hour, self.id)
  end
end