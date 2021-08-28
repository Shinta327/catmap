class GroupsController < ApplicationController
  # ログイン前のアクション制限（一覧は制限なし）
  before_action :authenticate_group!, except: [:index]

  def index
    @groups = Group.where(withdrawal: false)
    @cats = Cat.all
  end

  def show
    @cats = Cat.joins(:handle).where("handles.group_id LIKE ?", "#{current_group.id}")
  end

  def edit
    @group = current_group
  end

  def update
    @group = current_group
    if  @group.update(group_params)
      redirect_to group_path(current_group)
    else
      render :edit
    end
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
