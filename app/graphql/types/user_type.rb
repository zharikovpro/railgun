Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'User'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :email, !types.String
  field :encrypted_password, !types.String
  field :sign_in_count, !types.Integer
  field :created_at, !types.String
  field :updated_at, !types.String
end
