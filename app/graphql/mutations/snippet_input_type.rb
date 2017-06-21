Mutations::SnippetInputType = GraphQL::InputObjectType.define do
  name 'SnippetInputType'
  argument :slug, !types.String
  argument :text, !types.String
end
