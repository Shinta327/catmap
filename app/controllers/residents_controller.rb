class ResidentsController < ApplicationController
  # ログイン前のアクション制限
  before_action :authenticate_resident!

  def show
  end

  def edit
    @resident = current_resident
  end

  def update
    resident = current_resident
    resident.update(resident_params)
    redirect_to resident_path(current_resident)
  end

  # 退会機能
  def withdrawal
    resident = current_resident
    resident.update(withdrawal: true)
    reset_session
    redirect_to root_path
  end

  # ストロングパラーメータ
  def resident_params
    params.require(:resident).permit(:name, :email, :postal_code, :address)
  end
end
