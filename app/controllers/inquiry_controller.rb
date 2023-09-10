class InquiryController < ApplicationController
  require 'httpclient'

  def index
      client = HTTPClient.new
      url = '/inquiries'
      response = client.get(url)
      @res_json = JSON.parse(response.body)
  end

  def create
    # フォームから送信されたデータをparamsハッシュから取得
    title = params[:inquiry][:title]
    content = params[:inquiry][:content]

    # フォームデータを使ってPOSTリクエストを送信
    client = HTTPClient.new
    url = '/inquiries'
    post_data = { title: title, content: content }.to_json

    response = client.post(url, body: post_data, header: { 'Content-Type' => 'application/json' })

    if response.status == 200
      # POSTが成功した場合の処理
      @res_json = JSON.parse(response.body)
      flash[:success] = "POSTリクエストが成功しました。"
      render :index
    else
      # POSTが失敗した場合の処理
      flash[:error] = "POSTリクエストが失敗しました。"
      render :index
    end
  end
end
