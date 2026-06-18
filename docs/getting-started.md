# Getting Started with Claude Code Agent Library

Welcome! This guide will help you install and start using custom Claude Code subagents from our library.

## What are Claude Code Subagents?

Claude Code subagents are specialized AI assistants that you can invoke in the Claude Code CLI or IDE to perform specific tasks. Think of them as expert consultants you can call upon - a Python Expert for Python code, a Security Auditor for security reviews, or an Orchestrator to coordinate multiple agents for complex projects.

## Installation

### Prerequisites

- **Claude Code** installed and authenticated
- **Claude Code CLI** installed; VS Code or another supported IDE integration is optional

### For CLI Users

1. **Choose an agent** from the [README](../README.md) agent catalog

2. **Download the agent file** (click the agent link, then download the `.md` file)

3. **Copy to your agents directory**:
 ```bash
 # Create agents directory if it doesn't exist
 mkdir -p ~/.claude/agents
   
 # Copy the downloaded agent
 cp ~/Downloads/orchestrator.md ~/.claude/agents/
 ```

4. **Verify installation**:
 ```bash
 open Claude Code and run /agents
 ```
   
 You should see your installed agent in the list.

5. **Use the agent**:
 ```bash
 claude --agent orchestrator "Your task here"
 ```

### For IDE Users (VS Code)

1. **Choose an agent** from the [README](../README.md) agent catalog

2. **Download the agent file**

3. **Add to your workspace**:
 ```bash
 # Create agents directory in your project
 mkdir -p .claude/agents
   
 # Copy the agent
 cp ~/Downloads/orchestrator.md .claude/agents/
 ```

4. **Reload your IDE** if you are using an editor integration

5. **Use the agent in chat**:
 - Open Claude Code
 - Type: `@orchestrator Your task here`

## Your First Agent

Let's try the **Python Expert** agent:

### Step 1: Install the Agent

```bash
# CLI users
cp .claude/agents/coding/python-expert.md ~/.claude/agents/

# VS Code users  
cp .claude/agents/coding/python-expert.md .claude/agents/
```

### Step 2: Use the Agent

**CLI:**
```bash
claude --agent python-expert "Create a function to parse CSV files with type hints and error handling"
```

**VS Code:**
```
@python-expert Create a function to parse CSV files with type hints and error handling
```

### Step 3: Review the Output

The agent will generate type-annotated Python code following best practices:
- Type hints on all functions
- Proper error handling
- Docstrings
- Example usage

## Installing Multiple Agents

You can install as many agents as you need:

```bash
# Install a full-stack development set
cp .claude/agents/fullstack/frontend-developer.md ~/.claude/agents/
cp .claude/agents/fullstack/backend-developer.md ~/.claude/agents/
cp .claude/agents/fullstack/database-architect.md ~/.claude/agents/

# Install testing agents
cp .claude/agents/testing/test-generator.md ~/.claude/agents/
cp .claude/agents/testing/e2e-tester.md ~/.claude/agents/

# Install the orchestrator to coordinate them all
cp .claude/agents/orchestration/orchestrator.md ~/.claude/agents/
```

## Understanding Agent Capabilities

Each agent specifies its capabilities in the frontmatter:

```yaml
---
name: python-expert
description: Use when you need Python specialist help with type hints, pytest, and modern Python best practices.
model: sonnet
tools: Read, Write, Edit, Grep, Glob, Bash
---
```

**Key fields:**
- **name**: Lowercase kebab-case identifier used for `@python-expert` and `claude --agent python-expert`
- **description**: When Claude Code should select or delegate to this subagent
- **model**: Recommended Claude model alias
- **tools**: Claude Code tools this subagent may use

## Common Use Cases

### Single Agent Tasks

Use one agent for focused tasks:

```bash
# Code review
claude --agent code-reviewer "Review this pull request for quality issues"

# Design conversion
claude --agent figma-to-html "Convert this Figma design to React components"

# Performance optimization
claude --agent performance-optimizer "This API endpoint is slow, help optimize it"
```

### Multi-Agent Workflows

Use the Orchestrator for complex tasks requiring multiple specialists:

```bash
claude --agent orchestrator "Build a user authentication feature with:
- React frontend with login/signup forms
- Node.js backend with JWT authentication
- PostgreSQL database schema
- Comprehensive tests
- Security review"
```

The Orchestrator will:
1. Break down the task
2. Delegate to appropriate specialists (Frontend Dev, Backend Dev, Database Architect, Test Generator, Security Auditor)
3. Coordinate the work
4. Ensure everything integrates

## Tips for Success

### 1. Be Specific

 **Too vague:**
```bash
claude --agent backend-developer "Build an API"
```

 **Better:**
```bash
claude --agent backend-developer "Build a RESTful API for a blog platform with:
- Posts (CRUD operations)
- Comments on posts
- User authentication with JWT
- PostgreSQL database
- Express.js framework"
```

### 2. Provide Context

Include relevant information:
- Technology stack preferences
- Existing patterns to follow
- Constraints or requirements
- Target users or use cases

### 3. Use the Right Agent

- **Broad tasks**  Use **Orchestrator** to coordinate specialists
- **Focused tasks**  Use specific agents (Python Expert, Frontend Developer, etc.)
- **Research needed**  Start with **Research Agent**
- **Planning needed**  Start with **Enhanced Planner**

### 4. Iterate

Agents can refine their work:

```bash
# First request
claude --agent frontend-developer "Create a user profile component"

# Follow-up refinement
claude --agent frontend-developer "Add form validation and loading states to the profile component"
```

## Troubleshooting

### Agent Not Found

**Problem:** `Agent 'orchestrator' not found`

**Solution:** 
- Verify the agent file is in `~/.claude/agents/` (CLI) or `.claude/agents/` (VS Code)
- Check the filename matches: `orchestrator.md`
- Restart Claude Code CLI or reload VS Code

### Agent Not Responding

**Problem:** Agent starts but doesn't complete

**Solution:**
- Check your internet connection
- Verify your Claude subscription is active
- Try a simpler prompt first
- Check if the model specified in the agent is available

### Unexpected Output

**Problem:** Agent's output doesn't match expectations

**Solution:**
- Review the agent's capabilities and limitations in its file
- Provide more specific instructions
- Try a different agent more suited to the task
- Break the task into smaller steps

## Next Steps

- **[Agent Guide](./agent-guide.md)** - Detailed guide for each agent
- **[CLI vs IDE](./cli-vs-ide.md)** - Platform-specific tips
- **[Orchestration Patterns](./orchestration-patterns.md)** - Multi-agent workflows
- **[Best Practices](./best-practices.md)** - Advanced usage patterns

## Need Help?

- Check the [Troubleshooting Guide](./troubleshooting.md)
- Review [agent-specific documentation](./agent-guide.md)
- Open a [GitHub Discussion](../../discussions)
- Report bugs via [GitHub Issues](../../issues)

---

**Ready to dive deeper?** Continue to the [Agent Guide](./agent-guide.md) to learn about each agent's capabilities in detail.
