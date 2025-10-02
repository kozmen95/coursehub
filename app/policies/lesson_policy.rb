class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.instructor?
        scope.all
      else
        scope.all # tu możesz zawęzić np. tylko do potwierdzonych kursów, gdzie user jest zapisany
      end
    end
  end

  def show?
    true # każdy może podejrzeć lekcję, ewentualnie zawęzić do zapisanych studentów
  end

  def create?
    user.admin? || (user.instructor? && record.course.instructor == user)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
