Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # TODO: Remove me
  field :testField, types.String do
    description 'An example field added by the generator'
    resolve ->(_obj, _args, _ctx) {
      'Hello World!'
    }
  end

  field :createAuthor, Types::AuthorType do
    argument :first_name, types.String
    argument :last_name, types.String
    argument :birth_year, types.Int
    argument :is_alive, types.Boolean

    resolve ->(_obj, args, _ctx) do
      Author.create args.to_h
    end
  end
end
