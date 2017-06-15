Mutations::SnippetInputType = GraphQL::InputObjectType.define do
  name 'SnippetInputType'
  description 'Properties for creating a Snippet'

  argument :slug, !types.String do
    description 'Title of the Snippet.'
  end

  argument :text, !types.String do
    description 'Text of the Snippet.'
  end
end
