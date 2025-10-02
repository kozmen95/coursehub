CourseHub

Link: https://coursehub-i10h.onrender.com/

CourseHub to aplikacja napisana w Ruby on Rails 8, służąca do zarządzania kursami online.
Instruktorzy mogą tworzyć kursy i lekcje, studenci zapisywać się na zajęcia, a administratorzy zarządzać całym systemem.

🚀 Technologie

Ruby 3.4

Rails 8

PostgreSQL – baza danych

Sidekiq + Redis – kolejki zadań asynchronicznych

Devise – uwierzytelnianie użytkowników

TailwindCSS – frontend

Letter Opener / SMTP – obsługa maili

🛠 Funkcjonalności

Rejestracja i logowanie (Devise)

Role użytkowników:

👨‍💻 Admin – pełny dostęp, zarządzanie użytkownikami i zapisami

👩‍🏫 Instruktor – tworzenie kursów i lekcji

🎓 Student – zapisy na kursy, przegląd lekcji

Kursy i lekcje (z datami, lokalizacją, limitem miejsc)

Zapisy i statusy (pending, confirmed, cancelled)

Asynchroniczne zadania (Sidekiq) – np. przypomnienia mailowe

Panel administracyjny dla Sidekiq

Seed z przykładowymi danymi

⚡️ Instalacja lokalna
Wymagania

Ruby 3.4

Bundler

PostgreSQL

Redis

Kroki
# 1. Sklonuj repo
git clone https://github.com/kozmen95/coursehub.git
cd coursehub

# 2. Zainstaluj gemy
bundle install

# 3. Skonfiguruj bazę (edytuj config/database.yml)
# a następnie:
rails db:create db:migrate db:seed

# 4. Odpal serwer
bin/dev


Aplikacja będzie działać pod:
👉 http://localhost:3000

Dane logowania po seedzie

Admin: admin@example.com / password

Instruktor: instructor@example.com / password

Student: student@example.com / password

☁️ Deploy na Render

Projekt jest gotowy do uruchomienia na Render.
W ustawieniach serwisu dodaj zmienne środowiskowe:

DATABASE_URL – connection string do PostgreSQL

REDIS_URL – connection string do Redis

RAILS_MASTER_KEY – klucz z config/master.key

RAILS_ENV=production

Build Command
bundle install; bundle exec rake db:migrate; bundle exec rake db:seed; bundle exec rake assets:precompile; bundle exec rake assets:clean;

Start Command
bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-production}

🔧 Sidekiq

Dashboard Sidekiq dostępny pod /sidekiq (tylko dla adminów).

📬 Mailing

Dev: Letter Opener (/letter_opener)

Prod: SMTP (do skonfigurowania w config/environments/production.rb)