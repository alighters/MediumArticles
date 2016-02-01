module GitHelper
  

  def self.commit(title)
    t = fork do
      Signal.trap("HUP") {
        system 'git status'
        system 'git add .'
        system "git commit -am 'add #{title}'"
        system 'git pull --rebase'
        system 'git push'
      }
    end
    Process.kill("HUP", t) 
  end
end
