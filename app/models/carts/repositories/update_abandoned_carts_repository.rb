module Carts
  module Repositories
    class UpdateAbandonedCartsRepository
      def execute
        Carts::CartEntity.where("carts.abandoned = false AND carts.updated_at < ?", Time.now - 3.hours).update_all(abandoned: true, updated_at: DateTime.now)
      end
    end
  end
end