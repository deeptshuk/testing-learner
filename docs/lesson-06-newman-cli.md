# Lesson 6: Newman CLI Setup and Configuration

## Learning Objectives
- Understand Newman CLI and its role in API test automation
- Install Newman and HTML reporters on macOS Intel
- Master Newman command structure and options
- Run Postman collections from command line
- Configure environments and data files for Newman
- Troubleshoot common Newman installation and execution issues

## Prerequisites
- Completed Lessons 0-5
- Postman collections created and organized
- Node.js understanding from prerequisites
- Basic command line familiarity
- Exported Postman collection JSON file

## What is Newman CLI?

### Newman Definition
**Newman** is Postman's official command-line collection runner that allows you to:
- **Run** Postman collections without the GUI
- **Automate** API testing in CI/CD pipelines
- **Generate** detailed reports (HTML, JSON, JUnit)
- **Schedule** automated test runs
- **Integrate** with build systems and deployment workflows

### Newman vs Postman GUI

| Feature | Postman GUI | Newman CLI |
|---------|-------------|------------|
| **Interface** | Visual, user-friendly | Command-line, text-based |
| **Automation** | Manual execution | Fully automated |
| **CI/CD Integration** | Not suitable | Perfect fit |
| **Reporting** | Basic test results | Multiple report formats |
| **Scheduling** | Manual | Cron jobs, schedulers |
| **Team Usage** | Individual testing | Automated team workflows |
| **Resource Usage** | Heavy (GUI) | Lightweight (headless) |

### When to Use Newman

**Perfect for:**
- ✅ Continuous Integration pipelines
- ✅ Automated regression testing
- ✅ Performance monitoring
- ✅ Scheduled health checks
- ✅ Server environments without GUI
- ✅ Batch processing of test suites

**Not ideal for:**
- ❌ Interactive test development
- ❌ Debugging individual requests
- ❌ Visual response analysis
- ❌ Initial collection creation

## Step 1: Prerequisites Verification

### Check Node.js Installation

Newman requires Node.js v16 or later:

```bash
# Check Node.js version
node --version
# Expected: v16.x.x or higher

# Check npm version
npm --version
# Expected: 8.x.x or higher
```

### Install Node.js (if needed)

If Node.js is not installed or version is too old:

```bash
# Install using Homebrew (recommended)
brew install node

# Verify installation
node --version
npm --version
```

### Alternative Node.js Installation

**Using Node Version Manager (nvm):**
```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Restart terminal or source profile
source ~/.bash_profile

# Install latest Node.js LTS
nvm install --lts
nvm use --lts
```

## Step 2: Install Newman CLI

### Global Newman Installation

```bash
# Install Newman globally
npm install -g newman

# Verify installation
newman --version
# Expected: 6.x.x or similar
```

### Verify Newman Installation

```bash
# Check Newman help
newman --help

# Expected output should include:
# Usage: newman run <collection-file-source> [options]
```

### Installation Troubleshooting

**Issue: Permission Denied**
```bash
# Fix npm permissions
sudo chown -R $(whoami) ~/.npm
npm install -g newman
```

**Issue: Command Not Found**
```bash
# Check npm global path
npm config get prefix

# Add to PATH in ~/.bash_profile or ~/.zshrc
export PATH=$PATH:$(npm config get prefix)/bin
```

## Step 3: Install HTML Reporters

### Basic HTML Reporter

```bash
# Install basic HTML reporter
npm install -g newman-reporter-html

# Verify installation
npm list -g newman-reporter-html
```

### Enhanced HTML Reporter (Recommended)

```bash
# Install enhanced HTML reporter
npm install -g newman-reporter-htmlextra

# Verify installation
npm list -g newman-reporter-htmlextra
```

### Other Useful Reporters

```bash
# JUnit XML reporter for CI/CD
npm install -g newman-reporter-junitfull

# CSV reporter for data analysis
npm install -g newman-reporter-csv
```

### Verify All Reporters

