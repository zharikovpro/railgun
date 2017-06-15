Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addPage, Types::PageType do
    description 'Adds a Page.'

    argument :page, Mutations::PageInputType
    resolve ->(t, args, c) {
      Page.create!(args[:page].to_h)
    }
  end

  field :addMedia, Types::MediaType do
    description 'Adds a Media.'

    argument :media, Mutations::MediaInputType
    resolve ->(t, args, c) {
      Media.create!(args[:media].to_h)
    }
  end

  field :addSnippet, Types::SnippetType do
    description 'Adds a Snippet.'

    argument :snippet, Mutations::SnippetInputType
    resolve ->(t, args, c) {
      Snippet.create!(args[:snippet].to_h)
    }
  end
end
