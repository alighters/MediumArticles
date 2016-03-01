class ArticleController < ApplicationController

  def create
    title = params[:title]
    link = params[:link]
    data = []
    file_name = Rails.root.to_s + '/README.md'
    status = 'ok'
    if title.nil? or link.nil?
      status = 'error'
    else
      if(Date.today.mday == 1)
        new_file_name = "#{Rails.root.to_s}/#{Date.today.prev_day.strftime('%Y-%m').to_s}.md"
        if(!File.exists?(new_file_name))
          File.rename(file_name, new_file_name)
          File.new(file_name, 'w+')
        end
      end
      data = DataHelper.append_to(file_name, title, link)
      if !data.nil?
        DataHelper.write_to(file_name, data)
      end
    end
    GitHelper.commit(title)
    render json: {'status' => status, 'data' => data}
  end
  
  
end
