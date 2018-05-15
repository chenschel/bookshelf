class GraphqlController < ApplicationController
  before_action :check_authentication

  def execute
    variables = ensure_hash(params[:variables])
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
      current_user: @session.try(:user),
      session_key: @session.try(:key)
    }
    result = BookshelfSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  def query
    params[:query]
  end

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

  def session
    @session = Session.where(key: request.headers['Authorization']).first
  end

  def check_authentication
    parsed_query = GraphQL::Query.new(BookshelfSchema, query)
    operation = parsed_query.selected_operation.selections.first.name

    # necessary when unsing gem graphiql to enable loading documentation
    return true if operation == '__schema'

    return true if field_is_public?(operation)

    session
    return true if @session && access_allowed?(operation)

    head(:unauthorized)
    false
  end

  def field_is_public?(operation)
    field(operation).metadata[:is_public]
  end

  def access_allowed?(operation)
    return true if field(operation).metadata[:must_be].blank?
    field(operation).metadata[:must_be].to_a.include?(@session.user.role)
  end

  def field(operation)
    BookshelfSchema.query.fields[operation] || BookshelfSchema.mutation.fields[operation]
  end
end
