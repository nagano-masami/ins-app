class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    #Messageモデルのレコードの一覧表示
    #@~~のインスタンス変数でControllerからViewへ変数を渡す
    @messages = Message.order(id: :desc).page(params[:page]).per(5)
  end

  def show
  end

  def new
    #POSTメソッドを送信する新規作成用の入力フォーム置き場
    @message = Message.new#(content:'sample')
  end

  def create
    #newのページから送信されるフォームを処理
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'Messageが正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Messageが投稿されませんでした'
      render :new
    end
  end

  def edit
    #既存メッセージレコードを編集
  end

  def update
    if @message.update(message_params)
      flash[:success] = 'Messageは正常に更新されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Messageは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @message.destroy

    flash[:success] = 'Messegaは正常に削除されました'
    redirect_to messages_url
  end
end

private

def set_message
  @message = Message.find(params[:id])
end

# Strong Parameter
def message_params
  #必要なパラメータを把握して、送信されてきたデータをフィルタリングする
  #contentカラムだけが欲しいデータ
  params.require(:message).permit(:content, :title)
end
