class RoomsController < ApplicationController
  before_filter :authenticate_api_user!
  # GET /rooms
  # GET /rooms.json
  def index
    rooms = Room.all
    render json: {:success => true, :api_token => @user.api_token, :rooms=> JSON.parse(rooms.to_json)}, status: 201
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    room = Room.find(params[:id])
    render json: {:success => true, :api_token => @user.api_token, :rooms=> JSON.parse(room.to_json)}, status: 201
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])
    if @room.save
      render json: {:success => true, :message=> "Room has been added successfully"}, status: 201
    else
      validation_errors(@room.errors)
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(params[:room])
      render json: {:success => true, :message=> "Room has been updated successfully"}, status: 201
    else
      validation_errors(@room.errors)
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    render json: {:success => true, :message=> "Room has been deleted successfully"}, status: 201
  end
  
  def delete
    @room = Room.find(params[:id])
    if @user.destroy
      render json: {:success => true, :message=> "Room has been deleted successfully"}, status: 201
    else
      render json: {:success => false, :errors => "An error occured during deleting room"}, status: 422 and return
    end
  end
  end
end
