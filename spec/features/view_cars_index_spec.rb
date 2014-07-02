require 'rails_helper'

feature 'user views the cars index page', %Q(
  'As a car salesperson
  I want to view a list of cars in my lot
  So that I can keeep track of my cars'
) do

  scenario 'user views the cars index page' do
    cars = []
    5.times do
      cars << FactoryGirl.create(:car)
    end

    visit cars_path
    cars.each do |car|
      expect(page).to have_content(car.manufacturer.name)
      expect(page).to have_content(car.color)
      expect(page).to have_content(car.year)
      expect(page).to have_content(car.mileage)
      expect(page).to have_content(car.description)
    end
  end
end
