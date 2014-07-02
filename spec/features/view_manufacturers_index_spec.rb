require 'rails_helper'

feature 'user views the manufacturers index page', %Q(
  As a car salesperson
  I want to see a list of car manufacturers
  So that I can keep track of the types of cars found in the lot
) do

  scenario 'user views the manufacturers index page' do
    manufacturers = []
    5.times do
      manufacturers << FactoryGirl.create(:manufacturer)
    end

    visit manufacturers_path
    manufacturers.each do |manufacturer|
      expect(page).to have_content(manufacturer.name)
      expect(page).to have_content(manufacturer.country)
    end
    expect(Manufacturer.count).to eq(5)
  end
end