```bash
# List all globally installed packages
npm list -g --depth=0 | grep newman

# Expected output:
# ├── newman@6.x.x
# ├── newman-reporter-html@1.x.x
# ├── newman-reporter-htmlextra@1.x.x
```

## Step 4: Basic Newman Commands

### Command Structure

```bash
newman run <collection> [options]
```

### Essential Options

| Option | Short | Description | Example |
|--------|-------|-------------|---------|
| `--environment` | `-e` | Environment file | `-e prod.json` |
| `--reporters` | `-r` | Report formats | `-r cli,html` |
| `--iteration-count` | `-n` | Number of iterations | `-n 3` |
| `--delay-request` | | Delay between requests (ms) | `--delay-request 1000` |
| `--timeout-request` | | Request timeout (ms) | `--timeout-request 10000` |
| `--help` | `-h` | Show help | `newman --help` |

### Your First Newman Run

Create a simple test collection file:

```bash
# Create test directory
mkdir ~/newman-test
cd ~/newman-test

# Create simple collection file
cat > simple-collection.json << 'EOF'
{
  "info": {
    "name": "Simple API Test",
    "description": "Basic Newman test"
  },
  "item": [
    {
      "name": "Get Users",
      "request": {
        "method": "GET",
        "header": [],
        "url": {
          "raw": "https://reqres.in/api/users",
          "protocol": "https",
          "host": ["reqres", "in"],
          "path": ["api", "users"]
        }
      },
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [
              "pm.test('Status code is 200', function () {",
              "    pm.response.to.have.status(200);",
              "});",
              "",
              "pm.test('Response has data array', function () {",
              "    const json = pm.response.json();",
              "    pm.expect(json).to.have.property('data');",
              "    pm.expect(json.data).to.be.an('array');",
              "});"
            ],
            "type": "text/javascript"
          }
        }
      ]
    }
  ]
}
EOF
```

### Run the Test

```bash
# Basic run
newman run simple-collection.json

# Expected output:
# newman
#
# Simple API Test
#
# → Get Users
#   GET https://reqres.in/api/users [200 OK, 1.89KB, 156ms]
#   ✓  Status code is 200
#   ✓  Response has data array
#
# ┌─────────────────────────┬──────────────────┬──────────────────┐
# │                         │         executed │           failed │
# ├─────────────────────────┼──────────────────┼──────────────────┤
# │              iterations │                1 │                0 │
# ├─────────────────────────┼──────────────────┼──────────────────┤
# │                requests │                1 │                0 │
# ├─────────────────────────┼──────────────────┼──────────────────┤
# │            test-scripts │                1 │                0 │
# ├─────────────────────────┼──────────────────┼──────────────────┤
# │      prerequest-scripts │                0 │                0 │
# ├─────────────────────────┼──────────────────┼──────────────────┤
# │              assertions │                2 │                0 │
# └─────────────────────────┴──────────────────┴──────────────────┘
```

## Step 5: Using Environments with Newman

### Create Environment File

```bash
# Create development environment
cat > dev-environment.json << 'EOF'
{
  "name": "Development Environment",
  "values": [
    {
      "key": "baseUrl",
      "value": "https://reqres.in/api",
      "enabled": true
    },
    {
      "key": "timeout",
      "value": "5000",
      "enabled": true
    },
    {
      "key": "environment",
      "value": "development",
      "enabled": true
    }
  ]
}
EOF
```

### Run with Environment

```bash
# Run collection with environment
newman run simple-collection.json -e dev-environment.json

# Verbose output to see environment variables
newman run simple-collection.json -e dev-environment.json --verbose
```

### Multiple Environments

Create production environment:

```bash
# Create production environment
cat > prod-environment.json << 'EOF'
{
  "name": "Production Environment",
  "values": [
    {
      "key": "baseUrl",
      "value": "https://reqres.in/api",
      "enabled": true
    },
    {
      "key": "timeout",
      "value": "10000",
      "enabled": true
    },
    {
      "key": "environment",
      "value": "production",
      "enabled": true
    }
  ]
}
EOF
```

