Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :user do
    type Types::UserType
    argument :id, !types.ID
    description 'Find a User by ID'
    resolve ->(_obj, args, ctx) do
      object = User.find(args['id'])
      UserPolicy.new(ctx[:current_user], object).show? ? (object) : nil
    end
  end

  field :users, types[Types::UserType] do
    argument :limit, types.Int, default_value: 20
    resolve ->(_obj, args, ctx) do
      objects = UserPolicy::Scope.new(ctx[:current_user], User).resolve.limit(args[:limit])
      UserPolicy.new(ctx[:current_user], objects).index? ? (objects) : nil
    end
  end

  field :user_roles do
    type Types::UserRoleType
    argument :user_id, !types.ID
    description 'Find a UserRoles by user ID'
    resolve ->(_obj, args, ctx) do
      object = User.find(args['user_id'])
      UserRolePolicy.new(ctx[:current_user], object).index? ? (object) : nil
    end
  end

  field :page do
    type Types::PageType
    argument :slug, !types.String
    description 'Find a Page by slug'
    resolve ->(_obj, args, ctx) do
      object = Page.find_by_slug(args['slug'])
      PagePolicy.new(ctx[:current_user], object).show? ? (object) : nil
    end
  end

  field :pages, types[Types::PageType] do
    argument :limit, types.Int, default_value: 20
    resolve ->(_obj, args, ctx) do
      objects = PagePolicy::Scope.new(ctx[:current_user], Page).resolve.limit(args[:limit])
      PagePolicy.new(ctx[:current_user], objects).index? ? (objects) : nil
    end
  end

  field :media do
    type Types::MediaType
    argument :slug, !types.String
    description 'Find a Media by slug'
    resolve ->(_obj, args, ctx) do
      object = Media.find_by_slug(args['slug'])
      MediaPolicy.new(ctx[:current_user], object).show? ? (object) : nil
    end
  end

  field :medias, types[Types::MediaType] do
    argument :limit, types.Int, default_value: 20
    resolve ->(_obj, args, ctx) do
      objects = MediaPolicy::Scope.new(ctx[:current_user], Media).resolve.limit(args[:limit])
      MediaPolicy.new(ctx[:current_user], objects).index? ? (objects) : nil
    end
  end

  field :snippet do
    type Types::SnippetType
    argument :slug, types.String
    description 'Find a Snippet by slug'
    resolve ->(_obj, args, ctx) do
      object = Snippet.find_by_slug(args['slug'])
      SnippetPolicy.new(ctx[:current_user], object).show? ? (object) : nil
    end
  end

  field :snippets, types[Types::SnippetType] do
    argument :limit, types.Int, default_value: 20
    resolve ->(_obj, args, ctx) do
      objects = SnippetPolicy::Scope.new(ctx[:current_user], Snippet).resolve.limit(args[:limit])
      SnippetPolicy.new(ctx[:current_user], objects).index? ? (objects) : nil
    end
  end
end
