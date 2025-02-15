module Products
  module Repositories
    class FindProductByIdRepository
      def execute(id:)
        Products::ProductEntity.find_by(id:)
      end
    end
  end
end