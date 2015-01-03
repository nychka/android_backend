class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  acts_as_token_authentication_handler_for User, except: [:index, :show]
  helper_method :available_locales
  respond_to :json, :html
  before_action :set_response
  before_action :set_locale, only: [:index]

  # Catching exceptions from Cancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :root, { flash: { error: exception.message } }
  end

  protected
  def markdown(string)
    RDiscount.new(string).to_html.html_safe
  end
  # OPTIMIZE: 
  # - add strategy for parsing params
  # - extend serializing logic
  def get_serializer_for(model)
    model = model.to_s.capitalize
    relations = model.constantize.reflections.keys
    relation = params[:include] if params[:include].present? && relations.include?(params[:include].to_sym)

    if relation
     serializer = "#{model}WithEmbedded#{relation.capitalize}Serializer"
    else
     serializer = "#{model}Serializer"
    end
    serializer.constantize
  end
  def set_response
    @response = {}
  end
  def set_locale
    begin
      I18n.locale = params[:lang].present? ? params[:lang] : I18n.default_locale
    rescue Exception => e
      @response[:errors] = [e.message]
      @response[:status] = :unprocessable_entity
    end
  end

  private
  #TODO: винести в Settings
  def available_locales;  [:en, :ua] ; end
end
