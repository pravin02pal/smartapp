class RentsController < ApplicationController
  before_filter :authenticate_api_user!
  # GET /rents
  # GET /rents.json
  def index
    rents = Rent.where(:user_id => params[:user_id])
    render json: {:success => true, :api_token => @user.api_token, :rents=> JSON.parse(rents.to_json)}, status: 201
  end

  # GET /rents/1
  # GET /rents/1.json
  def show
    rent = Rent.find(params[:id])
    render json: {:success => true, :api_token => @user.api_token, :rents=> JSON.parse(rent.to_json)}, status: 201
  end

  # POST /rents
  # POST /rents.json
  def create
    @rent = Rent.new(params[:rent])
    if @rent.save
      render json: {:success => true, :message=> "Rent has been added successfully"}, status: 201
    else
      validation_errors(@rent.errors)
    end
  end

  # PUT /rents/1
  # PUT /rents/1.json
  def update_Rent
    @rent = Rent.find(params[:id])
    if @rent.update_attributes(params[:rent])
      render json: {:success => true, :message=> "Rent has been updated successfully"}, status: 201
    else
      validation_errors(@rent.errors)
    end
  end

  # DELETE /rents/1
  # DELETE /rents/1.json
  def destroy
    @rent = Rent.find(params[:id])
    @rent.destroy
    render json: {:success => true, :message=> "Rent has been deleted successfully"}, status: 201
  end
  
  def delete
    @rent = Rent.find(params[:id])
    if @rent.destroy
      render json: {:success => true, :message=> "Rent has been deleted successfully"}, status: 201
    else
      render json: {:success => false, :errors => "An error occured during deleting Rent"}, status: 422 and return
    end
  end
end
