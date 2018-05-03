Types::AuthorType = GraphQL::ObjectType.define do
  name 'AuthorType'

  field :first_name, !types.String do
    description 'authors first name'
  end
  field :last_name, types.String
  field :birth_year, types.Int
  field :is_alive, types.Boolean
  field :id, types.ID

  field :full_name, types.String
  field :personel_data, types.String do
    description 'show data of an author'
    resolve ->(obj, _args, _ctx) do
      "#{obj.first_name} #{obj.last_name}, born #{obj.birth_year}"
    end
  end
end
