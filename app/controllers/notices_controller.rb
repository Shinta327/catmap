class NoticesController < ApplicationController
  # 表示のために取得したらチェックカラムをtrueにする処理を記述する
  def index
    if resident_signed_in?
      @notices = current_resident.passive_notifications
    elsif group_signed_in?
      @notices = current_group.passive_notifications
    end
  end

  def update
    notice = Notice.find(params[:id])
    notice.update(check: true)
    redirect_to cat_path(notice.comment.cat_id)
  end
end
