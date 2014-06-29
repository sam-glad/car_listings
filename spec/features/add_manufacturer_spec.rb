require 'rails_helper'

feature 'user adds a new manufacturer', %Q(
  As a car salesperson
  I want to record a car manufacturer
  So that I can keep track of the types of cars found in the lot
) do

  scenario 'user successfully adds a new manufacturer' do
    manufacturer = FactoryGirl.create(:manufacturer)
    error_notice = 'Oops! Check your error messages below.'
    error_msg = 'can\'t be blank'

    visit new_manufacturer_path
    fill_in 'Name', with: manufacturer.name
    fill_in 'Country', with: manufacturer.country
    click_on 'Submit'

    expect(page).to have_content(manufacturer.name)
    expect(page).to have_content(manufacturer.country)
    expect(page).to_not have_content(error_msg)
    expect(page).to_not have_content(error_notice)
  end

  scenario 'user fails to enter a name' do
    manufacturer = FactoryGirl.build(:manufacturer)

    error_notice = 'Oops! Check your error messages below.'
    error_msg = 'Name can\'t be blank'

    visit new_manufacturer_path
    fill_in 'Name', with: ''
    fill_in 'Country', with: manufacturer.country
    click_on 'Submit'

    expect(page).to have_content(error_notice)
    expect(page).to have_content(error_msg)

    visit manufacturers_path
    expect(page).to_not have_content(manufacturer.country)
  end

  scenario 'user fails to enter a country' do
    manufacturer = FactoryGirl.build(:manufacturer)

    error_notice = 'Oops! Check your error messages below.'
    error_msg = 'Country can\'t be blank'

    visit new_manufacturer_path
    fill_in 'Name', with: manufacturer.name
    fill_in 'Country', with: ''
    click_on 'Submit'

    expect(page).to have_content(error_notice)
    expect(page).to have_content(error_msg)

    visit manufacturers_path
    expect(page).to_not have_content(manufacturer.name)
  end
end
