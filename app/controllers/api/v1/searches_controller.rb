class Api::V1::SearchesController < ApplicationController

  def find_all
    items = Item.where('name ILIKE ?', "%#{params[:name]}%")
    if items.nil?
      render json: { data: { message: 'No matching items'}}
    else
      render json: ItemSerializer.new(items)
    end
  end

end
