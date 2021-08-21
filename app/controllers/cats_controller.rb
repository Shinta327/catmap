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
    @cat = Cat.find(params[:id])
    @status = @cat.handle.status_before_type_cast
    gon.cat = @cat
    # 投稿に対する失敗した団体idを取得
    @faileds = @cat.faileds.pluck(:group_id)
    @comments = @cat.comments
  end

  def edit
    @cat = Cat.find(params[:id])
    gon.cat = @cat
    gon.cats = Cat.all
  end

  def update
    cat = Cat.find(params[:id])
    cat.update(cat_params)
    redirect_to cat_path(cat)
  end

  def destroy
    cat = Cat.find(params[:id])
    if cat.resident_id == current_resident.id
      cat.destroy
      redirect_to cats_path
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:latitude, :longitude, :image, :detail)
  end
end
