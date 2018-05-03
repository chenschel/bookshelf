Types::PairType = GraphQL::ObjectType.define do
  name 'PairType'
  description 'A pair of coordinates'

  field :latitude, types.Float do
    resolve ->(obj, _args, _ctx) { obj.first }
  end

  field :longitude, types.Float do
    resolve ->(obj, _args, _ctx) { obj.last }
  end
end
