#!/bin/bash
# Pull latest skills from Git repo and copy them to OpenClaw workspace

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_SKILLS_DIR="${1:-$SCRIPT_DIR}"  # Default to script location or pass as arg
OPENCLAW_SKILLS_DIR="$HOME/.openclaw/workspace/skills"

# Validate source directory
if [ ! -d "$REPO_SKILLS_DIR" ]; then
  echo "❌ Skills directory not found: $REPO_SKILLS_DIR"
  echo "Usage: $0 [path-to-repo-skills-folder]"
  exit 1
fi

# Pull latest changes from Git
echo "⬇️  Pulling latest changes from Git..."
git -C "$REPO_ROOT" pull
echo ""

# Create target directory if needed
mkdir -p "$OPENCLAW_SKILLS_DIR"

echo "📂 Copying skills from: $REPO_SKILLS_DIR"
echo "                    to: $OPENCLAW_SKILLS_DIR"
echo ""

# Copy each skill folder
for skill in "$REPO_SKILLS_DIR"/*; do
  if [ -d "$skill" ]; then
    skill_name=$(basename "$skill")
    target="$OPENCLAW_SKILLS_DIR/$skill_name"

    rm -rf "$target"
    cp -r "$skill" "$target"
    echo "✅ $skill_name (copied)"
  fi
done

echo ""
echo "✅ Done! Skills synced."
