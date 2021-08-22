class SearchsController < ApplicationController
  # 猫の投稿の検索
  def cats
    address = params[:cat][:address]
    status = params[:cat][:status]
    search_for_cat(address, status)
    gon.cats = @cats
  end

  # 保護団体の検索
  def groups
    name = params[:group][:text]
    search_for_group(name)
  end

  # 保護団体クリック時に一覧が保護団体のものになるアクション
  def group_cats
    group = params[:group]
    search_for_group_cats(group)
  end

  # 投稿一覧画面での地名とステータスの検索振り分け
  def search_for_cat(address, status)
    if address.present?
      @cats = Cat.where("address LIKE ?", "%#{address}%")
      gon.address = Geocoder.search(address)[0].geometry['location']
      if status.present?
        @cats = Cat.joins(:handle).where("cats.address LIKE ? AND handles.status LIKE ?", "%#{address}%", "#{status}")
      end
    else
      if status.present?
        @cats = Cat.joins(:handle).where("cats.address LIKE ? AND handles.status LIKE ?", "%#{address}%", "#{status}")
      else
        redirect_to cats_path
      end
    end
  end

  # 保護団体検索後の振り分け
  def search_for_group(name)
    if name.present?
      @groups = Group.where("name LIKE ? OR address LIKE ?", "%#{name}%", "%#{name}%").where(withdrawal: false)
      @cats = Cat.all
      render 'groups/index'
    else
      redirect_to groups_path
    end
  end

  # 保護団体クリック後の投稿一覧の振り分け
  def search_for_group_cats(group)
    @cats = Cat.joins(:handle).where("handles.group_id LIKE ?", "#{group}")
  end

end
