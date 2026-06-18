# Troubleshooting Guide

Common issues and solutions when using Claude Code subagents.

## Installation Issues

### Agent Not Found

**Problem:**
```bash
claude --agent orchestrator "task"
Error: Agent 'orchestrator' not found
```

**Solutions:**

1. **Verify file location:**
 ```bash
 # CLI users - check ~/.claude/agents/
 ls -la ~/.claude/agents/
   
 # IDE users - check .claude/agents/ in workspace
 ls -la .claude/agents/
 ```

2. **Check filename:**
 - Must end with `.md`
 - Name must match: `orchestrator.md`
 - No extra extensions: ~~`orchestrator.md.txt`~~

3. **Reload/restart:**
 ```bash
 # CLI: No restart needed, should work immediately
   
 # VS Code: Reload window
 # Cmd/Ctrl + Shift + P  "Developer: Reload Window"
 ```

4. **Check file permissions:**
 ```bash
 chmod 644 ~/.claude/agents/orchestrator.md
 ```

### Agent List Is Empty

**Problem:**
```bash
open Claude Code and run /agents
# Shows no agents
```

**Solutions:**

1. **Create agents directory:**
 ```bash
 mkdir -p ~/.claude/agents
 ```

2. **Verify Claude Code CLI is updated:**
 ```bash
 claude update
 ```

3. **Check Claude Code authentication:**
 ```bash
 gh auth status
 # Should show you're logged in with Claude Code access
 ```

## Agent Execution Issues

### Agent Starts But Doesn't Complete

**Problem:** Agent invocation hangs or times out

**Solutions:**

1. **Check internet connection:**
 - Agents require API access
 - Test: `ping github.com`

2. **Verify Claude subscription:**
 ```bash
 claude --version
 ```
 Should show active subscription

3. **Simplify the prompt:**
 ```bash
 # Too complex might timeout
 claude --agent orchestrator "Build entire enterprise application..."
   
 # Start simpler
 claude --agent orchestrator "Create basic REST API structure"
 ```

4. **Check model availability:**
 - Some agents specify models (sonnet, sonnet)
 - If model unavailable, edit agent file to use different model
   
 ```yaml
 # In agent file
 model: sonnet  # Try changing to sonnet
 ```

### Agent Output Is Truncated

**Problem:** Agent response cuts off mid-sentence

**Solutions:**

1. **CLI - save to file:**
 ```bash
 claude --agent orchestrator "task" > output.md
 ```

2. **Request in parts:**
 ```bash
 # Instead of one huge request
 claude --agent backend-developer "Build complete backend"
   
 # Break it down
 claude --agent backend-developer "Create user model and repository"
 claude --agent backend-developer "Create authentication service"
 ```

3. **Increase terminal buffer** (terminal-dependent)

### "Rate Limited" or "Too Many Requests"

**Problem:**
```
Error: Rate limit exceeded
```

**Solutions:**

1. **Wait and retry** (rate limits typically reset within minutes)

2. **Spread out requests:**
 ```bash
 # Don't run 20 agents in parallel
   
 # Instead, batch appropriately
 claude --agent orchestrator "handle coordination"
 ```

3. **Check Claude Code usage limits for your plan**

## Output Quality Issues

### Agent Doesn't Understand Context

**Problem:** Agent produces generic code that doesn't match your project

**Solutions:**

1. **Provide explicit context:**
 ```bash
 # Bad - no context
 claude --agent backend-developer "Create user service"
   
 # Good - rich context
 claude --agent backend-developer "Create user service for our Node.js app:
 - Tech stack: TypeScript, Express, Prisma ORM, PostgreSQL
 - Follow existing pattern in src/services/product.service.ts
 - Use dependency injection from tsyringe
 - Return DTOs, not raw Prisma models"
 ```

2. **Share code examples:**
 ```bash
 claude --agent backend-developer "Create order service similar to:
 \`\`\`typescript
 // Example from user service
 export class UserService {
   constructor(private repo: UserRepository) {}
   async findById(id: string): Promise<UserDTO> { ... }
 }
 \`\`\`"
 ```

3. **Reference existing files:**
 ```bash
 claude --agent frontend-developer "Create ProductCard component following the pattern in src/components/UserCard.tsx"
 ```

### Agent Produces Outdated Code

**Problem:** Agent uses old libraries or deprecated patterns

**Solutions:**

