class SearchsController < ApplicationController
  # 猫の投稿の検索
  def cats
    address = params[:cat][:address]
    status = params[:cat][:status]
    search_for(address, status)
    gon.cats = @cats
  end

  # 保護団体の検索
  def groups
  end

  def search_for(address, status)
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
end
