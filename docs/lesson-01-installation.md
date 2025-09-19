# Lesson 1: Postman Installation and Setup

## Learning Objectives
- Install Postman on macOS Intel
- Understand the Postman interface components
- Create and configure your first workspace
- Set up basic environment for API testing

## Prerequisites
- macOS Intel machine
- Administrator access for software installation
- Basic familiarity with macOS applications

## Step 1: Install Postman on macOS Intel

### Option 1: Using Homebrew (Recommended)

**Install Homebrew first (if not already installed):**
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Install Postman:**
```bash
brew install --cask postman
```

### Option 2: Direct Download

1. Visit [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
2. Click "Download" for macOS
3. Open the downloaded `.dmg` file
4. Drag Postman to Applications folder
5. Launch Postman from Applications

## Step 2: First-Time Setup

### Account Creation
1. **Launch Postman** from Applications folder
2. **Create account** or **Sign in** when prompted
3. **Skip team setup** for individual learning
4. **Choose "Skip" for Postman Agent** setup (for now)

### Interface Overview

When you first open Postman, you'll see these key components:

**1. Header Bar**
- **Workspaces dropdown**: Switch between different project environments
- **New button**: Create new requests, collections, environments
- **Import button**: Import collections from files or URLs
- **Runner button**: Execute collection runs

**2. Sidebar (Left Panel)**
- **Collections**: Organized groups of API requests
- **APIs**: API documentation and schema management
- **Environments**: Variable sets for different contexts
- **Mock Servers**: Simulate API responses
- **Monitors**: Scheduled collection runs

**3. Main Work Area**
- **Request tabs**: Individual API requests
- **Request builder**: Configure HTTP methods, URLs, headers, body
- **Response panel**: View API responses, headers, cookies

**4. Bottom Panel**
- **Console**: View request/response logs
- **Test Results**: See test execution results

## Step 3: Create Your First Workspace

### What is a Workspace?
A **workspace** is your project environment that contains:
- Related collections
- Environment variables
- Team collaborations
- Shared resources

### Create Workspace Steps:

1. **Click "Workspaces"** in the header
2. **Select "Create Workspace"**
3. **Configure workspace:**
   - **Name**: "API Testing Learning"
   - **Summary**: "Learning Postman and Newman for database testing"
   - **Visibility**: Personal (for individual learning)
4. **Click "Create"**

## Step 4: Configure Basic Settings

### Essential Settings to Configure:

1. **Open Settings**: Postman → Preferences (or Cmd+,)

2. **General Tab Settings:**
   - **Theme**: Choose Light/Dark (personal preference)
   - **Request timeout**: 0 (no timeout for learning)
   - **Send anonymous usage data**: Disable for privacy

3. **Data Tab Settings:**
   - **History**: Keep enabled to track your requests
   - **Sync**: Enable if you want to access across devices

4. **Certificates Tab:**
   - Leave default for learning (no SSL certificates needed)

5. **Update Tab:**
   - **Auto-update**: Enable for latest features

## Step 5: Verify Installation

### Test Basic Functionality:

1. **Create a simple request:**
   - Click **"New"** → **"HTTP Request"**
   - Set **Method**: GET
   - Set **URL**: `https://httpbin.org/get`
   - Click **"Send"**

2. **Expected result:**
   - Status: **200 OK**
   - Response body with JSON data
   - Response time displayed

### Interface Familiarization Exercise:

**Explore these areas:**
1. **Request Method dropdown**: See GET, POST, PUT, DELETE options
2. **URL bar**: Where you enter API endpoints
3. **Params tab**: Query parameters section
4. **Headers tab**: HTTP headers configuration
5. **Body tab**: Request payload for POST/PUT requests
6. **Scripts tab**: Pre-request and test scripts
7. **Response section**: Status, headers, body, cookies

## Step 6: Understanding Key Concepts

### Collections
- **Purpose**: Group related API requests
- **Benefits**: Organization, sharing, automation
- **Example**: "User Management APIs", "Authentication APIs"

### Environments
- **Purpose**: Store variables for different contexts
- **Benefits**: Switch between dev/staging/prod easily
- **Example**: `{{baseUrl}}` variable with different values

### Variables
- **Collection variables**: Shared within a collection
- **Environment variables**: Specific to an environment
- **Global variables**: Available everywhere
- **Local variables**: Within a single request

## Troubleshooting Common Issues

### Issue 1: Postman won't start
**Solution:**
```bash
# Force quit and restart
pkill -f Postman
open -a Postman
```

### Issue 2: Permission denied during installation
**Solution:**
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) /usr/local/Homebrew
brew install --cask postman
```

### Issue 3: App is damaged error
**Solution:**
```bash
# Remove quarantine attribute
sudo xattr -rd com.apple.quarantine /Applications/Postman.app
```

### Issue 4: Can't create workspace
**Solution:**
- Ensure you're signed in to your Postman account
- Check internet connection
- Try refreshing the application

## Next Steps

Now that Postman is installed and configured:

1. **✅ Postman is installed and running**
2. **✅ Workspace created and configured**
3. **✅ Interface familiarized**
4. **✅ Basic request tested**

**Ready for Lesson 2**: Understanding RESTful APIs and the ReqRes testing service.

## Key Takeaways

- **Postman** is your primary tool for API testing
- **Workspaces** organize your testing projects
- **Collections** group related API requests
- **Environments** manage variables for different contexts
- The **interface** has distinct areas for requests, responses, and organization

## Practice Exercise

Before moving to Lesson 2, practice these tasks:

1. **Create a second workspace** called "Practice Testing"
2. **Send a request** to `https://jsonplaceholder.typicode.com/posts/1`
3. **Examine the response** structure and headers
4. **Save the request** in a new collection called "Practice Requests"

---

**Continue to [Lesson 2: Understanding RESTful APIs](lesson-02-rest-apis.md)**