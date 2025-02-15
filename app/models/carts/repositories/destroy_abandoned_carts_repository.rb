module Carts
  module Repositories
    class DestroyAbandonedCartsRepository
      def execute
        Carts::CartEntity.where("carts.abandoned = true AND carts.updated_at < ?", Time.now - 7.days).destroy_all
      end
    end
  end
end