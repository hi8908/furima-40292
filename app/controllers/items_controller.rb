class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # 重複処理をまとめる
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  
  # ログインしているユーザーと同じならばばeditファイルが読み込まれる
  def edit
    if @item.user_id == current_user.id
   else
     redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id,
                                 :delivery_area_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
