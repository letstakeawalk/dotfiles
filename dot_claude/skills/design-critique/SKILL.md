---
name: design-critique
description: "UI/UX design critique before building. Describe what you want, get feedback on layout, flow, accessibility, and patterns. Use before implementing frontend features."
allowed-tools: Read, Glob, Grep
argument-hint: <description of UI to critique> or <file path to review>
---

## Task

Provide UI/UX design critique before code is written. Catch layout issues, flow problems, accessibility gaps, and pattern mismatches early — when they're cheap to fix.

## When Invoked

Parse `$ARGUMENTS`:
- **Description** (natural language): critique the proposed design
- **File path** (e.g., `src/routes/+page.svelte`): read and critique existing UI
- **Mockup/screenshot path**: read image and critique visual design
- **No arguments**: ask what to critique

## Critique Framework

### 1. Layout & Hierarchy
- Is visual hierarchy clear? Most important action obvious?
- Spacing and alignment consistent?
- Does it work at different viewport sizes?
- Is there visual clutter that can be removed?

### 2. User Flow
- Can user complete primary task in minimum steps?
- Are error states and empty states handled?
- Is navigation between states clear?
- Any dead ends or confusing transitions?

### 3. Accessibility
- Sufficient color contrast (WCAG AA minimum)?
- Keyboard navigable? Focus order logical?
- Screen reader friendly? Labels on interactive elements?
- Touch targets large enough (44x44px minimum)?

### 4. Patterns & Consistency
- Following established design system / component library?
- Consistent with rest of the app?
- Using standard patterns users already know?
- Any anti-patterns? (e.g., mystery meat navigation, hidden actions)

### 5. Copy & Messaging
- Labels clear and concise?
- Error messages actionable? (what happened + how to fix)
- Empty states guide user to next action?
- No jargon users won't understand?

## Output Format

```
## Design Critique: [component/page name]

### Summary
[1-2 sentence overall assessment]

### Findings
1. [area]: [severity]: [issue]. [suggestion].
2. ...

### Strengths
- [what works well — reinforce good decisions]

### Recommendation
[build as-is | revise before building | needs major rethink]
```

Severity: `blocker` (will confuse users), `risk` (suboptimal UX), `nit` (minor polish).

## Rules

- Critique the design, not the designer
- Be specific — "button is hard to find" → "primary CTA below fold on mobile, move above hero"
- Always mention what works well, not just problems
- If reviewing code, focus on UX impact, not code quality (that's `/review`)
- If no major issues, say so — don't manufacture problems
