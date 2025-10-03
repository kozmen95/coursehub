admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.role = :admin
end

inst = User.find_or_create_by!(email: "instructor@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
  u.role = :instructor
end

stud = User.find_or_create_by!(email: "student@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
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
    Lesson.find_or_create_by!(
      course: c,
      title: "Lekcja #{j+1} kursu #{i+1}",
      date: (Time.current + (j+1).days).to_date,  # <-- ustawiamy date
      starts_at: (Time.current + (j+1).days).change(hour: 18),
      ends_at: (Time.current + (j+1).days).change(hour: 19)
    ) do |l|
      l.location = "Sala #{j+1}"
    end
  end


  Enrollment.find_or_create_by!(user: stud, course: c) do |e|
    e.status = :confirmed
  end
end

puts "Seed ready ✅. Logins: 
- admin@example.com / password 
- instructor@example.com / password 
- student@example.com / password"
