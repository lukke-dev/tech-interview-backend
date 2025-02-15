require 'sidekiq/api'

class MarkAbandonedCartsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'mark_abandoned_cart'

  def perform
    Carts::Repositories::UpdateAbandonedCartsRepository.new.execute
  end
end
