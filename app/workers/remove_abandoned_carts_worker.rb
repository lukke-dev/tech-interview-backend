require 'sidekiq/api'

class RemoveAbandonedCartsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'remove_abandoned_cart'

  def perform
    Carts::Repositories::DestroyAbandonedCartsRepository.new.execute
  end
end
