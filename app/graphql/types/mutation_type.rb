Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  # TODO: Remove me
  field :testField, types.String do
    description 'An example field added by the generator'
    resolve ->(_obj, _args, _ctx) {
      'Hello World!'
    }
  end

  field :createAuthor, function: Mutations::CreateAuthor.new
  field :updateAuthor, function: Mutations::UpdateAuthor.new
  field :deleteAuthor, function: Mutations::DeleteAuthor.new

  field :logout, types.Boolean do
    resolve ->(_obj, _args, ctx) { Session.where(key: ctx[:session_key]).destroy_all }
  end
end
