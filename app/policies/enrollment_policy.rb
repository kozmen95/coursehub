class EnrollmentPolicy < ApplicationPolicy
  # tworzy student zapis do konkretnego kursu
  def create?
    user&.student?
  end

  # potwierdzanie/odrzucanie przez instruktora kursu lub admina
  def update?
    record.course.instructor == user || user&.admin?
  end

  # wypisać się może właściciel zapisu albo admin
  def destroy?
    record.user == user || user&.admin?
  end
end
