class CatsController < ApplicationController
  def index
    gon.cats = Cat.all
    @cats = Cat.all
  end

  def new
    gon.cats = Cat.all
    @cat = Cat.new
  end

  def create
    # 投稿用の記述
    cat = Cat.new(cat_params)
    cat.resident_id = current_resident.id
    cat.save
    # 投稿時に対応テーブルのオブジェクトも作成し保存する記述
    Handle.create(cat_id: cat.id)
    redirect_to cat_path(cat.id)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def cat_params
    params.require(:cat).permit(:latitude, :longitude, :image, :detail)
  end
end
