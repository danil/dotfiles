# Persist Rails or IRB console command history after exit
# <http://stackoverflow.com/questions/10465251/can-i-get-the-ruby-on-rails-console-to-remember-my-command-history-umm-better#10467597>.
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# # Emacs fail to determine IRB prompt from RVM
# # <http://blog.cinsk.org/2012/08/emacs-ruby-mode-and-rvm-prompt.html>.
# IRB.conf[:PROMPT_MODE] = :DEFAULT
