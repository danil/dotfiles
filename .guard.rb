# <http://stackoverflow.com/questions/17462475/guardfile-dsl-how-to-make-a-site-specific-config#17470276>,
# <https://github.com/guard/guard/wiki/System-notifications>,
# <http://www.rubydoc.info/github/guard/guard/Guard/Notifier/Emacs>.
guard :rspec do
  notification :tmux,
               change_color: false,
               color_location: 'status-right-fg', #to customize which tmux element will change color
               failed: 'red',
               pending: 'black',
               success: 'black',
               display_message: true
  notification :emacs,
               change_color: false,
               failed: 'black',
               success: 'black'
  notification :notifysend
end
