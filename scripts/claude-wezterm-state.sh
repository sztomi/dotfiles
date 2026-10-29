#!/bin/sh
# Claude Code hook: publish the agent state to WezTerm as the "claude_state"
# user var, so the tab bar can flag panes that wait for input.
# Usage: claude-wezterm-state.sh waiting|working|idle

[ -n "$WEZTERM_PANE" ] || exit 0

# Hooks run without a controlling terminal (/dev/tty is unusable), so write to
# the tty of the nearest ancestor that has one: the claude process itself.
t=
pid=$PPID
while [ "${pid:-1}" -gt 1 ]; do
  t=$(ps -o tty= -p "$pid" | tr -d ' ')
  case $t in ''|'?'|'??') t= ;; *) break ;; esac
  pid=$(ps -o ppid= -p "$pid" | tr -d ' ')
done
[ -n "$t" ] || exit 0

# A unique suffix lets WezTerm tell a new wait from one already seen.
state=$1
[ "$state" = waiting ] && state="waiting:$(date +%s).$$"

printf '\033]1337;SetUserVar=claude_state=%s\007' \
  "$(printf %s "$state" | base64)" > "/dev/$t" 2>/dev/null
exit 0
