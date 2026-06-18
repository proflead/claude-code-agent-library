# Claude Code Agent Library

A comprehensive collection of **36 production-ready Claude Code subagents** for developers, teams, and organizations. Download, customize, and deploy powerful AI agents to supercharge your development workflow.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Agents](https://img.shields.io/badge/Agents-36-green.svg)](#agent-categories)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## Quick Start

### For CLI Users

1. **Choose an agent** from the [Agent Categories](#agent-categories) below
2. **Download the agent file** (`.md`) to your local machine
3. **Copy to your agents directory**:
 ```bash
 cp path/to/agent.md ~/.claude/agents/
 ```
4. **Use the agent**:
 ```bash
 claude --agent agent-name "Your task here"
 ```

### For IDE Users (VS Code)

1. **Choose an agent** from the [Agent Categories](#agent-categories) below
2. **Download the agent file** (`.md`)
3. **Add to your workspace**: `.claude/agents/`
4. **Invoke in chat**: `@agent-name your task here`

---

## Agent Categories

### Orchestration (3 agents)

Coordinate multiple agents and manage complex workflows.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Orchestrator**](.claude/agents/orchestration/orchestrator.md) | Multi-agent coordinator and task delegator | Complex projects requiring multiple specialized agents |
| [**Workflow Manager**](.claude/agents/orchestration/workflow-manager.md) | Sequential and parallel task execution | CI/CD pipelines, automated workflows |
| [**Project Manager**](.claude/agents/orchestration/project-manager.md) | Sprint planning and stakeholder coordination | Agile project management, roadmap planning |

### Full-Stack Development (6 agents)

End-to-end development from frontend to backend to mobile.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Frontend Developer**](.claude/agents/fullstack/frontend-developer.md) | React/Vue/Angular expert, component architecture | Building modern web UIs, state management |
| [**Backend Developer**](.claude/agents/fullstack/backend-developer.md) | API design, authentication, database integration | RESTful APIs, GraphQL, server-side logic |
| [**Full-Stack Expert**](.claude/agents/fullstack/fullstack-expert.md) | End-to-end feature implementation | Full-stack features, monorepo projects |
| [**Mobile Developer**](.claude/agents/fullstack/mobile-developer.md) | React Native, Flutter, native iOS/Android | Cross-platform mobile apps |
| [**API Designer**](.claude/agents/fullstack/api-designer.md) | RESTful principles, OpenAPI specs, versioning | API architecture, documentation |
| [**Database Architect**](.claude/agents/fullstack/database-architect.md) | Schema design, normalization, query optimization | Database modeling, performance tuning |

### Language Experts (6 agents)

Language-specific coding assistants with deep expertise.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Python Expert**](.claude/agents/coding/python-expert.md) | Type hints, pytest, best practices | Data science, backend services, automation |
| [**JavaScript Expert**](.claude/agents/coding/javascript-expert.md) | Modern ES6+, React, Node.js | Web development, frontend/backend JS |
| [**Rust Expert**](.claude/agents/coding/rust-expert.md) | Memory safety, borrowing, async/await | Systems programming, performance-critical code |
| [**Go Expert**](.claude/agents/coding/go-expert.md) | Concurrency patterns, error handling | Microservices, cloud infrastructure |
| [**Java Expert**](.claude/agents/coding/java-expert.md) | Spring Boot, Maven/Gradle, JUnit | Enterprise applications, Android apps |
| [**SQL Expert**](.claude/agents/coding/sql-expert.md) | Query optimization, database design, migrations | Database development, data analysis |

### Testing & Quality (5 agents)

Ensure code quality, security, and comprehensive test coverage.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**E2E Tester**](.claude/agents/testing/e2e-tester.md) | Playwright, Cypress, Selenium automation | End-to-end test automation, UI testing |
| [**A/B Test Ideas**](.claude/agents/testing/ab-test-ideas.md) | Hypothesis generation, experiment design | Product experiments, feature testing |
| [**Code Reviewer**](.claude/agents/testing/code-reviewer.md) | Pull request reviews, best practices | Code review automation, quality gates |
| [**Security Auditor**](.claude/agents/testing/security-auditor.md) | Vulnerability scanning, OWASP compliance | Security audits, penetration testing |
| [**Test Generator**](.claude/agents/testing/test-generator.md) | Unit tests, integration tests, coverage | Test creation, TDD/BDD workflows |

### Design & UI/UX (4 agents)

