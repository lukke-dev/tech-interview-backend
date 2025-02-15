module Carts
  module Repositories
    class CreateCartRepository
      def execute
        Carts::CartEntity.create
      end
    end
  end
end