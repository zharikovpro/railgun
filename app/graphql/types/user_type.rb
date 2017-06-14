Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'User'
  field :id, !types.ID
  field :email, !types.String
end
