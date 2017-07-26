module API
  class GraphqlController < MainController
    def execute
      authorize(current_user, :graphiql?)
      variables = params[:variables]
      query = params[:query]
      context = {
        current_user: current_user
      }
      result = RailgunSchema.execute(query, variables: variables, context: context)
      render json: result
    end
  end
end
