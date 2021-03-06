require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items['data'].count).to eq(3)
    # expect(items['data'].first[:id]).to be_a(String)
    # expect(items['data'].first[:attributes]).to have_key(:id)
  end

  it 'can get one item by its id' do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
    expect(response).to be_successful
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)
  end

  it 'can create a new item' do
    merchant = Merchant.create!(name: 'Merchant_1')

    item_params = ({
      "name": "value1",
      "description": "value2",
      "unit_price": 100.99,
      "merchant_id": merchant.id
      })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an existing item' do
    # create a merchant


    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "New name" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("New name")
  end

  it 'can destroy an item' do
    item = create(:item)
    expect(Item.count).to eq(1)
    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id).to raise_error(ActiveRecord::RecordNotFound)}
  end

  it 'can find a merchant for an item' do
    item = create(:item)
    get "/api/v1/items/#{item.id}/merchants"
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

  end
end
