module Mutations
  class DeleteAuthor < GraphQL::Function
    argument :id, !types.ID

    type types.Boolean

    def call(_obj, args, _ctx)
      author = Author.find(args.id)
      author.destroy
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
