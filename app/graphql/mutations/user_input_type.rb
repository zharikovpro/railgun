Mutations::UserInputType = GraphQL::InputObjectType.define do
  name 'UserInputType'
  argument :email, !types.String
  argument :password, !types.String
  argument :password_confirmation, !types.String
end
