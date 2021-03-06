class PethomesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @pethomes = Pethome.all
  end

  def new
    @pethome = Pethome.new  # GET /pethomes/new
  end

  def create # POST /pethomes
    @pethome = Pethome.new(pethome_params)
    @pethome.user = current_user
    @pethome.save
    redirect_to pethomes_path
  end

  def search
    @pethomes = Pethome.all

    if params[:search] && params[:search] != ''
      @pethomes = Pethome.search(params[:search]).order("created_at DESC")
    end

  end

  def show  # GET /pethomes/:idS
    @pethome = Pethome.find(params[:id])
    @pet = Pet.new
  end

  def edit # GET /pethomes/:id/edit
    if @pethome.user != current_user
      redirect_to route_path, notice: "You are not authorized to edit this page"
    end
    @pethome = Pethome.find(params[:id])
  end

  def update
    @pethome = Pethome.find(params[:id])
    if @pethome.update(pethome_params)
      redirect_to pethomes_path
    else
      render :edit
    end
  end

  private

  def pethome_params
    params.require(:pethome).permit(:bookings, :pets, :pethome_reviews, :address, :bedrooms, :guests, :observations, :photo, :photo_cache)
  end

end
