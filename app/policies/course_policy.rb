class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # na razie wszyscy widzą wszystkie kursy
    end
  end

  def show?
    true # każdy może zobaczyć kurs
  end

  def new?
    user.present? && (user.instructor? || user.admin?)
  end

  def create?
    user.present? && (user.instructor? || user.admin?)
  end

  def update?
    user.present? && (user.admin? || (user.instructor? && record.instructor == user))
  end

  def destroy?
    user.present? && (user.admin? || (user.instructor? && record.instructor == user))
  end
end