module Carts
  module Repositories
    class FindCartByIdRepository
      def execute(id:, includes: [])
        Carts::CartEntity.includes(includes).find_by(id:)
      end
    end
  end
end