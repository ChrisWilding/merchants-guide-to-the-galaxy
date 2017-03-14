module Merchant
  class UnknownDefinitionOrQueryService
    def handles?(node)
      node.is_a?(UnknownDefinitionOrQuery)
    end

    def process(_)
      'I have no idea what you are talking about'
    end
  end
end
