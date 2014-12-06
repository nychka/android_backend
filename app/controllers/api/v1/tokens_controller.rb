class Api::V1::TokensController < ApplicationController
  before_action :verify_auth_token, except: [:create]
  protect_from_forgery with: :null_session
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      auth_token = user.create_auth_token
      render json: {status: 'success', message: 'Successfully logged in', data: {auth_token: auth_token}}
    else
      render json: {status: 'fail', message: 'Invalid email or password'}
    end
  end

  def destroy
    @user.destroy_auth_token!
    respond_to do |format|
      format.json {render json: {status: 'success', message: 'Successfully logged out!'}}
    end
  end

  private 

  def verify_auth_token
    auth_token = params[:auth_token]
    if auth_token.present?
      @user = User.find_by_auth_token(auth_token)
      unless @user
        render json: {status: 'fail', message: 'Invalid auth token'}
      end
    else
      render json: {status: 'fail', message: 'Auth token not present'}
    end
  end
end
# curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST http://localhost:3001/api/v1/tokens -d "{\"email\":\"nychka93@gmail.com\", \"password\":\"1234\"}"