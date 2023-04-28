# path
fish_add_path ~/.local/bin

# env variables
set -x EDITOR nvim
set -x TERMINAL st
set -x BROWSER firefox

set -x WAKATIME_HOME "$HOME/.wakatime"

if status is-interactive
	set fish_greeting # empty greeting
	source ~/.config/aliasrc

	# man colors
	set -x LESS_TERMCAP_mb (printf "\033[01;31m")  
	set -x LESS_TERMCAP_md (printf "\033[01;31m")  
	set -x LESS_TERMCAP_me (printf "\033[0m")  
	set -x LESS_TERMCAP_se (printf "\033[0m")  
	set -x LESS_TERMCAP_so (printf "\033[01;44;33m")  
	set -x LESS_TERMCAP_ue (printf "\033[0m")  
	set -x LESS_TERMCAP_us (printf "\033[01;32m")  

	# vi mode
	function fish_user_key_bindings
	    # Execute this once per mode that emacs bindings should be used in
	    fish_default_key_bindings -M insert

	    # Then execute the vi-bindings so they take precedence when there's a conflict.
	    # Without --no-erase fish_vi_key_bindings will default to
	    # resetting all bindings.
	    # The argument specifies the initial mode (insert, "default" or visual).
	    fish_vi_key_bindings --no-erase insert
	end
	set fish_cursor_default block
	set fish_cursor_insert line
	set fish_cursor_replace_one underscore
	set fish_cursor_visual block
end

if status is-login
	pgrep Xorg || sx
end
