Types::MediaType = GraphQL::ObjectType.define do
  name 'Media'
  description 'Media files'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :slug, !types.String
  field :file_file_name, !types.String
end
