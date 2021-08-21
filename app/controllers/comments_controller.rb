class CommentsController < ApplicationController
  # 通知テーブルのオブジェクトも同時に作成する
  def create
    comment = Comment.new(comment_params)
    comment.cat_id = params[:cat_id]
    comment.save
    # 非同期通信用の
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
