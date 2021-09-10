class HomesController < ApplicationController
  
  # コメントの通知を取得するためのメソッド（全てのビューで使用するため）
  before_action :notice_index
  
  def top
  end
end
