---
name: Commit
interaction: inline
description: Generate commit message
opts:
  alias: commit
  auto_submit: false
  is_slash_cmd: true
  adapter:
    name: copilot
    model: gemini-3-flash-preview
---

## user

`````diff
${commit.diff}
`````

Write a git commit message. Follow these rules:

  - Title is 50 chars or less and sentence case.
  - Title isn't prefixed with 'feat', 'fix', etc.
  - If there is more than one change, add description that starts with 'Includes:' followed by a blank line and then a dashed list of changes.
  - Write using imperative language.
  - Be concise and avoid redundancy.
  - Use tick marks around references to code or files.

Output only the commit message without any explanations and follow-up suggestions.
