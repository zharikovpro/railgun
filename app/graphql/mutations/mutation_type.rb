Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addPage, Types::PageType do
    argument :page, Mutations::PageInputType
    resolve ->(_obj, args, _ctx) do
      Page.create!(args[:page].to_h)
    end
  end

  field :updatePage, Types::PageType do
    argument :page, Mutations::PageInputType
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      object = Page.find_by_slug(args['slug'])
      object.update(args[:page].to_h)
      object
    end
  end

  field :deletePage, Types::PageType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      Page.find_by_slug(args[:slug]).delete
    end
  end

  field :addMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    resolve ->(_obj, args, _ctx) do
      Media.create!(args[:media].to_h)
    end
  end

  field :updateMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      object = Media.find_by_slug(args['slug'])
      object.update(args[:media].to_h)
      object
    end
  end

  field :deleteMedia, Types::MediaType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      Media.find_by_slug(args[:slug]).delete
    end
  end

  field :addSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    resolve ->(_obj, args, _ctx) do
      Snippet.create!(args[:snippet].to_h)
    end
  end

  field :updateSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      object = Snippet.find_by_slug(args['slug'])
      object.update(args[:snippet].to_h)
      object
    end
  end

  field :deleteSnippet, Types::SnippetType do
    argument :slug, !types.String
    resolve ->(_obj, args, _ctx) do
      Snippet.find_by_slug(args[:slug]).delete
    end
  end
end