From design to code, build beautiful user interfaces.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**UI/UX Designer**](.claude/agents/design/uiux-designer.md) | User flows, wireframing, design systems | Product design, user research |
| [**Figma to HTML**](.claude/agents/design/figma-to-html.md) | Convert Figma designs to HTML/CSS/React | Design-to-code workflows |
| [**Responsive Design**](.claude/agents/design/responsive-design.md) | Mobile-first, accessibility, cross-browser | Responsive web development |
| [**Design System Builder**](.claude/agents/design/design-system.md) | Component libraries, design tokens | Building/maintaining design systems |

### Productivity (4 agents)

Plan, research, and document your projects effectively.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Enhanced Planner**](.claude/agents/productivity/enhanced-planner.md) | Multi-step planning with dependency tracking | Project planning, task breakdown |
| [**Research Agent**](.claude/agents/productivity/research-agent.md) | Web research, documentation synthesis | Technical research, competitive analysis |
| [**Task Breakdown**](.claude/agents/productivity/task-breakdown.md) | Epic decomposition, story estimation | Agile planning, sprint preparation |
| [**Doc Generator**](.claude/agents/productivity/doc-generator.md) | README, API docs, architecture diagrams | Documentation automation |

### DevOps (4 agents)

Infrastructure, containers, and CI/CD automation.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Docker Expert**](.claude/agents/devops/docker-expert.md) | Dockerfile optimization, multi-stage builds | Container development, optimization |
| [**Kubernetes Expert**](.claude/agents/devops/kubernetes-expert.md) | Manifests, Helm charts, troubleshooting | K8s deployment, cluster management |
| [**CI/CD Expert**](.claude/agents/devops/cicd-expert.md) | GitHub Actions, GitLab CI, Azure DevOps | Pipeline automation, deployment |
| [**Terraform Expert**](.claude/agents/devops/terraform-expert.md) | Infrastructure as code, state management | Cloud infrastructure, IaC |

### Debugging (3 agents)

Debug issues, optimize performance, and modernize legacy code.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Debug Detective**](.claude/agents/debugging/debug-detective.md) | Error analysis, stack trace interpretation | Debugging, root cause analysis |
| [**Performance Optimizer**](.claude/agents/debugging/performance-optimizer.md) | Profiling, bottleneck identification | Performance tuning, optimization |
| [**Legacy Modernizer**](.claude/agents/debugging/legacy-modernizer.md) | Migration strategies, tech debt reduction | Legacy code refactoring, upgrades |

### Integrations (1 agent)

Connect and automate third-party APIs and services.

| Agent | Description | Use Cases |
|-------|-------------|-----------|
| [**Buffer API Expert**](.claude/agents/integrations/buffer-api.md) | Social media scheduling and analytics via Buffer GraphQL API | Schedule posts, manage channels, retrieve metrics, build content automations |

---

## Usage Examples

### Single Agent Workflow

```bash
# Use the Python Expert to refactor a function
claude --agent python-expert "Refactor this function to use type hints and improve error handling"
```

### Multi-Agent Orchestration

```bash
# Use the Orchestrator to coordinate multiple agents
claude --agent orchestrator "Build a new user authentication feature with frontend, backend, and tests"
```

The Orchestrator will delegate tasks to:
1. **Backend Developer**  API endpoints and authentication logic
2. **Frontend Developer**  Login/signup UI components
3. **Security Auditor**  Security review
4. **Test Generator**  Unit and integration tests

### Design-to-Code Workflow

```bash
# Convert Figma design to React components
claude --agent figma-to-html "Convert this Figma design to React with TypeScript"
```

---

## Documentation

- **[Getting Started Guide](docs/getting-started.md)** - Installation and first agent usage
- **[Agent Guide](docs/agent-guide.md)** - Detailed usage for each agent
- **[CLI vs IDE](docs/cli-vs-ide.md)** - Platform-specific best practices
- **[Orchestration Patterns](docs/orchestration-patterns.md)** - Multi-agent coordination
- **[Best Practices](docs/best-practices.md)** - Advanced usage patterns
- **[Troubleshooting](docs/troubleshooting.md)** - Common issues and solutions

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to create a new agent
- Submission guidelines
- Quality standards
- PR review process

---

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

---

## Showcase

**Built something awesome with these agents?** Share your story!
- Open a [GitHub Discussion](../../discussions)
- Tweet with `#ClaudeCodeAgents`
- Submit a PR to add your project to our showcase

---

## Acknowledgments

Inspired by [anthropics/claude-code](https://github.com/anthropics/claude-code) and the amazing Claude Code community.

---

<p align="center">Made with  by developers, for developers</p>
