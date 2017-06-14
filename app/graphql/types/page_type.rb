Types::PageType = GraphQL::ObjectType.define do
  name 'Page'
  description 'Public page'
  field :slug, !types.String
  field :markdown, !types.String
end
