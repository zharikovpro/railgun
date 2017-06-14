Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :user do
    type Types::UserType
    argument :id, !types.ID
    description 'Find a User by ID'
    resolve ->(obj, args, ctx) { User.find(args['id']) }
  end

  field :user_role do
    type Types::UserRoleType
    argument :user_id, !types.ID
    description 'Find a UserRoles by user ID'
    resolve ->(obj, args, ctx) { User.find(args['user_id']) }
  end

  field :page do
    type Types::PageType
    argument :slug, !types.String
    description 'Find a Page by slug'
    resolve ->(obj, args, ctx) { Page.find_by_slug(args['slug']) }
  end

  field :media do
    type Types::MediaType
    argument :slug, !types.String
    description 'Find a Media by slug'
    resolve ->(obj, args, ctx) { Media.find_by_slug(args['slug']) }
  end

  field :snippet do
    type Types::SnippetType
    argument :slug, !types.String
    description 'Find a Snippet by slug'
    resolve ->(obj, args, ctx) do
      object = Snippet.find_by_slug(args['slug'])
      SnippetPolicy.new(ctx[:current_user], object).show? ? (object) : nil
    end
  end

  field :snippets do
    type Types::SnippetType
    #argument :slug, !types.String
    description 'Find a Snippets'
    resolve ->(obj, args, ctx) { Snippet.all }
  end
end
