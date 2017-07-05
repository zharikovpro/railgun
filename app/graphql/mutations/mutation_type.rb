Mutations::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addUser, Types::UserType do
    argument :user, Mutations::UserInputType
    resolve ->(_obj, args, _ctx) do
      User.create!(args[:user].to_h)
    end
  end

  field :updateUser, Types::UserType do
    argument :id, !types.ID
    argument :user, Mutations::UserInputType
    resolve ->(_obj, args, _ctx) do
      object = User.find(args['id'])
      object.update_attributes(args[:user].to_h)
      object
    end
  end

  field :deleteUser, Types::UserType do
    argument :id, !types.ID
    resolve ->(_obj, args, _ctx) do
      User.find(args[:id]).delete
    end
  end

  field :addUserRole, Types::UserRoleType do
    argument :user_id, !types.ID
    argument :user_role, Mutations::UserRoleInputType
    resolve ->(_obj, args, ctx) do
      object = User.find(args[:user_id])
      UserRolePolicy.new(ctx[:current_user], object).create? ? (object.add_role(args[:user_role]['roles'])) : nil
      object
    end
  end

  field :deleteUserRole, Types::UserRoleType do
    argument :user_id, !types.ID
    argument :user_role, Mutations::UserRoleInputType
    resolve ->(_obj, args, ctx) do
      object = User.find(args[:user_id])
      UserRolePolicy.new(ctx[:current_user], object).destroy? ? (object.user_roles.find_by_role(args[:user_role]['roles']).delete) : nil
      object
    end
  end

  field :addPage, Types::PageType do
    argument :page, Mutations::PageInputType
    resolve ->(_obj, args, ctx) do
      PagePolicy.new(ctx[:current_user], Page).create? ? (Page.create!(args[:page].to_h)) : nil
    end
  end

  field :updatePage, Types::PageType do
    argument :page, Mutations::PageInputType
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Page.find_by_slug(args['slug'])
      PagePolicy.new(ctx[:current_user], object).update? ? (object.update_attributes(args[:page].to_h)) : nil
      object
    end
  end

  field :deletePage, Types::PageType do
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Page.find_by_slug(args[:slug])
      PagePolicy.new(ctx[:current_user], object).destroy? ? (object.delete) : nil
    end
  end

  field :addMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    resolve ->(_obj, args, ctx) do
      MediaPolicy.new(ctx[:current_user], Media).create? ? (Media.create!(args[:media].to_h)) : nil
    end
  end

  field :updateMedia, Types::MediaType do
    argument :media, Mutations::MediaInputType
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Media.find_by_slug(args['slug'])
      MediaPolicy.new(ctx[:current_user], object).update? ? (object.update_attributes(args[:media].to_h)) : nil
      object
    end
  end

  field :deleteMedia, Types::MediaType do
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Media.find_by_slug(args[:slug])
      MediaPolicy.new(ctx[:current_user], object).destroy? ? (object.delete) : nil
    end
  end

  field :addSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    resolve ->(_obj, args, ctx) do
      SnippetPolicy.new(ctx[:current_user], Snippet).create? ? (Snippet.create!(args[:snippet].to_h)) : nil
    end
  end

  field :updateSnippet, Types::SnippetType do
    argument :snippet, Mutations::SnippetInputType
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Snippet.find_by_slug(args['slug'])
      SnippetPolicy.new(ctx[:current_user], object).update? ? (object.update_attributes(args[:snippet].to_h)) : nil
      object
    end
  end

  field :deleteSnippet, Types::SnippetType do
    argument :slug, !types.String
    resolve ->(_obj, args, ctx) do
      object = Snippet.find_by_slug(args[:slug])
      SnippetPolicy.new(ctx[:current_user], object).destroy? ? (object.delete) : nil
    end
  end
end
