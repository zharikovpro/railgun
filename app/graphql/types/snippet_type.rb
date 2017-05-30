Types::SnippetType = GraphQL::ObjectType.define do
  name 'Snippet'
  description 'Snippet'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :slug, !types.String
  field :text, !types.String
end
