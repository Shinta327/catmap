class GroupsController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @group = current_group
  end

  def update
    group = current_group
    group.update(group_params)
    redirect_to group_path(current_group)
  end

  def withdrawal
    group = current_group
    group.update(withdrawal: true)
    reset_session
    redirect_to root_path
  end

  # ストロングパラメータ
  private

  def group_params
    params.require(:group).permit(:name, :email, :postal_code, :address, :url, :explanation)
  end
end
