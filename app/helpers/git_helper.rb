module GitHelper
  

  def self.commit(title)
    system 'git status'
    system 'git add .'
    system "git commit -am 'add #{title}'"
    system 'git pull --rebase'
    system 'git push'
  end
end
