# frozen_string_literal: true

class MenuItemsController < ApplicationController
  before_action :load_item, only: %i[update destroy]
  before_action :authorized

  def items
    items = MenuItem.all.except(:created_at, :updated_at)
    ActionCable.server.broadcast('menu_channel', event: 'index')
    render json: items, each_serializer: MenuItemSerializer
  end

  def create
    menu_item = MenuItem.new(create_menu_item_params)
    if menu_item.save
      ActionCable.server.broadcast('menu_channel',
        event: 'created',
        payload: {
          item: menu_item
        }
      )
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
        :title, :description, :price, :introduced_at, :is_expensive
      )
    end

    def load_item
      @menu_item = MenuItem.find(params[:id])
    end
end
