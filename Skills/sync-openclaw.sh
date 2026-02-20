#!/bin/bash
# Symlink skills from external repo to OpenClaw workspace

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_SKILLS_DIR="${1:-$SCRIPT_DIR}"  # Default to script location or pass as arg
OPENCLAW_SKILLS_DIR="$HOME/.openclaw/workspace/skills"

# Validate source directory
if [ ! -d "$REPO_SKILLS_DIR" ]; then
  echo "❌ Skills directory not found: $REPO_SKILLS_DIR"
  echo "Usage: $0 [path-to-repo-skills-folder]"
  exit 1
fi

# Create target directory if needed
mkdir -p "$OPENCLAW_SKILLS_DIR"

echo "🔗 Syncing skills from: $REPO_SKILLS_DIR"
echo "            to: $OPENCLAW_SKILLS_DIR"
echo ""

# Remove broken symlinks
echo "🧹 Cleaning up broken symlinks..."
find "$OPENCLAW_SKILLS_DIR" -maxdepth 1 -type l ! -exec test -e {} \; -delete 2>/dev/null || true

# Symlink each skill folder
for skill in "$REPO_SKILLS_DIR"/*; do
  if [ -d "$skill" ]; then
    skill_name=$(basename "$skill")
    target="$OPENCLAW_SKILLS_DIR/$skill_name"
    
    if [ -L "$target" ]; then
      echo "✓ $skill_name (already linked)"
    elif [ -e "$target" ]; then
      echo "⚠️  $skill_name (exists but not a symlink, skipping)"
    else
      ln -s "$skill" "$target"
      echo "✅ $skill_name (linked)"
    fi
  fi
done

echo ""
echo "✅ Done! Skills synced."
