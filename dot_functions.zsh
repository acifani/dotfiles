weather() {
    city="$1"

    if [ -z "$city" ]; then
        city="Milan"
    fi

    eval "curl http://wttr.in/${city}"
}

hdi() {
    howdoi $* -c -n 5;
}

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}
