require "twitter"
# 動かなかった
# 適宜変更
@tweet = Twitter::REST::Client.new do |config|
  config.consumer_key = "hoge"
  config.consumer_secret = "hoge"
  config.access_token        = "hoge"
  config.access_token_secret = "hoge"
end
