class LessonReminderWorker
  include Sidekiq::Worker

  def perform(lesson_id)
    lesson = Lesson.find_by(id: lesson_id)
    return unless lesson

    lesson.course.enrollments.confirmed.includes(:user).each do |enrollment|
      LessonMailer.reminder_email(enrollment.user, lesson).deliver_now
      Rails.logger.info "📧 Reminder sent to #{enrollment.user.email} for lesson #{lesson.title}"
    end
  end
end