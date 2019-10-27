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