## Step 6: Report Generation

### CLI Reporter (Default)

```bash
# Basic CLI output
newman run simple-collection.json -r cli
```

### HTML Reporter

```bash
# Generate basic HTML report
newman run simple-collection.json \
  -r html \
  --reporter-html-export basic-report.html

# Open report (macOS)
open basic-report.html
```

### Enhanced HTML Reporter

```bash
# Generate enhanced HTML report
newman run simple-collection.json \
  -r htmlextra \
  --reporter-htmlextra-export enhanced-report.html \
  --reporter-htmlextra-title "API Test Results"

# Open enhanced report
open enhanced-report.html
```

### Multiple Reports Simultaneously

```bash
# Generate multiple report formats
newman run simple-collection.json \
  -r cli,json,htmlextra \
  --reporter-json-export results.json \
  --reporter-htmlextra-export detailed-report.html \
  --reporter-htmlextra-title "Complete Test Results"
```

### JSON Reporter for Automation

```bash
# JSON output for parsing
newman run simple-collection.json \
  -r json \
  --reporter-json-export results.json

# Parse results with jq (if installed)
cat results.json | jq '.run.stats'
```

## Step 7: Advanced Newman Options

### Performance and Timing

```bash
# Add delays for stability
newman run simple-collection.json \
  --delay-request 1000 \
  --timeout-request 10000 \
  --timeout-script 5000

# Multiple iterations
newman run simple-collection.json \
  -n 3 \
  --delay-request 500
```

### Data-Driven Testing

Create test data file:

```bash
# Create CSV data file
cat > test-data.csv << 'EOF'
userId,expectedName
1,George
2,Janet
3,Emma
EOF
```

Run with data:

```bash
# Data-driven testing
newman run simple-collection.json \
  -d test-data.csv \
  -r htmlextra \
  --reporter-htmlextra-export data-driven-results.html
```

### Exit Codes and Error Handling

```bash
# Run and check exit code
newman run simple-collection.json
echo "Exit code: $?"

# 0 = Success (all tests passed)
# 1 = Failure (tests failed or errors occurred)
```

### Suppressing Specific Output

```bash
# Suppress CLI output
newman run simple-collection.json --silent

# Suppress colors
newman run simple-collection.json --no-color

# Only show failures
newman run simple-collection.json --reporter-cli-no-summary
```

## Step 8: Working with Real Collections

### Export from Postman

1. **In Postman**, right-click your collection
2. **Select "Export"**
3. **Choose "Collection v2.1"**
4. **Save as**: `my-collection.json`

### Run Exported Collection

```bash
# Basic run
newman run my-collection.json

# With environment and reports
newman run my-collection.json \
  -e dev-environment.json \
  -r htmlextra \
  --reporter-htmlextra-export test-results.html
```

### Collection with Authentication

If your collection uses authentication:

```bash
# Environment with auth token
cat > auth-environment.json << 'EOF'
{
  "name": "Authenticated Environment",
  "values": [
    {
      "key": "baseUrl",
      "value": "https://api.example.com",
      "enabled": true
    },
    {
      "key": "authToken",
      "value": "your-secret-token",
      "enabled": true
    }
  ]
}
EOF

# Run with authentication
newman run my-collection.json -e auth-environment.json
```

## Step 9: Newman Configuration Files

### Newman Configuration File

Create `.newmanrc.json` for default settings:

```bash
cat > .newmanrc.json << 'EOF'
{
  "collection": "my-collection.json",
  "environment": "dev-environment.json",
  "reporters": ["cli", "htmlextra"],
  "reporter": {
    "htmlextra": {
      "export": "./reports/newman-report.html",
      "title": "API Test Results",
      "logs": true
    }
  },
  "delayRequest": 500,
  "timeoutRequest": 10000,
  "iterationCount": 1
}
EOF
```

Use configuration file:

```bash
# Run with config file
newman run --config .newmanrc.json
```

