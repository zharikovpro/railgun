Types::SnippetType = GraphQL::ObjectType.define do
  name 'Snippet'
  description 'Snippet'
  field :slug, !types.String
  field :text, !types.String
end
