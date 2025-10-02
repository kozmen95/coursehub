admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password"
  u.role = :admin
end

inst = User.find_or_create_by!(email: "instructor@example.com") do |u|
  u.password = "password"
  u.role = :instructor
end

stud = User.find_or_create_by!(email: "student@example.com") do |u|
  u.password = "password"
  u.role = :student
end

3.times do |i|
  c = Course.find_or_create_by!(title: "Kurs #{i+1}", instructor: inst) do |course|
    course.description = "Opis kursu #{i+1}"
    course.capacity    = 12 + i
    course.price_cents = 19900
    course.published   = true
  end

  3.times do |j|
    Lesson.find_or_create_by!(course: c, starts_at: (Time.current + (j+1).days).change(hour: 18), ends_at: (Time.current + (j+1).days).change(hour: 19)) do |l|
      l.location = "Sala #{j+1}"
    end
  end

  Enrollment.find_or_create_by!(user: stud, course: c) { _1.status = :confirmed }
end

puts "Seed ready. Logins: admin@ / instructor@ / student@ (hasło: password)"
