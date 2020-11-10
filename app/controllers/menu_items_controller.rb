# frozen_string_literal: true

class MenuItemsController < ApplicationController
  before_action :load_item, only: %i[update destroy]
  before_action :authorized

  def items
    @items = MenuItem.all.where(user_id: @user.id)

    filter_items

    ActionCable.server.broadcast('menu_channel', type: 'index')

    render json: @items, each_serializer: MenuItemSerializer
  end

  def create
    menu_item = MenuItem.new(create_menu_item_params.merge(user_id: @user.id))
    if menu_item.save
      ActionCable.server.broadcast('menu_channel',
        type: 'created',
        payload: menu_item
      )
      head :ok
    else
      head :error
    end
  end

  def update
    @menu_item.update(create_menu_item_params.merge(user_id: @user.id))
    ActionCable.server.broadcast('menu_channel',
      type: 'updated',
      payload: @menu_item
    )
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

    def filter_items
      if params[:filter].present? && params[:filter] != 'All'
        @items = @items.where(description: params[:filter])
      # elsif params[:index].present?
      #   @items = @items
      end
    end
end
