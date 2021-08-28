class ResidentsController < ApplicationController
  # ログイン前のアクション制限
  before_action :authenticate_resident!

  def show
    @cats = Cat.where(resident_id: current_resident.id)
  end

  def edit
    @resident = current_resident
  end

  def update
    @resident = current_resident
    if @resident.update(resident_params)
      redirect_to resident_path(current_resident)
    else
      render :edit
    end
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
