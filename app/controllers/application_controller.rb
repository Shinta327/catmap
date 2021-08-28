class ApplicationController < ActionController::Base
  # deviseでカスタマイズしたカラムを受け取るためのstrong paramaterの設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  # コメントの通知を取得するためのメソッド（全てのビューでしようするため）
  before_action :notice_index

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    cats_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :url, :explanation])
  end

  # ログインした人の通知を取得する
  def notice_index
    if resident_signed_in?
      @notices = current_resident.passive_notifications.where(check: false)
    elsif group_signed_in?
      @notices = current_group.passive_notifications.where(check: false)
    end
  end
end
