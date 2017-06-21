Types::MediaType = GraphQL::ObjectType.define do
  name 'Media'
  description 'Media files'
  field :slug, !types.String
  field :file_file_name, !types.String
end
