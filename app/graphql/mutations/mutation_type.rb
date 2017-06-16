Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addPage, Types::PageType do
    argument :page, Mutations::PageInputType
    resolve ->(_obj, args, _ctx) {
      Page.create!(args[:page].to_h)
    }
  end

  field :deletePage, Types::PageType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) {
      Page.find_by_slug(args[:slug]).delete
    }
  end

  field :addMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    resolve ->(_obj, args, _ctx) {
      Media.create!(args[:media].to_h)
    }
  end

  field :deleteMedia, Types::MediaType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) {
      Media.find_by_slug(args[:slug]).delete
    }
  end

  field :addSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    resolve ->(_obj, args, _ctx) {
      Snippet.create!(args[:snippet].to_h)
    }
  end

  field :deleteSnippet, Types::SnippetType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) {
      Snippet.find_by_slug(args[:slug]).delete
    }
  end
end
