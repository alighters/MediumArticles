class ArticleController < ApplicationController

  def create
    title = params[:title].to_s
    link = params[:link].to_s
    data = []
    file_name = Rails.root.to_s + '/README.rdoc'
    File.open(file_name).each do |line|
      data.push(line)
    end
    render json: data
  end
end
