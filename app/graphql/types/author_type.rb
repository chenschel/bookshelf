Types::AuthorInputType = GraphQL::InputObjectType.define do
  name 'AuthorInputType'
  description 'Properties for create and update an Author'

  argument :first_name, types.String
  argument :last_name, types.String
  argument :birth_year, types.Int
  argument :is_alive, types.Boolean
end

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

  field :coordinates, Types::PairType do
    description 'Coordinates of the author'
  end

  field :publication_years, types[types.Int]

  field :errors, types[types.String], 'Reasons why author could not be saved' do
    resolve ->(obj, _args, _ctx) do
      obj.errors.to_a
    end
  end
end
