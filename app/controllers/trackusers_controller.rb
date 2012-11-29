class TrackusersController < ApplicationController
  # GET /trackusers
  # GET /trackusers.json
  def index
    @track = Track.find(params[:track_id])
    @trackusers = Trackuser.where(:track_id => @track.id) 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trackusers }
    end
  end

  # GET /trackusers/1
  # GET /trackusers/1.json
  def show
    @trackuser = Trackuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trackuser }
    end
  end

  # GET /trackusers/new
  # GET /trackusers/new.json
  def new
    @trackuser = Trackuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trackuser }
    end
  end

  # GET /trackusers/1/edit
  def edit
    @trackuser = Trackuser.find(params[:id])
    @track = Track.find(@trackuser.track_id)
  end

  # POST /trackusers
  # POST /trackusers.json
  def create
    @trackuser = Trackuser.new(params[:trackuser])

    respond_to do |format|
      if @trackuser.save
        format.html { redirect_to @trackuser, notice: 'Trackuser was successfully created.' }
        format.json { render json: @trackuser, status: :created, location: @trackuser }
      else
        format.html { render action: "new" }
        format.json { render json: @trackuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trackusers/1
  # PUT /trackusers/1.json
  def update
    @trackuser = Trackuser.find(params[:id])

    respond_to do |format|
      if @trackuser.update_attributes(params[:trackuser])
        format.html { redirect_to @trackuser, notice: 'Trackuser was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trackuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trackusers/1
  # DELETE /trackusers/1.json
  def destroy
    @trackuser = Trackuser.find(params[:id])
    @trackuser.destroy

    respond_to do |format|
      format.html { redirect_to trackusers_url }
      format.json { head :no_content }
    end
  end
end
