# Odino - Semantic File Indexer Tool

## Overview
Odino is a semantic file indexing and retrieval tool that allows natural language queries to find files based on their content and meaning, not just keyword matching.

## Basic Commands

### Indexing
- `odino index /path` - Index a specific directory path
- `odino index .` - Index current directory and all subdirectories
- `odino index /path --force` - Force re-indexing (ignores existing index)

### Searching
- `odino -q "query"` - Returns the first 2 results (default)
- `odino -q "query" -r 10` - Returns the first 10 results (1-100 max)

### Version
- `odino --version` or `odino -v` - Show version and exit

## Advanced Search Options

### Result Limiting
- `--results N` or `-r N` - Return N results (min: 1, max: 100)
- Default is 2 results if not specified

### Path Targeting
- `--path /directory` or `-p /directory` - Search only in specific directory
- Useful for narrowing searches to a specific part of your codebase

### File Filtering
- `--include "pattern"` - Include only files matching glob pattern
  - Example: `--include "*.py"` (only Python files)
  - Example: `--include "src/**/*.ts"` (only TypeScript in src/)
- `--exclude "pattern"` - Exclude files matching glob pattern
  - Example: `--exclude "*.test.js"` (skip test files)
  - Example: `--exclude "migrations/*"` (skip migration files)

### Combined Examples
```bash
# Find authentication code only in Python files
odino -q "authentication logic" --include "*.py" -r 5

# Search for config files, excluding tests
odino -q "database configuration" --exclude "*.test.*" -r 10

# Search only in the backend directory
odino -q "API endpoints" --path ./backend -r 8

# Find error handling, only in TypeScript, skip node_modules
odino -q "error handling utilities" --include "*.ts" --exclude "node_modules/**" -r 10
```

## Key Features

### Semantic Search
Odino uses semantic indexing to understand the *meaning* of your query, not just exact keyword matches. This means you can:
- Ask questions in natural language
- Find files by describing what they contain conceptually
- Discover relevant files even if they don't contain your exact search terms

**Examples:**
- "authentication logic" might find auth handlers, login functions, etc.
- "database connection setup" could find config files, connection pooling code
- "error handling utilities" would surface error-related helper functions

### Ignore Rules
Odino respects:
- `.gitignore` - Standard Git ignore patterns
- `.odinoignore` - Custom ignore patterns specific to Odino

This ensures you don't index irrelevant files like dependencies, build artifacts, or temporary files.

## When to Reindex
**Always reindex when:**
- Working in a new directory for the first time
- After making major code changes or refactoring
- After adding/removing significant files
- When search results seem stale or incomplete

Use `odino index . --force` to force a fresh index.

## Best Practices

### Use Odino + grep Together
Odino and grep are complementary tools:

**Use Odino for:**
- Finding files by concept or purpose ("error handling", "API endpoints")
- Discovering relevant code when you don't know exact terms
- Broad exploratory searches across the codebase
- Understanding what exists in an unfamiliar codebase

**Use grep for:**
- Finding exact strings, function names, or variable names
- Pattern matching with regex
- Line-by-line code inspection
- Verifying Odino results or getting more context

**Example workflow:**
1. `odino -q "user authentication" -r 5` - Find auth-related files
2. `grep -r "validatePassword" auth/` - Find specific function in those files
3. `odino -q "password validation" --path auth/ -r 3` - Semantic search within auth directory

### Filtering Strategies
- Use `--include` to focus on specific file types when you know what you're looking for
- Use `--exclude` to skip irrelevant files (tests, generated code, etc.)
- Use `--path` to limit searches to specific modules or directories
- Combine filters for precise searches: `odino -q "query" --path ./src --include "*.ts" --exclude "*.spec.ts"`

### Query Tips
- **Be descriptive**: "configuration for database connections" > "config"
- **Use natural language**: Describe what the code *does* or *is for*
- **Think semantically**: Focus on purpose and meaning, not syntax
- **Adjust result count**: Start with more results (`-r 10`) if unsure, refine to fewer
- **Narrow scope**: Use `--path`, `--include`, `--exclude` for large codebases

### Remember
**Odino understands semantic meaning, not just keyword matching.** Describe what you want to find in natural language for best results.

When searching code, consider using Odino first to locate relevant files, then grep to drill into specific details within those files. Use filtering options to make searches more precise in large codebases.