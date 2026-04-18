# Zen Browser Config Backup

Profile location: `~/Library/Application Support/zen/Profiles/<hash>.Default (release)/`

## Files

| File | What |
|------|------|
| `user.js` | Curated about:config prefs (privacy, UI, zen-specific) |
| `zen-keyboard-shortcuts.json` | Custom keyboard shortcuts |
| `containers.json` | Multi-account containers |
| `userContent.css` | Custom CSS |

## Backup (after making changes in Zen)

Quit Zen first, then run `./backup.sh`.

Or manually:

```bash
PROFILE=$(./backup.sh --profile-path)
cp "$PROFILE/zen-keyboard-shortcuts.json" browser/zen/
cp "$PROFILE/containers.json" browser/zen/
# Review prefs.js and update user.js with any new intentional prefs
```

## Restore (manual)

Quit Zen first, then run `./restore.sh`.

Requires Zen to have been opened at least once (to create the profile).

## Notes

- `user.js` is read by Zen on startup and overrides matching keys in `prefs.js`
- Zen syncs bookmarks, history, extensions via Firefox Sync — no backup needed
- Extension settings (uBlock filters, Vimium config, etc.) are per-extension — sync or export separately
