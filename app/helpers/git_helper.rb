module GitHelper
  

  def self.commit(title)
    t = fork do
      system 'git status'
      system 'git add .'
      system "git commit -am 'add #{title}'"
      system 'git pull --rebase'
      system 'git push'
    end
    Process.kill t
  end
end
