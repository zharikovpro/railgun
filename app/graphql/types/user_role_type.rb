Types::UserRoleType = GraphQL::ObjectType.define do
  name 'UserRole'
  description 'User role'
  field :roles, !types.String
end
