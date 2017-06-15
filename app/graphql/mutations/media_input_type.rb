Mutations::MediaInputType = GraphQL::InputObjectType.define do
  name 'MediaInputType'
  description 'Properties for creating a Media'

  argument :slug, !types.String do
    description 'Slug of the Media.'
  end

  argument :file_file_name, !types.String do
    description 'File name of the Media.'
  end
end
