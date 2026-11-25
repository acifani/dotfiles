#!/bin/sh
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

# Colour code for a value: green below $2, yellow below $3, orange below $4, red from $4.
band() {
  if [ "$1" -ge "$4" ]; then echo 31
  elif [ "$1" -ge "$3" ]; then echo '38;5;208'
  elif [ "$1" -ge "$2" ]; then echo 33
  else echo 32; fi
}

# Time until a reset given as epoch seconds, as 2d4h, 3d, 1h23m, 2h or 45m.
left() {
  s=$(( $1 - now ))
  [ "$s" -gt 0 ] || return
  d=$((s / 86400)); h=$((s % 86400 / 3600)); m=$((s % 3600 / 60))
  if [ "$d" -gt 0 ]; then t="$d"d; [ "$h" -gt 0 ] && t="$t$h"h
  elif [ "$h" -gt 0 ]; then t="$h"h; [ "$m" -gt 0 ] && t="$t$m"m
  else t="$m"m; fi
  printf ' %s%s%s' "$dim" "$t" "$reset"
}

# Quality degrades well before the window is full, so context turns red from 60% full.
context() {
  n=$(printf '%.0f' "$1")
  printf 'ctx %s[%sm%s%%%s' "$esc" "$(band "$n" 20 40 60)" "$n" "$reset"
}

# A rate limit window ($1 label, $2 used %, $3 reset epoch, $4 window seconds), coloured by pace:
# how many points the usage is ahead of the share of the window already elapsed.
limit() {
  n=$(printf '%.0f' "$2")
  if [ -n "$3" ]; then
    elapsed=$(( 100 - ($3 - now) * 100 / $4 ))
    c=$(band $((n - elapsed)) 10 20 30)
    [ "$n" -ge 90 ] && c=31
  else
    c=$(band "$n" 50 75 90)
  fi
  printf '%s %s[%sm%s%%%s%s' "$1" "$esc" "$c" "$n" "$reset" "$([ -n "$3" ] && left "$3")"
}

dir=$(basename "$cwd")
[ "$cwd" = "$HOME" ] && dir="~"
line="${esc}[1;36m${dir}${reset}"

if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null ||
    git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  line="$line ${esc}[35m ${branch}${reset}"
  st=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
  if [ -n "$st" ]; then
    flags=""
    echo "$st" | grep -q '^[MADRC]' && flags="$flags+"
    echo "$st" | grep -q '^.[MD]' && flags="$flags!"
    echo "$st" | grep -q '^??' && flags="$flags?"
    line="$line ${esc}[31m${flags}${reset}"
  fi
fi

[ -n "$model" ] && line="$line$sep$model${effort:+ ${dim}${effort}${reset}}"
[ -n "$ctx" ] && line="$line$sep$(context "$ctx")"

# Subscription plans (pro/team) report rate limits; pay-per-use plans do not, so show session cost instead.
if [ -n "$five" ] || [ -n "$week" ]; then
  [ -n "$five" ] && line="$line$sep$(limit 5h "$five" "$five_reset" 18000)"
  [ -n "$week" ] && line="$line$sep$(limit 7d "$week" "$week_reset" 604800)"
elif [ -n "$cost" ]; then
  line="$line$sep$(printf '$%.2f' "$cost")"
fi

printf '%s\n' "$line"
