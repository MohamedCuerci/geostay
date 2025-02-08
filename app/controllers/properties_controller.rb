class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    @properties = Property.all

    @markers = @properties.map do |property|
      {
        id: property.id,
        lat: property.coordinates.latitude,
        lng: property.coordinates.longitude,
        name: property.title
      }

      # marker[:distance] = property.distance_from(user_location) if user_location
      # marker
    end

    # codigo pra ordenar pela distancia
    # preciso usar o postgis para localizar no 10km mais perto
  end

  # GET /properties/1 or /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
    @property.build_address
  end

  # GET /properties/1/edit
  def edit
    @property.build_address unless @property.address
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy!

    respond_to do |format|
      format.html { redirect_to properties_path, status: :see_other, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(
        :user_id, :title, :description, :price, :bedrooms, :bathrooms, :area, :status, photos: [],
        address_attributes: [ :id, :street, :number, :complement, :neighborhood, :city, :state, :country, :zipcode, :coordinates ]
        )
    end
end
