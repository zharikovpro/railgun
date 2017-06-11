Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :user do
    type Types::UserType
    argument :id, !types.ID
    description 'Find a Post by ID'
    resolve ->(obj, args, ctx) { User.find(args['id']) }
  end

  field :page do
    type Types::PageType
    argument :slug, !types.String
    description 'Find a Page by slug'
    resolve ->(obj, args, ctx) { Page.find_by_slug(args['slug']) }
  end
end
