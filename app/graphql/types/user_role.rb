Types::UserRoleType = GraphQL::ObjectType.define do
  name 'UserRole'
  description 'User role'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :user_id, !types.Integer
  field :role, types.types[!User_roleType]
end