1. **Specify versions:**
 ```bash
 claude --agent frontend-developer "Create React component using:
 - React 18 with hooks (no class components)
 - TypeScript 5
 - Functional components with arrow functions"
 ```

2. **Mention modern patterns:**
 ```bash
 claude --agent backend-developer "Use async/await, not callbacks or promises.then()"
 ```

3. **Request specific libraries:**
 ```bash
 claude --agent test-generator "Create tests using:
 - Jest 29
 - Testing Library (not Enzyme)
 - Modern matchers like toBeInTheDocument()"
 ```

### Agent Ignores Requirements

**Problem:** Agent output missing critical requirements

**Solutions:**

1. **Use bullet points for requirements:**
 ```bash
 claude --agent backend-developer "Create authentication API with:
 - JWT tokens with refresh
 - Password hashing with bcrypt
 - Rate limiting (10 attempts per minute)
 - Email verification required
 - Role-based access control"
 ```

2. **Prioritize requirements:**
 ```bash
 "CRITICAL: Must include input validation and SQL injection prevention
 IMPORTANT: Add rate limiting
 NICE TO HAVE: Logging"
 ```

3. **Iterate with feedback:**
 ```bash
 # First attempt
 claude --agent backend-developer "Create API"
   
 # Review output, then refine
 claude --agent backend-developer "Add the missing input validation to the API"
 ```

## IDE-Specific Issues

### Agent Not Available in VS Code

**Problem:** Can't invoke agent with `@agent-name`

**Solutions:**

1. **Check file location:**
 - Must be in workspace `.claude/agents/` directory
 - Not in global `~/.claude/agents/`

2. **Reload window:**
 - Cmd/Ctrl + Shift + P
 - "Developer: Reload Window"

3. **Check Claude Code extension:**
 - Ensure Claude Code IDE integration is enabled
 - Check extension version (update if needed)

4. **Verify workspace:**
 - Agent files only work in open workspace
 - Open folder containing `.claude/agents/`

### Agent Sees Wrong Files

**Problem:** Agent references files not in your project

**Solutions:**

1. **Be explicit with paths:**
 ```
 @backend-developer Update the user service in src/services/user.service.ts
 ```

2. **Select code first:**
 - Highlight relevant code in editor
 - Then invoke agent
 - Agent will see selected context

3. **Use workspace-relative paths:**
 ```
 @frontend-developer Create component in src/components/NewComponent.tsx
 ```

## CLI-Specific Issues

### Can't Find Files in Current Directory

**Problem:** Agent says it can't see files that exist

**Solutions:**

1. **Use absolute or relative paths:**
 ```bash
 # Absolute
 claude --agent python-expert "Review /home/user/project/src/main.py"
   
 # Relative to current directory
 claude --agent python-expert "Review ./src/main.py"
 ```

2. **Check current directory:**
 ```bash
 pwd  # Verify you're in the right place
 ls   # Verify files exist
 ```

3. **Provide file contents explicitly:**
 ```bash
 claude --agent code-reviewer "Review this code:
 \`\`\`python
 $(cat src/main.py)
 \`\`\`"
 ```

### Output Goes to Terminal, Need in File

**Problem:** Agent output prints to terminal but you want it in a file

**Solutions:**

```bash
# Redirect to file
claude --agent backend-developer "Create service" > src/service.ts

# Append to existing file
claude --agent test-generator "Add tests" >> tests/service.test.ts

# Both stdout and file (tee)
claude --agent doc-generator "Create README" | tee README.md

# Save and view with pager
claude --agent orchestrator "Complex task" | tee output.md | less
```

## Multi-Agent / Orchestration Issues

### Agents Produce Inconsistent Code

**Problem:** Different agents use different styles or patterns

**Solutions:**

1. **Have Orchestrator set standards:**
 ```bash
 claude --agent orchestrator "Build feature X. 
 Standards:
 - TypeScript strict mode
 - ESLint Airbnb config
 - Prettier formatting
 - Jest for testing
 Ensure all agents follow these standards."
 ```

2. **Provide style guide:**
 ```bash
 "Follow our style guide at CONTRIBUTING.md:
 - No default exports
 - Named exports only
 - Arrow functions for components"
 ```

3. **Use Code Reviewer as final gate:**
 ```bash
 claude --agent orchestrator "Build feature"
 # Then
 claude --agent code-reviewer "Ensure consistency with project standards in docs/STYLE_GUIDE.md"
 ```

