class SearchsController < ApplicationController
  # 猫の投稿の検索
  def cats
    address = params[:cat][:address]
    status = params[:cat][:status]
    search_for_cat(address, status)
    gon.cats = @cats
    gon.handles = []
      @cats.each do |cat|
        gon.handles += Handle.where(cat_id: cat.id)
      end
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
      # addressに複数単語がある場合の記述
      split_address = address.split(/[[:blank:]]+/)
      @cats = []
      split_address.each do |address|
        next if address == ""
        @cats = Cat.where("address LIKE ?", "%#{address}%")
      end
      @cats.uniq #重複データの削除
      gon.address = Geocoder.search(address)[0].geometry['location']
      if status.present?
        @cats = @cats.joins(:handle).where("handles.status LIKE ?", "#{status}")
      end
    else
      if status.present?
        @cats = Cat.joins(:handle).where("handles.status LIKE ?", "#{status}")
      else
        redirect_to cats_path
      end
    end
  end

  # 保護団体検索後の振り分け
  def search_for_group(name)
    if name.present?
      # 複数単語の検索可
      split_name = name.split(/[[:blank:]]+/)
      @groups = []
      split_name.each do |name|
        next if name == ""
        @groups += Group.where("name LIKE ? OR address LIKE ?", "%#{name}%", "%#{name}%").where(withdrawal: false)
      end
      @groups.uniq! #重複したものを削除
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
