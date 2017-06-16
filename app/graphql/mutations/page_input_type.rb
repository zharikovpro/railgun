Mutations::PageInputType = GraphQL::InputObjectType.define do
  name 'PageInputType'
  argument :slug, !types.String
  argument :markdown, !types.String
end
