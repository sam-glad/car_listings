require 'rails_helper'

feature 'user adds a new car', %Q(
  As a car salesperson
  I want to record a newly acquired car
  So that I can list it in my lot
) do

  scenario 'user successfully adds a new car with a description' do
    manufacturer = FactoryGirl.create(:manufacturer)
    car = FactoryGirl.build(:car, manufacturer: manufacturer)

    visit new_car_path
    choose "car_manufacturer_id_#{car.manufacturer.id}"
    fill_in 'Color', with: car.color
    fill_in 'Year', with: car.year
    fill_in 'Mileage', with: car.mileage
    fill_in 'Description', with: car.description
    click_on 'Submit'

    expect(page).to have_content('Success! Car saved.')
    expect(page).to have_content(car.manufacturer.name)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car.year)
    expect(page).to have_content(car.mileage)
    expect(page).to have_content(car.description)
    expect(Car.count).to eq(1)
  end

  scenario 'user successfully adds a new car without a description' do
    car = FactoryGirl.build(:car)

    visit new_car_path
    choose "car_manufacturer_id_#{car.manufacturer.id}"
    fill_in 'Color', with: car.color
    fill_in 'Year', with: car.year
    fill_in 'Mileage', with: car.mileage
    click_on 'Submit'

    expect(page).to have_content('Success! Car saved.')
    expect(page).to have_content(car.manufacturer.name)
    expect(page).to have_content(car.color)
    expect(page).to have_content(car.year)
    expect(page).to have_content(car.mileage)
    expect(Car.count).to eq(1)
  end

  scenario 'user fails to enter required information' do
    error_msgs = []
    error_msgs << 'Oops! Check your error messages below.'
    error_msgs << 'Manufacturer can\'t be blank'
    error_msgs << 'Color can\'t be blank'
    error_msgs << 'Year can\'t be blank'
    error_msgs << 'Mileage can\'t be blank'

    visit new_car_path
    click_on 'Submit'

    error_msgs.each do |error|
      expect(page).to have_content(error)
    end
    expect(page).to have_content('Oops! Check your error messages below')
    expect(page).to_not have_content('Success! Car saved.')
    expect(Car.count).to eq(0)
  end

  scenario 'user enters inappropriate information' do
    car = FactoryGirl.build(:car)

    error_msgs = []
    error_msgs << 'Oops! Check your error messages below.'
    error_msgs << 'Year must be greater than or equal to 1920'
    error_msgs << 'Mileage must be greater than or equal to 0'

    visit new_car_path
    choose "car_manufacturer_id_#{car.manufacturer.id}"
    fill_in 'Color', with: car.color
    fill_in 'Year', with: 1919
    fill_in 'Mileage', with: -1
    click_on 'Submit'

    error_msgs.each do |error|
      expect(page).to have_content(error)
    end
    expect(page).to have_content('Oops! Check your error messages below')
    expect(page).to_not have_content('Success! Car saved.')
    expect(Car.count).to eq(0)
  end

end
