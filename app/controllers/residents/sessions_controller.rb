# frozen_string_literal: true

class Residents::SessionsController < Devise::SessionsController

  # 大会後の住民ユーザーのログイン制限
  before_action :reject_inactive_resident, only: [:create]

  # 退会済みユーザーを判別しredirectを設定
  def reject_inactive_resident
    @resident = Resident.find_by(email: params[:resident][:email])
    # 上記コードでemailカラムを用いて検索、下記コードは格納されていればtrue、いなければnull
    if @resident
      # 下記コードは　passwordが適切　かつ(&&)　@group.withdrawalがtrue　であればredirect_toが走る処理
      if @resident.valid_password?(params[:resident][:password]) && @resident.withdrawal
        redirect_to new_resident_session_path
      end
    end
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
