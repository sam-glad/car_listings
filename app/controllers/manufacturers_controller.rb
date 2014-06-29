class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all.order('created_at DESC')
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    if @manufacturer.save
      flash[:notice] = 'Success! Manufacturer saved.'
      redirect_to manufacturers_path
    else
      flash[:notice] = 'Oops! Check your error messages below.'
      render :new
    end
  end

  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name, :country)
  end
end
