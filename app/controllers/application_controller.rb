class ApplicationController < ActionController::Base
  respond_to :json
  
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
          headers['Access-Control-Max-Age'] = '1728000'
          render :text => '', :content_type => 'text/plain'
    end
  end

  private
  def authenticate_api_user!
    invalid_user if api_user.blank?
  end
  
  def api_user
    return @user if @user.present?
    api_token = ""

    if !params[:api_token].blank?
      api_token = params[:api_token]
    end

    return nil if api_token.blank?
    user = User.where(:api_token => api_token).first
    
    if user.present?
      @user = user
      return @user
    end
  end
  
  def invalid_user
    render :json => {:success => false, :message => "Not authorize to access the resource"} 
    return
  end
  
  def validation_errors(errors)
    render json: {
      :success => false, 
      :errors => errors.full_messages.join(", ")
    }, status: 422
  end
end
