# Shared Agents

This directory is a shared home for reusable agent prompts and Codex skills.

## Layout

- `agents/*.md`: reusable agent prompt files for general or domain-specific work.
- `skills/*/SKILL.md`: Codex skills with task-specific instructions.

## Notes

- `~/.agents` currently points to this directory via symlink.
- Codex already reads skills from the local agent ecosystem; these markdown agent files are intended as reusable prompts and shared configuration assets.
- Other tools such as Copilot may require additional configuration to explicitly reference a prompt file, but this folder structure is a reasonable shared source of truth.

## Current Agents

- `agents/general-dev.md`: baseline development agent for everyday repository work.
