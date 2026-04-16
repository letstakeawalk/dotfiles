# Vivaldi Preferences Backup

## Backup (after making changes in Vivaldi)

Quit Vivaldi first, then:

```bash
jq '{
  actions: .vivaldi.actions,
  appearance: .vivaldi.appearance,
  address_bar: .vivaldi.address_bar,
  tabs: .vivaldi.tabs,
  panels: .vivaldi.panels,
  chained_commands: .vivaldi.chained_commands,
  quick_commands: .vivaldi.quick_commands,
  dashboard: .vivaldi.dashboard,
  startpage: .vivaldi.startpage,
  themes: (.vivaldi.themes | {current, current_private, user}),
  toolbars: .vivaldi.toolbars,
  windows: .vivaldi.windows,
  menu: .vivaldi.menu,
  status_bar: .vivaldi.status_bar,
  workspaces: .vivaldi.workspaces
}' ~/Library/Application\ Support/Vivaldi/Default/Preferences > ~/.local/share/chezmoi/browser/vivaldi/preferences.json
```

## Restore (manual)

Quit Vivaldi first, then:

```bash
PREFS=~/Library/Application\ Support/Vivaldi/Default/Preferences
cp "$PREFS" "$PREFS.bak"
jq --slurpfile src "$(chezmoi source-path)/browser/vivaldi/preferences.json" '
  .vivaldi += ($src[0] | del(.themes) | to_entries | from_entries)
  | .vivaldi.themes.current = $src[0].themes.current
  | .vivaldi.themes.current_private = $src[0].themes.current_private
  | .vivaldi.themes.user = $src[0].themes.user
' "$PREFS" > /tmp/vivaldi_prefs.json \
  && mv /tmp/vivaldi_prefs.json "$PREFS"
```

Requires Vivaldi to have been opened at least once (to create `Preferences`).

## Search engines

Synced automatically by Vivaldi. No manual backup needed.

### Custom search engines (for reference)

| Keyword | Name | URL |
|---------|------|-----|
| `cr` | Crates.io | `https://crates.io/search?q={searchTerms}` |
| `drs` | Docs.rs | `https://docs.rs/releases/search?query={searchTerms}` |
| `gh` | GitHub | `https://github.com/search?q={searchTerms}` |
