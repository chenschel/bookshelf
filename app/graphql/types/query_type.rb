Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :testField, types.String do
    argument :name, types.String, 'Enter your name'
    description 'An example field added by the generator'
    resolve ->(_obj, args, _ctx) {
      "Hello #{args[:name]}!"
    }
  end

  field :author, Types::AuthorType do
    argument :id, types.ID, 'Author DB ID'
    description 'One Author'
    resolve ->(_obj, args, _ctx) {
      Author.find(args[:id])
    }
  end

  field :all_authors, types[Types::AuthorType] do
    description 'All authors'
    resolve ->(_obj, _args, _ctx) {
      Author.all
    }
  end

  field :login, types.String do
    description 'authenticate an user and returns a session key'

    argument :email, types.String, 'Users email address'
    argument :password, types.String, 'Users password'

    resolve ->(_obj, args, _ctx) {
      user = User.where(email: args[:email]).first
      user.sessions.create.key if user.try(:authenticate, args[:password])
    }
  end
end
