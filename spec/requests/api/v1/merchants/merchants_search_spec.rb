require 'rails_helper'

RSpec.describe "Merchant search API - return one merchant" do
  describe 'happy path' do
    it "returns one merchant, perfect match" do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2')
      merchant_3 = Merchant.create!(name: 'merchant_3')

      get '/api/v1/merchants/find?name=merchant_1'

      merchant = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(merchant.count).to eq(1)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it "returns first match alphabetically if multiple match" do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2')
      merchant_3 = Merchant.create!(name: 'merchant_3')

      get '/api/v1/merchants/find?name=merchant'

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant.count).to eq(1)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end

  describe 'sad path' do
    it "returns no merchants - error message" do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      merchant_2 = Merchant.create!(name: 'merchant_2')
      merchant_3 = Merchant.create!(name: 'merchant_3')

      get '/api/v1/merchants/find?name='

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(merchant.count).to eq(1)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end

end
