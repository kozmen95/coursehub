class TestWorker
  include Sidekiq::Worker

  def perform(name)
    Rails.logger.info "Witaj #{name}, działa Sidekiq! 🚀"
    puts "Witaj #{name}, działa Sidekiq! 🚀"
  end
end