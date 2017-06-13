class GraphqlController < ApplicationController
  include Knock::Authenticable
  undef_method :current_user
  before_action :destroy_session
  before_action :authenticate_user
  protect_from_forgery with: :null_session

  def destroy_session
    request.session_options[:skip] = true
  end

  def execute
    #skip_authorization
    authorize(current_user)
    variables = ensure_hash(params[:variables])
    query = params[:query]
    context = {
      # Query context goes here, for example:
       current_user: current_user,
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
