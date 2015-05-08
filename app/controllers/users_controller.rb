class UsersController < ApplicationController
  before_filter :authenticate_api_user!, :except => [:sign_in, :create]
  def index
    users = User.all
    render json: {:success => true, :api_token => @user.api_token, :users=> JSON.parse(users.to_json)}, status: 201
  end
  
  def sign_in
    user = User.where(:email => params[:user][:email], :password => params[:user][:password]).first
    unless user.blank?
      rand_number = SecureRandom.hex(4)
      user.update_attributes(:api_token => rand_number)
      render json: {:success => true, :api_token => rand_number, :users=> JSON.parse(user.to_json)}, status: 201
    else
      render json: {:success => false, :errors => "Incorrect Email or password"}, status: 422 and return
    end
  end
  
  def create
    user = User.new(params[:user])
    if user.save
      rand_number = SecureRandom.hex(4)
      user.update_attributes(:api_token => rand_number)
      render json: {:success => true, :api_token => rand_number, :users=> JSON.parse(user.to_json)}, status: 201
    else
      validation_errors(user.errors)
    end
  end
  
  def show
    user = User.find(params[:id])
    render json: {:success => true, :api_token => @user.api_token, :users=> JSON.parse(user.to_json)}, status: 201
  end
  
  def delete
    @user = User.find(params[:id])
    if @user.destroy
      render json: {:success => true, :message=> "User has been deleted successfully"}, status: 201
    else
      render json: {:success => false, :errors => "An error occured during deleting user"}, status: 422 and return
    end
  end
  
  def logout
    @user.update_attributes(:api_token => nil)
    render json: {:success => true, :message=> "You have successfully logout"}, status: 201
  end
  
  def update_profile
    user = User.find(params[:id])
    if user.update_attributes(params[:user])
      render json: {:success => true, :api_token => user.api_token, :users=> JSON.parse(user.to_json), :message => 'Profile udated successfully'}, status: 201
    else
      validation_errors(@user.errors)
    end
  end
end
