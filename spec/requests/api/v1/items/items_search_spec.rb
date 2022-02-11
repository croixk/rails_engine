require 'rails_helper'

RSpec.describe "Item search API - all matching items" do
  describe 'happy path' do
    it "searches for items - returns one item" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')

      item_1 = Item.create!(name: 'a_item', description: 'item_1 description', unit_price: 10, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'b_item', description: 'item_2 description', unit_price: 20, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'c_item', description: 'item_3 description', unit_price: 30, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all?name=a'

      items = JSON.parse(response.body, symbolize_names: true)


      expect(response).to be_successful
      expect(items[:data].count).to eq(1)

      items[:data].each do |item|
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes][:name]).to eq('a_item')
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end

    end

    it "searches for items - returns multiple item" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')

      item_1 = Item.create!(name: 'a_item', description: 'item_1 description', unit_price: 10, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'b_item', description: 'item_2 description', unit_price: 20, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'c_item', description: 'item_3 description', unit_price: 30, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all?name=i'

      items = JSON.parse(response.body, symbolize_names: true)


      expect(response).to be_successful
      expect(items[:data].count).to eq(3)
      items[:data].each do |item|
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes]).to have_key(:merchant_id)
      end

    end
  end

  describe 'sad path' do
    it "searches for items - items is nil" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')

      get '/api/v1/items/find_all?name=q'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].count).to eq(0)
    end
    it "searches for items - returns no items" do
      merchant_1 = Merchant.create!(name: 'Merchant_1')

      item_1 = Item.create!(name: 'a_item', description: 'item_1 description', unit_price: 10, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'b_item', description: 'item_2 description', unit_price: 20, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'c_item', description: 'item_3 description', unit_price: 30, merchant_id: merchant_1.id)

      get '/api/v1/items/find_all?name=q'

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].count).to eq(0)
    end
  end
end
