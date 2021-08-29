class CommentsController < ApplicationController
  # コメントの通知を取得するためのメソッド（全てのビューで使用するため）
  before_action :notice_index
  # 通知テーブルのオブジェクトも同時に作成する
  def create
    comment = Comment.new(comment_params)
    comment.cat_id = params[:cat_id]
    comment.save
    # 通知テーブルのレコード作成
    unless comment.resident_id == nil
      # コメント者がresidentの場合
      group_receive_id = Cat.find(params[:cat_id]).handle.group_id
      comment.send_resident_comment(comment.resident_id, group_receive_id)
    else
      # コメント者がgroupの場合
      resident_receive_id = Cat.find(params[:cat_id]).resident_id
      comment.send_group_comment(comment.group_id, resident_receive_id)
    end
    # 非同期通信用の変数定義
    @cat = Cat.find(params[:cat_id])
    @comments = Cat.find(params[:cat_id]).comments
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    # 非同期通信用の変数定義
    @cat = Cat.find(params[:cat_id])
    @comments = Cat.find(params[:cat_id]).comments
  end

  private
  def comment_params
    params.require(:comment).permit(:group_id, :resident_id, :comment)
  end
end