### Integration Issues Between Agents

**Problem:** Frontend code doesn't work with Backend code

**Solutions:**

1. **Define contracts upfront:**
 ```bash
 claude --agent api-designer "Create OpenAPI spec for user management"
   
 # Then use the spec for both
 claude --agent backend-developer "Implement API matching spec.yaml"
 claude --agent frontend-developer "Create client for API in spec.yaml"
 ```

2. **Use Orchestrator for coordination:**
 ```bash
 claude --agent orchestrator "Build full-stack feature ensuring frontend and backend integrate properly"
 ```

3. **Explicit handoff:**
 ```bash
 # Save backend output
 claude --agent backend-developer "Create API" > api-spec.txt
   
 # Use it for frontend
 claude --agent frontend-developer "Create client for this API: $(cat api-spec.txt)"
 ```

## Performance Issues

### Agent Takes Too Long

**Problem:** Agent running for minutes without completing

**Solutions:**

1. **Break down the task:**
 ```bash
 # Too big
 claude --agent orchestrator "Build entire e-commerce platform"
   
 # Better - phased approach
 claude --agent orchestrator "Build product catalog feature"
 # Wait for completion, then
 claude --agent orchestrator "Build shopping cart feature"
 ```

2. **Simplify prompt:**
 ```bash
 # Too detailed
 claude --agent backend-developer "Create service with A, B, C, D, E, F, G, H, I, J features..."
   
 # Start with core
 claude --agent backend-developer "Create service with core features A, B, C"
 ```

3. **Check system resources:**
 - Close other heavy applications
 - Check internet speed

### Agent Repeats or Loops

**Problem:** Agent seems stuck in a loop or repeating

**Solutions:**

1. **Cancel and restart:**
 ```bash
 # Press Ctrl+C to cancel
 # Rephrase and try again
 ```

2. **More specific instructions:**
 ```bash
 # Vague
 claude --agent debug-detective "Fix this bug"
   
 # Specific
 claude --agent debug-detective "Analyze this stack trace and suggest fix: [paste trace]"
 ```

## Getting Help

### When Nothing Works

1. **Check Claude Code status:**
 ```bash
 claude --version
 ```

2. **Update Claude Code CLI:**
 ```bash
 claude update
 ```

3. **Check Claude Code status page:**
 - Visit https://www.githubstatus.com/
 - Look for Claude Code service issues

4. **Try with a different agent:**
 ```bash
 # If orchestrator fails, try simpler agent
 claude --agent python-expert "Simple task"
 ```

5. **Collect diagnostics:**
 ```bash
 gh version
 gh extension list
 ls -la ~/.claude/agents/
 open Claude Code and run /agents
 ```

### Reporting Issues

When reporting issues with an agent:

1. **Include:**
 - Exact command used
 - Agent name and file
 - Error message (full text)
 - Platform (CLI/VS Code, OS)
 - Claude Code version

2. **Example report:**
 ```
 Platform: CLI on macOS 13.1
 Claude Code version: claude-code 0.5.3-beta
 Agent: orchestrator.md
 Command: claude --agent orchestrator "Build API"
 Error: [full error message]
 Expected: Agent should coordinate backend developer
 Actual: Times out after 2 minutes
 ```

3. **Where to report:**
 - This repository: [GitHub Issues](../../issues)
 - Claude Code CLI: `Claude Code feedback`
 - VS Code: Help  Report Issue

## Quick Reference: Common Fixes

| Problem | Quick Fix |
|---------|-----------|
| Agent not found | Check file in `~/.claude/agents/` and filename ends with `.md` |
| Hangs/timeout | Simplify prompt, check internet |
| Wrong context | Be explicit with file paths |
| Bad output | Provide more context and examples |
| Rate limited | Wait 5-10 minutes, retry |
| Can't see files (CLI) | Use absolute/relative paths |
| Can't see files (IDE) | Select code or use full paths |
| Inconsistent code | Set standards upfront |
| Too slow | Break into smaller tasks |

## Still Stuck?

- **[Getting Started](./getting-started.md)** - Verify basic setup
- **[Best Practices](./best-practices.md)** - Learn optimal usage
- **[Agent Guide](./agent-guide.md)** - Understand agent capabilities
- **[GitHub Discussions](../../discussions)** - Ask the community

---

**Most issues are resolved by:**
1. Being more specific in prompts
2. Providing better context
3. Breaking tasks into smaller pieces
