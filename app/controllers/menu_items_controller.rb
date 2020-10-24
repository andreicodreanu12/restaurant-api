# frozen_string_literal: true

class MenuItemsController < ActionController::API
  before_action :load_item, only: %i[update destroy]

  def items
    items = MenuItem.all.except(:created_at, :updated_at)
    render json: items
  end

  def create
    menu_item = MenuItem.new(create_menu_item_params)
    if menu_item.save
      head :ok
    else
      head :error
    end
  end

  def update
    @menu_item.update(create_menu_item_params)
  end

  def destroy
    @menu_item.destroy
  end

  private

    def create_menu_item_params
      params.require(:menu_item).permit(
        :title, :description, :price
      )
    end

    def load_item
      @menu_item = MenuItem.find(params[:id])
    end
end