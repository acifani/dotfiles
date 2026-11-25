#!/bin/sh
export LC_ALL=C
export PATH="$HOME/.local/share/mise/shims:$PATH"
eval "$(jq -r '@sh "
  cwd=\(.workspace.project_dir // .workspace.current_dir // .cwd)
  model=\(.model.display_name // "")
  effort=\(.effort.level // "")
  ctx=\(.context_window.used_percentage // "")
  cost=\(.cost.total_cost_usd // "")
  five=\(.rate_limits.five_hour.used_percentage // "")
  week=\(.rate_limits.seven_day.used_percentage // "")
  five_reset=\(.rate_limits.five_hour.resets_at // "")
  week_reset=\(.rate_limits.seven_day.resets_at // "")
"')"

esc=$(printf '\033')
reset="${esc}[0m"
dim="${esc}[2m"
sep=" ${dim}·${reset} "
now=$(date +%s)

threshold_colour() {
  if [ "$1" -ge "$4" ]; then echo 31
  elif [ "$1" -ge "$3" ]; then echo '38;5;208'
  elif [ "$1" -ge "$2" ]; then echo 33
  else echo 32; fi
}

time_until() {
  s=$(( $1 - now ))
  [ "$s" -gt 0 ] || return
  d=$((s / 86400)); h=$((s % 86400 / 3600)); m=$((s % 3600 / 60))
  if [ "$d" -gt 0 ]; then t="$d"d; [ "$h" -gt 0 ] && t="$t$h"h
  elif [ "$h" -gt 0 ]; then t="$h"h; [ "$m" -gt 0 ] && t="$t$m"m
  else t="$m"m; fi
  printf ' %s%s%s' "$dim" "$t" "$reset"
}

context() {
  n=$(printf '%.0f' "$1")
  printf 'ctx %s[%sm%s%%%s' "$esc" "$(threshold_colour "$n" 20 40 60)" "$n" "$reset"
}

rate_limit() {
  n=$(printf '%.0f' "$2")
  if [ -n "$3" ]; then
    elapsed=$(( 100 - ($3 - now) * 100 / $4 ))
    c=$(threshold_colour $((n - elapsed)) 10 20 30)
    [ "$n" -ge 90 ] && c=31
  else
    c=$(threshold_colour "$n" 50 75 90)
  fi
  printf '%s %s[%sm%s%%%s%s' "$1" "$esc" "$c" "$n" "$reset" "$([ -n "$3" ] && time_until "$3")"
}

dir=$(basename "$cwd")
[ "$cwd" = "$HOME" ] && dir="~"
line="${esc}[1;36m${dir}${reset}"

if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  line="$line ${esc}[35m ${branch}${reset}"
  changes=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
  if [ -n "$changes" ]; then
    flags=""
    echo "$changes" | grep -q '^[MADRCTU]' && flags="$flags+"
    echo "$changes" | grep -q '^.[MDTU]' && flags="$flags!"
    echo "$changes" | grep -q '^??' && flags="$flags?"
    line="$line ${esc}[31m${flags}${reset}"
  fi
fi

[ -n "$model" ] && line="$line$sep$model${effort:+ ${dim}${effort}${reset}}"
[ -n "$ctx" ] && line="$line$sep$(context "$ctx")"

if [ -n "$five" ] || [ -n "$week" ]; then
  [ -n "$five" ] && line="$line$sep$(rate_limit 5h "$five" "$five_reset" 18000)"
  [ -n "$week" ] && line="$line$sep$(rate_limit 7d "$week" "$week_reset" 604800)"
elif [ -n "$cost" ]; then
  line="$line$sep$(printf '$%.2f' "$cost")"
fi

printf '%s\n' "$line"
