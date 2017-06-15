Mutations::PageInputType = GraphQL::InputObjectType.define do
  name 'PageInputType'
  description 'Properties for creating a Page'

  argument :slug, !types.String do
    description 'Slug of the Page.'
  end

  argument :markdown, !types.String do
    description 'Markdown of the Page.'
  end
end
