class HandlesController < ApplicationController
  # コメントの通知を取得するためのメソッド（全てのビューで使用するため）
  before_action :notice_index
  def edit
    @handle = Handle.find(params[:id])
  end

  def update
    @handle = Handle.find(params[:id])
    @handle.status = 2
    if  @handle.update(handle_params)
      redirect_to cat_path(@handle.cat)
    else
      render :edit
    end
  end

  def status
    value = params[:key].to_i
    @handle = Handle.find(params[:id])
    if value == 1
      @handle.update( group_id: current_group.id, status: value)
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  # 未対応に戻す際、対応テーブルから保護団体IDの削除と対応失敗テーブルのオブジェクト作成
  def failed
    handle = Handle.find(params[:id])
    handle.update(group_id: nil, status: 0)
    Failed.create(cat_id: handle.cat.id, group_id: current_group.id)
    redirect_to request.referer
  end

  private
  def handle_params
    params.require(:handle).permit(:detail)
  end
end
