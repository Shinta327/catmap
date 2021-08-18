# frozen_string_literal: true

class Groups::SessionsController < Devise::SessionsController

  # 大会後の保護団体ユーザーのログイン制限
  before_action :reject_inactive_group, only: [:create]

  # 退会済みユーザーを判別しredirectを設定
  def reject_inactive_group
    @group = Group.find_by(email: params[:group][:email])
    # 上記コードでemailカラムを用いて検索、下記コードは格納されていればtrue、いなければnull
    if @group
      # 下記コードは　passwordが適切　かつ(&&)　@group.withdrawalがtrue　であればredirect_toが走る処理
      if @group.valid_password?(params[:group][:password]) && @group.withdrawal
        redirect_to new_group_session_path
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
