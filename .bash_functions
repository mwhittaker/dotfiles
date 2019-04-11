# `.. n` goes up the directory tree `n` times. For example, `.. 3` is
# equivalent to `cd ../../..`. `..` is equivalent to `cd ..`. see [1] for more
# information.
#
# [1]: http://askubuntu.com/a/110933
..() {
    COUNTER="$@";

    # default $COUNTER to 1 if it isn't already set
    if [[ -z $COUNTER ]]; then
        COUNTER=1
    fi

    # make sure $COUNTER is a number
    if [ $COUNTER -eq $COUNTER 2> /dev/null ]; then
        nwd=`pwd` # Set new working directory (nwd) to current directory
        # Loop $nwd up directory tree one at a time
        until [[ $COUNTER -lt 1 ]]; do
            nwd=`dirname $nwd`
            let COUNTER-=1
        done
        cd $nwd # change directories to the new working directory
    else
        # print usage and return error
        echo "usage: .. [NUMBER]"
        return 1
    fi
}

# `...` shows a preview of all parent directories to make it easier to run
# `..`. For example,
#
#   $ ...
#    0. /Users/mwhittaker/git/mwhittaker/dotfiles [0]
#    1. /Users/mwhittaker/git/mwhittaker [1]
#    2. /Users/mwhittaker/git [2]
#    3. /Users/mwhittaker [3]
#    4. /Users [4]
#    5. / [5]
#   $ .. 3
#   $ pwd
#   /Users/mwhittaker
...() {
    dir="$(pwd)"
    i=0
    while true; do
        if test $((i % 2)) -eq 0; then
            printf "\x1b[37m%2d. %s [%d]\x1b[0m\n" "$i" "$dir" "$i"
        else
            printf "%2d. %s [%d]\n" "$i" "$dir" "$i"
        fi

        if test "$dir" = "/"; then
            return
        fi

        dir=$(cd "$dir/.."; pwd)
        i=$((i + 1))
    done
}

# latex
tex() {
    if [ "$TMUX" ]; then
        tmux resize-pane -D 100
        tmux resize-pane -U 6
    fi
    latexmk -pvc -pdf -quiet "$1" 2>&1 | grep --color -E '^|Failure'
}

# NERDTree
nt() {
    vim +"NERDTree $1"
}

# Clone a repository from GitHub
githubclone() {
    if [[ "$#" -ne 2 ]]; then
        echo "usage: githubclone <user> <repo>"
        return
    fi
    git clone "git@github.com:$1/$2"
}

# Copying to clipboard.
copy() {
    if [[ "$#" -gt 1 ]]; then
        echo "Usage: copy [filename]"
        return 1
    fi

    if [[ "$(uname)" = "Darwin" ]]; then
        if [[ "$#" -eq 0 ]]; then
            pbcopy
        else
            cat "$1" | pbcopy
        fi
    else
        echo "Linux not yet implemented."
        return 1
    fi
}

tdir() {
    if [[ -n "$TMUX" ]]; then
        echo "ERROR: you cannot run tdir from within tmux."
        return 1
    fi

    if [[ "$#" -eq 0 ]]; then
        tmux new-session -s "${PWD##*/}"
    fi

    for d in "$@"; do
        tmux new-session -d -c "$d" -s "$(basename $d)"
    done
}

tpane() {
    tmux display -pt "${TMUX_PANE:?}" '#{pane_index}'
}

