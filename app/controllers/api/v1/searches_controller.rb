class Api::V1::SearchesController < ApplicationController

  def find_all
    items = Item.where('name ILIKE ?', "%#{params[:name]}%")
    if items.nil?
      render json: { data: { message: 'No matching items'}}, status: 400
    else
      render json: ItemSerializer.new(items)
    end
  end



  def find
    # merchant = Merchant.where(name: params[:name]).first
    merchant = Merchant.where('name ILIKE ?', "%#{params[:name]}%").first
    if merchant.nil?
      render json: { data: { message: 'No matching merchant'}}, status: 400
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
