module Mutations
  class CreateAuthor < GraphQL::Function
    argument :author, Types::AuthorInputType

    type Types::AuthorType

    def call(_obj, args, _ctx)
      Author.create args[:author].to_h
    end
  end
end
