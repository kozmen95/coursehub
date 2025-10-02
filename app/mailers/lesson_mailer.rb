class LessonMailer < ApplicationMailer
  default from: "no-reply@coursehub.com"

  def reminder_email(user, lesson)
    @user = user
    @lesson = lesson
    mail(
      to: @user.email,
      subject: "📚 Przypomnienie: Lekcja '#{lesson.title}' zaczyna się wkrótce!"
    )
  end
end
