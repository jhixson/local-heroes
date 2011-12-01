class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @topics = Topic.find_all_by_location_id(@location.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/pittsburgh
  def find_by_city
    @location = Location.find_all_by_slug(params[:city])

    respond_to do |format|
      if @location.size == 1
        @location = @location.first
        @topics = Topic.find_all_by_location_id(@location.id)

        format.html { render :show }
        format.json { render json: @location }
      else
        format.html { render 'multiple' }
      end
    end
  end

  # GET /locations/PA/pittsburgh
  def find_by_state_and_city
    params[:state].upcase!
    @location = Location.find_by_state_and_slug(params[:state], params[:city])
    @topics = Topic.find_all_by_location_id(@location.id)

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @location }
    end
  end

  # GET /locations/PA/15601
  def find_by_zip
    @location = Location.find_by_zip(params[:zip])
    @topics = Topic.find_all_by_location_id(@location.id)

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end
end