## Step 10: CI/CD Integration Patterns

### Basic CI/CD Script

```bash
#!/bin/bash
# ci-test-script.sh

set -e  # Exit on any error

echo "🚀 Starting API Tests..."

# Run Newman with appropriate settings for CI
newman run collections/api-tests.json \
  -e environments/ci-environment.json \
  -r cli,json,junit \
  --reporter-json-export reports/newman-results.json \
  --reporter-junit-export reports/newman-junit.xml \
  --timeout-request 30000 \
  --delay-request 100

echo "✅ API Tests Completed Successfully"
```

### GitHub Actions Example

```yaml
# .github/workflows/api-tests.yml
name: API Tests
on: [push, pull_request]

jobs:
  api-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'

      - name: Install Newman
        run: |
          npm install -g newman
          npm install -g newman-reporter-htmlextra

      - name: Run API Tests
        run: |
          newman run collections/api-tests.json \
            -e environments/ci-environment.json \
            -r cli,htmlextra \
            --reporter-htmlextra-export reports/api-test-results.html

      - name: Upload Test Results
        uses: actions/upload-artifact@v2
        if: always()
        with:
          name: api-test-results
          path: reports/
```

## Step 11: Troubleshooting Common Issues

### Issue 1: Newman Command Not Found

```bash
# Symptoms
newman: command not found

# Solutions
# 1. Check installation
npm list -g newman

# 2. Reinstall Newman
npm uninstall -g newman
npm install -g newman

# 3. Check PATH
echo $PATH
which newman
```

### Issue 2: Permission Errors

```bash
# Symptoms
EACCES: permission denied

# Solutions
# 1. Fix npm permissions
sudo chown -R $(whoami) ~/.npm

# 2. Use different npm prefix
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
```

### Issue 3: Collection File Not Found

```bash
# Symptoms
Error: unable to read collection file

# Solutions
# 1. Check file path
ls -la my-collection.json

# 2. Use absolute path
newman run /full/path/to/collection.json

# 3. Verify JSON format
cat my-collection.json | jq .
```

### Issue 4: Environment Variables Not Working

```bash
# Symptoms
Variables not resolving (showing {{variable}})

# Solutions
# 1. Check environment file format
cat environment.json | jq .

# 2. Verify variable names match
grep -r "variableName" .

# 3. Use correct environment option
newman run collection.json -e environment.json
```

### Issue 5: Tests Failing in Newman but Passing in Postman

```bash
# Common causes:
# 1. Different environments
# 2. Missing dependencies
# 3. Timing issues

# Solutions
# 1. Use same environment
# 2. Add delays
newman run collection.json --delay-request 1000

# 3. Increase timeouts
newman run collection.json --timeout-request 30000
```

## Step 12: Performance Optimization

### Optimizing Newman Runs

```bash
# Reduce output for faster runs
newman run collection.json --silent

# Parallel execution (separate processes)
newman run collection1.json &
newman run collection2.json &
wait

# Efficient reporting
newman run collection.json \
  -r json \
  --reporter-json-export results.json
```

### Memory Management

```bash
# For large collections, increase Node.js memory
node --max-old-space-size=4096 $(which newman) run large-collection.json

# Monitor memory usage
/usr/bin/time -v newman run collection.json
```

## Summary and Next Steps

In this lesson, you've mastered:

1. **✅ Newman CLI installation and setup**
2. **✅ Basic and advanced command options**
3. **✅ Environment configuration**
4. **✅ Multiple report format generation**
5. **✅ CI/CD integration patterns**
6. **✅ Troubleshooting common issues**

### Key Achievements:
- **Command-line automation** capabilities
- **Environment-based testing** setup
- **Report generation** for stakeholders
- **CI/CD pipeline** readiness
- **Troubleshooting skills** for production issues

**Ready for Lesson 7**: Advanced HTML reporting, automated scheduling, and complete test automation workflows.

---

**Continue to [Lesson 7: HTML Reports and Automation](lesson-07-html-reports.md)**