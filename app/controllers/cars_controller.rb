class CarsController < ApplicationController
  def index
    @cars = Car.all.order('created_at DESC')
  end

  def create
    @car = Car.new(car_params)
    @manufacturers = Manufacturer.all
    if !params[:car][:manufacturer_id].nil?
      @manufacturer = Manufacturer.find(params[:car][:manufacturer_id])
    else
      @manufacturer = nil
    end
    @car.manufacturer = @manufacturer

    if @car.save
      flash[:notice] = 'Success! Car saved.'
      redirect_to cars_path
    else
      flash[:notice] = 'Oops! Check your error messages below.'
      render :new
    end
  end

  def new
    @car = Car.new
    @manufacturers = Manufacturer.all
  end

  private

  def car_params
    params.require(:car).permit(
    :manufacturer, :color, :year, :mileage, :description)
  end
end
