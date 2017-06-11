RailgunSchema = GraphQL::Schema.define do
  query(Types::QueryType)
  #query(Types::UserType)
end
