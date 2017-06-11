class GraphqlController < ApplicationController
  def execute
    skip_authorization
    variables = ensure_hash(params[:variables])
    query = params[:query]
    context = {
      # Query context goes here, for example:
        #auth: current_user.api_token,
       current_user: current_user,
      #pundit: self
    }
    result = RailgunSchema.execute(query, variables: variables, context: context)
    render json: result
  end
  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
