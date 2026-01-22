# Git Branch in Terminal Prompt

Shows current git branch in bash prompt.

## Screenshot

![Terminal Screenshot](../screenshots/gitbranch-terminal.png)

## Installation

```bash
cat show-gitbranch-terminal.sh >> ~/.bashrc
source ~/.bashrc
```

## What it does

- Adds `parse_git_branch()` function to extract current branch
- Modifies `PS1` to display branch in red after directory path
- Only shows branch when inside a git repository

## Customization

Change branch color by editing `\033[01;31m`:
- `31` = red
- `32` = green
- `33` = yellow
- `34` = blue
- `35` = magenta
- `36` = cyan
