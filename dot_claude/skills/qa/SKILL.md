---
name: qa
description: "Run QA on the current project. Auto-detects project type and runs browser testing for frontend projects. Use after implementing features to verify they work end-to-end."
allowed-tools: Read, Glob, Grep, Bash(bun run:*), Bash(npm run:*), Bash(curl:*), Bash(lsof:*), Bash(kill:*), mcp__plugin_playwright_playwright__*
argument-hint: [url or flow to test] [--fix]
---

## Task

Verify the project works end-to-end by running it and testing interactively. Not a code review — this is runtime behavior testing.

## Project Detection

1. Check for project markers:
   - `svelte.config.js` or `+page.svelte` files → **SvelteKit** (browser QA)
   - `next.config.*` or `app/page.tsx` → **Next.js** (browser QA)
   - `vite.config.*` with no framework → **Vite SPA** (browser QA)
2. Detect package manager: `bun.lock`/`bun.lockb` → bun, `package-lock.json` → npm
3. If none detected, ask user what to test

## Browser QA (Frontend)

### Setup
1. Detect dev server port:
   - Read `vite.config.*` for `server.port`
   - Check `package.json` scripts for `--port` flag
   - Default: 5173 (Vite/SvelteKit), 3000 (Next.js)
2. Check if dev server already running: `lsof -i :<port>`
3. If not running:
   - Start with detected package manager: `bun run dev` or `npm run dev` (background)
   - Set `started_server = true` (track for cleanup)
   - Poll port with `lsof -i :<port>` every 2s until ready (timeout 30s)
4. Navigate to the app URL

### Test Flow
1. Take accessibility snapshot (`browser_snapshot`) to understand page structure
2. If `$ARGUMENTS` specifies a flow, test that flow
3. If no arguments, test the current page:
   - Verify page loads without errors
   - Check console for errors/warnings (`browser_console_messages`)
   - Check network for failed requests (`browser_network_requests`)
   - Screenshot the page (`browser_take_screenshot`)
   - Test interactive elements: click buttons, fill forms, navigate links
   - Verify state changes after interactions
4. For each issue found:
   - Screenshot the broken state
   - Note the console errors
   - Identify the likely cause

### Common Flows to Test
- Navigation between pages
- Form submission (valid + invalid input)
- Auth flow (login/logout) if present
- Empty states and loading states
- Error handling (what happens when API fails?)
- Responsive layout (resize to mobile: 375px width)

## Reporting

```
### QA Report: [project name]

**Environment:** [type] on port [port] | [base url]

### Tested
1. [flow]: pass | fail
   [details if fail — console error, screenshot ref, etc.]

### Console Errors
[list any JS errors or warnings, or "None"]

### Network Issues
[list any failed requests, or "None"]

### Verdict: PASS | FAIL | PARTIAL
[one-line summary]
```

## Fix Mode (`--fix`)

When `$ARGUMENTS` contains `--fix`:
1. Run QA as normal
2. For each failure, attempt to fix the root cause
3. Re-test after fix to verify
4. Report what was fixed and what remains

Only fix clear bugs (broken handlers, missing imports, wrong selectors). Leave ambiguous UX issues for user.

## Rules

- Don't start a dev server if one is already running on the port
- Always check console and network — many bugs are silent in the UI
- Screenshot before and after interactions — visual evidence
- If dev server fails to start, report the error and stop
- Close browser when done (`browser_close`)
- Kill dev server only if `started_server = true` — never kill a server you didn't start
- If testing many pages/endpoints, limit to 10 most important. Ask user to prioritize if more
