module ApplicationHelper
 

  def self.add_to_file(file, title, link)
    file = File.open(file)
    data = []
    file.each do |line|

    end
    update_file = File.open(file, 'w+')

  end
end
