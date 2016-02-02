module DataHelper

  # 根据文件获取添入标题和链接之后的最新文本内容
  def self.append_to(file_name, title, link)
    data = []
    changed = false
    inserted = false

    File.open(file_name).each do |line|
      if !inserted and line.start_with?('###') 
        # 当前行为具体的日期
        date_str = line.slice(3, 3 + 10).squish
        if(is_date(date_str))
          # 当前日期为今天，则在当前天下添加新的一行数据
          if(Date.parse(date_str) == Date.today)
            data.push line
            data.push "+ [#{title}](#{link})<br>\n"
            changed = true
            inserted = true
          # 当前日期小于今天，则新建今天的数据
          elsif(Date.parse(date_str) < Date.today)
            data.push "### #{Date.today}<br>\n"
            data.push "+ [#{title}](#{link})<br>\n"
            data.push "<br>\n"
            inserted = true
          end
        end
      end
      if !changed
        data.push line
      end
      changed = false
    end
    # 若没有添加，则表示是个新建的文件，直接添加今天的数据
    if(!inserted)
       data.push "### #{Date.today}<br>\n"
       data.push "+ [#{title}](#{link})<br>\n"
       data.push "<br>\n"
    end
    data
  end

  # 向文件中写入data
  def self.write_to(file_name, data)
    file = File.new(file_name, 'w+')
    data.each do |line|
      file.write line
    end
    file.close
  end

  # 判断字符是否为一个日期
  def self.is_date(str)
    result = false
    begin
      Date.parse(str)
      result = true
    rescue ArgumentError
      result = false
    end
    result
  end

end
