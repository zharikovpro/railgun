Mutations::UserRoleInputType = GraphQL::InputObjectType.define do
  name 'UserRoleInputType'
  argument :roles, !types.String
end
