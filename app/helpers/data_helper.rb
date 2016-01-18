module DataHelper

  # 根据文件获取添入标题和链接之后的最新文本内容
  def self.append_to(file_name, title, link)
    data = []
    changed = false
    inserted = false

    File.open(file_name).each do |line|
      if !inserted and line.start_with?('###') 
        date_str = line.slice(3, line.length).squish
        if(is_date(date_str))
          if(Date.parse(date_str) == Date.today)
            data.push line
            data.push "[#{title}](#{link})\n<br>"
            changed = true
            inserted = true
          elsif(Date.parse(date_str) < Date.today)
            data.push "### #{Date.today}\n<br>"
            data.push "[#{title}](#{link})\n<br>"
            data.push "\n<br>"
          end
        end
      end
      if !changed
        data.push line
      end
      changed = false
    end
    if(!inserted)
       data.push "### #{Date.today}\n"
       data.push "[#{title}](#{link})\n"
       data.push "\n"
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
