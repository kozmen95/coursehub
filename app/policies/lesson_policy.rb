class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && (user.admin? || user.instructor?)
        scope.all
      else
        scope.all
        # albo tu np. scope.joins(:course).where(courses: { id: user.enrolled_course_ids }) jeśli chcesz zawęzić
      end
    end
  end

  def show?
    true
    # lub np. user.present? && (user.admin? || user.instructor? || record.course.students.include?(user))
  end

  def create?
    admin? || (instructor? && record.course.instructor == user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
