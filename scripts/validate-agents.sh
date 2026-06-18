#!/bin/bash
# Agent Validation Script
# Tests that all agent files are properly formatted and loadable

set -e

AGENTS_DIR="./.claude/agents"
EXPECTED_AGENTS=36
ERRORS=0
WARNINGS=0
FAILED_FILES=0

echo " Claude Code Agent Library - Validation Script"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if agents directory exists
if [ ! -d "$AGENTS_DIR" ]; then
  echo -e "${RED} Error: agents/ directory not found${NC}"
  exit 1
fi

# Count total agents
TOTAL_AGENTS=$(find "$AGENTS_DIR" -name "*.md" | wc -l)
echo " Found $TOTAL_AGENTS agent files"
echo ""

if [ "$TOTAL_AGENTS" -ne "$EXPECTED_AGENTS" ]; then
  echo -e "${RED} Expected $EXPECTED_AGENTS agents, found $TOTAL_AGENTS${NC}"
  ERRORS=$((ERRORS + 1))
fi

echo " Validating agent files..."
echo ""

# Validate each agent file
while IFS= read -r agent_file; do
  AGENT_NAME=$(basename "$agent_file" .md)
  FILE_FAILED=0

  # Check 1: File is not empty
  if [ ! -s "$agent_file" ]; then
      echo -e "${RED} $AGENT_NAME: File is empty${NC}"
      ERRORS=$((ERRORS + 1))
      FAILED_FILES=$((FAILED_FILES + 1))
      continue
  fi

  # Check 2: Has YAML frontmatter
  if ! head -n 1 "$agent_file" | grep -q "^---$"; then
      echo -e "${RED} $AGENT_NAME: Missing YAML frontmatter (should start with ---)${NC}"
      ERRORS=$((ERRORS + 1))
      FAILED_FILES=$((FAILED_FILES + 1))
      continue
  fi

  # Check 3: Has required fields (name, description)
  if ! grep -q "^name:" "$agent_file"; then
      echo -e "${RED} $AGENT_NAME: Missing 'name:' field${NC}"
      ERRORS=$((ERRORS + 1))
      FAILED_FILES=$((FAILED_FILES + 1))
      continue
  fi

  if ! grep -q "^description:" "$agent_file"; then
      echo -e "${RED} $AGENT_NAME: Missing 'description:' field${NC}"
      ERRORS=$((ERRORS + 1))
      FAILED_FILES=$((FAILED_FILES + 1))
      continue
  fi

  if ! grep -q "^model: sonnet$" "$agent_file"; then
      echo -e "${RED} $AGENT_NAME: Expected 'model: sonnet'${NC}"
      ERRORS=$((ERRORS + 1))
      FILE_FAILED=1
  fi

  if ! grep -Eq "^name: [a-z0-9]+(-[a-z0-9]+)*$" "$agent_file"; then
      echo -e "${RED} $AGENT_NAME: Agent name must be lowercase kebab-case${NC}"
      ERRORS=$((ERRORS + 1))
      FILE_FAILED=1
  fi

  if grep -Eq "^(agents|handoffs):" "$agent_file"; then
      echo -e "${RED} $AGENT_NAME: Found unsupported Claude Code frontmatter field${NC}"
      ERRORS=$((ERRORS + 1))
      FILE_FAILED=1
  fi

  if grep -q "^tools:" "$agent_file"; then
      TOOLS=$(grep "^tools:" "$agent_file" | head -n 1 | cut -d: -f2-)
      IFS=', ' read -ra TOOL_LIST <<< "$TOOLS"
      for TOOL in "${TOOL_LIST[@]}"; do
          case "$TOOL" in
              Read|Write|Edit|Grep|Glob|Bash|WebSearch|WebFetch|Agent|NotebookEdit) ;;
              *)
                  echo -e "${RED} $AGENT_NAME: Unsupported tool '$TOOL'${NC}"
                  ERRORS=$((ERRORS + 1))
                  FILE_FAILED=1
                  ;;
          esac
      done
  else
      echo -e "${RED} $AGENT_NAME: Missing 'tools:' field${NC}"
      ERRORS=$((ERRORS + 1))
      FILE_FAILED=1
  fi

  # Check 4: Has content after frontmatter
  CONTENT_LINES=$(tail -n +10 "$agent_file" | grep -v "^$" | wc -l)
  if [ "$CONTENT_LINES" -lt 10 ]; then
      echo -e "${YELLOW}  $AGENT_NAME: Very short content (< 10 lines)${NC}"
      WARNINGS=$((WARNINGS + 1))
  fi

  # Check 5: File size is reasonable
  FILE_SIZE=$(stat -c%s "$agent_file" 2>/dev/null || stat -f%z "$agent_file" 2>/dev/null || echo 0)
  if [ "$FILE_SIZE" -lt 1000 ]; then
      echo -e "${YELLOW}  $AGENT_NAME: Small file size (< 1KB)${NC}"
      WARNINGS=$((WARNINGS + 1))
  fi

  if [ "$FILE_FAILED" -eq 0 ]; then
      echo -e "${GREEN} $AGENT_NAME${NC}"
  else
      FAILED_FILES=$((FAILED_FILES + 1))
  fi
done < <(find "$AGENTS_DIR" -name "*.md" | sort)

echo ""
echo "=============================================="
echo " Validation Summary"
echo "=============================================="
echo "Total agents: $TOTAL_AGENTS"
echo -e "${GREEN}Passed: $((TOTAL_AGENTS - FAILED_FILES))${NC}"
echo -e "${RED}Errors: $ERRORS${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"
echo ""

if [ $ERRORS -gt 0 ]; then
  echo -e "${RED} Validation failed with $ERRORS error(s)${NC}"
  exit 1
else
  echo -e "${GREEN} All validations passed!${NC}"

  if [ $WARNINGS -gt 0 ]; then
      echo -e "${YELLOW}  $WARNINGS warning(s) - review recommended${NC}"
  fi
fi

echo ""
echo "Next steps:"
echo "1. Test agents in Claude Code: open Claude Code and run /agents"
echo "2. Test project agents from this repository's .claude/agents/ directory"
echo "3. Run test scenarios from TESTING.md"
