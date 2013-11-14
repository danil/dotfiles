# <https://github.com/fish-shell/fish-shell/issues/486#issuecomment-11773113>.
alias ag="ag --smart-case --color-line-number '2;31' $ARGV"

# Prompt <https://wiki.archlinux.org/index.php/Fish#Configuration>.
# Fish git prompt.
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch magenta
# # Status Chars.
# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '↑'
# set __fish_git_prompt_char_upstream_behind '↓'
# function fish_prompt
#   set last_status $status
#   set_color $fish_color_cwd
#   printf '%s' (prompt_pwd)
#   set_color normal
#   printf '%s ' (__fish_git_prompt)
#   set_color normal
# end

# <https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_prompt.fish>
# Set the default prompt command. Make sure that every terminal escape
# string has a newline before and after, so that fish will know how
# long it is.
function fish_prompt --description "Write out the prompt"

  # Exit status error
  # <http://brettterpstra.com/2009/11/17/my-new-favorite-bash-prompt>.
  set last_status $status
  # Set an error string for the prompt, if applicable
  # (ignore kill e. g. 130 script terminated by control-c
  # <http://www.tldp.org/LDP/abs/html/exitcodes.html>).
  if begin ; test $status -eq 0 ; or test last_status -gt 128 ; end
    set -g __my_status ''
  else
    set -g __my_status ' '(set_color red)'error:'"$last_status"(set_color normal)
  end

  if test (jobs | wc -l) -ne 0
    set -g __my_jobs ' '(set_color red)'jobs:'(jobs | wc -l)(set_color normal)
  else
    set -g __my_jobs ''
  end

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  switch $USER
    case root
    if not set -q __fish_prompt_cwd
      if set -q fish_color_cwd_root
        set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
      else
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
    end
    echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '
    case '*'
    if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end
    echo -n -s "$USER" @ "$__fish_prompt_hostname" "$__my_status" "$__my_jobs" ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" (__fish_git_prompt) "$__fish_prompt_normal" ' '
  end
end
