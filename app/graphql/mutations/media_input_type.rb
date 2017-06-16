Mutations::MediaInputType = GraphQL::InputObjectType.define do
  name 'MediaInputType'
  argument :slug, !types.String
  argument :file_file_name, !types.String
end
