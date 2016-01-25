class HomeController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index
  end

  def show
    @user = User.includes(:status).find(params[:id])
  end

  def call
    @user = User.includes(:status).find(params[:id])
    if @user.twitterid.empty?
      @user.twitterid = "Tothenewfuture"
    end
    @tweet = Twitter::REST::Client.new do |config|
      # 適宜変更
      config.consumer_key = "hoge"
      config.consumer_secret = "hoge"
      config.access_token        = "hoge"
      config.access_token_secret = "hoge"
    end
    @tweet.update("@#{@user.twitterid} #{Time.current} #{@user.username}さん #{@user.babyname}ちゃんが大変なことになってます！");
    Slack.chat_postMessage(text: "#{@user.babyname}ちゃんが大変なことになってます！", username: 'watchbaby', channel: "#develop")
  end
end