# trun is a tool to run a set of bash commands in separate panes within a
# window of a tmux session. Here are some examples:
#
#   $ trun 'echo hi' 'echo sup'
#
# If we're not within tmux, this creates a new session with a single window.
# This window has two panes: one with 'echo hi' and one with 'echo sup'. If
# we're within a tmux session, it creates a new window with 'echo hi' and 'echo
# sup'.
#
#   $ trun -s foo 'echo hi' 'echo sup'
#
# Run 'echo hi' and 'echo sup' within a session named `foo`. If a session named
# `foo`, does not already exist, one is created.
#
#   $ trun -s -d foo 'echo hi' 'echo sup'
#
# Run 'echo hi' and 'echo sup' within a session named `foo`, but do not attach
# to it. This allows us to create multiple windows within a session liek this:
#
#   $ trun -s foo -d 'echo this is in window 1' 'echo this too'
#   $ trun -s foo -d 'echo this is in window 2' 'echo this too'
#   $ trun -s foo 'echo this is in window 3' 'echo this line will attach'
trun() {
    local OPTIND
    local session_id=""
    local detach=false
    while getopts "hs:d" opt; do
        case ${opt} in
            h )
                echo "trun [-s session_name] [-d] cmd [cmd]..."
                return 0
                ;;
            s )
                session_id="$OPTARG"
                ;;
            d )
                detach=true
                ;;
            \? )
                echo "trun [-s session_name] [-d] cmd [cmd]..."
                return 1
                ;;
            : )
                echo "$OPTARG reqiures an argument."
                usage "$0"
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # No commands were given.
    if [[ $# -eq 0 ]]; then
        echo "trun [-s session_name] [-d] cmd [cmd]..."
        return 1
    fi

    # Create the session if necessary.
    if [[ -n $session_id ]]; then
        if tmux has-session -t "$session_id"; then
            local new_session_created=false
        else
            TMUX="" tmux new-session -d -s "$session_id"
            local new_session_created=true
        fi
    else
        if [[ -z "${TMUX:-}" ]]; then
            session_id="$(tmux display-message -p '#S')"
            local new_session_created=false
        else
            tmux new-session -d
            session_id="$(tmux display-message -p '#S')"
            local new_session_created=true
        fi
    fi

    # Create a new window, but only if we're already within the session.
    if $new_session_created; then
        window_id="${session_id}:0"
    else
        window_id="$(tmux new-window \
                       -t "$session_id:" \
                       -P \
                       -F '#{session_name}:#{window_index}')"
    fi

    # Create a new pane for every command, and arrange nicely.
    for ((i = 0; i < "$(($# - 1))"; ++i)); do
        tmux split-window -t "${window_id}.0" -h -p 1
    done
    tmux select-layout -t "$window_id" even-vertical

    # Run the commands.
    for ((i = 1; i <= "$#"; ++i)); do
        tmux send-keys -t "${window_id}.$((i - 1))" "${!i}" C-m
    done

    # Attach to the session
    if [[ -z "${TMUX:-}" ]] && ! "$detach"; then
        tmux attach -t "$session_id"
    fi
}

# Let's say you open up a fresh terminal. Bash stores a history of the commands
# you type into this terminal in two places.
#
#   1. Bash stores history in memory. The number of commands that are stored in
#      memory is controlled by the HISTSIZE variable.
#   2. Bash stores history in ~/.bash_history. The number of commands that are
#      stored in this file is controlled by the HISTFILESIZE variable.
#
# When you open up a fresh terminal, bash reads history from ~/.bash_history
# and loads it in memory. When you enter commands, bash caches the commands in
# memory and doesn't write them to ~/.bash_history. When you exit the terminal,
# then bash copies the commands in memory into ~/.bash_history.
#
# Most of the time, this policy of caching history and writing it to a file
# only when the terminal exits is great. However, it can sometimes be
# inconvenient when working with multiple tmux panes. The history of one pane
# cannot be used by another.
#
# write_history and read_history are two commands to help share history across
# tmux panes. write_history flushes in-memory history to ~/.bash_history, and
# read_history reloads in-memory history from ~/.bash_history. So if you run a
# command in one tmux pane and want to share it with another, simply run
# write_history in the first pane and read_history in the second.
#
# See `help history` for more information on how history works.
write_history() {
    # Write our in-memory history to ~/.bash_history.
    history -a
}

read_history() {
    # Write our in-memory history to ~/.bash_history, so that it's not lost.
    history -a

    # Clear our in-memory history.
    history -c

    # Load our in-memory history from ~/.bash_history.
    history -r
}
