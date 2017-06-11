Types::PageType = GraphQL::ObjectType.define do
  name 'Page'
  description 'Public page'
  field :id, !types.ID
  field :slug, !types.String
  field :markdown, !types.String
end
