require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    merchant_1 = Merchant.create!(name: 'Merchant_1')
    create_list(:item, 3, merchant: merchant_1)

    get "/api/v1/merchants/#{merchant_1.id}/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)
  end


end
