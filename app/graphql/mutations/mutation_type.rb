Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addPage, Types::PageType do
    argument :page, Mutations::PageInputType
    resolve ->(obj, args, ctx) {
      Page.create!(args[:page].to_h)
    }
  end

  field :addMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    resolve ->(obj, args, ctx) {
      Media.create!(args[:media].to_h)
    }
  end

  field :addSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    resolve ->(obj, args, ctx) {
      Snippet.create!(args[:snippet].to_h)
    }
  end
end
