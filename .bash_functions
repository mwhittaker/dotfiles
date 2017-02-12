# http://askubuntu.com/a/110933
# Go up directory tree X number of directories
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

# preview options for ..
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

# Random string generation.
randstring() {
    if [[ "$#" -eq 0 ]]; then
        len=50
    elif [[ "$#" -eq 1 ]]; then
        len="$1"
    else
        echo "usage: randstring <len>";
        return
    fi
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$len"; echo ''
}

# Printing. See https://iris.eecs.berkeley.edu/15-faq/10-unix/00-printing.html.
print() {
    if [[ "$#" -lt 1 ]]; then
        echo "usage: print <file>..."
    fi
    lpr -P Soda730 -o sides=two-sided-long-edge "$@"
}

print_status() {
    lpq -P Soda730
}

print_cancel() {
    if [[ "$#" -lt 1 ]]; then
        echo "usage: print_cancel <job_id>..."
    fi
    lprm -P Soda730 "$@"
}
