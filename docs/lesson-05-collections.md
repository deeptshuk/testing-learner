# Lesson 5: Organizing APIs in Postman Collections

## Learning Objectives
- Understand the power and purpose of Postman Collections
- Create well-organized collection structures with folders
- Master collection and environment variables
- Learn collection-level scripts and configurations
- Export collections for sharing and automation
- Implement best practices for team collaboration

## Prerequisites
- Completed Lessons 0-4
- Several API requests created in Postman
- Understanding of test assertions
- Familiarity with different HTTP methods

## What is a Postman Collection?

### Collection Definition
A **Postman Collection** is a group of related API requests that can be:
- **Organized** into logical folders
- **Executed** together as a test suite
- **Shared** with team members
- **Automated** with Newman CLI
- **Documented** for API reference
- **Versioned** and managed over time

### Why Use Collections?

#### Without Collections (Chaotic)
```
❌ Individual requests scattered everywhere
❌ No organization or structure
❌ Hard to find specific tests
❌ Difficult to run related tests together
❌ No standardization across team
❌ Manual execution of each request
```

#### With Collections (Organized)
```
✅ Logical grouping of related requests
✅ Hierarchical folder structure
✅ Easy to locate and execute tests
✅ Batch execution of test suites
✅ Standardized approach across team
✅ Automated testing capabilities
```

## Step 1: Create Your First Collection

### Creating a New Collection

1. **In Postman sidebar**, click **"Collections"**
2. **Click "Create Collection"** button (or + icon)
3. **Configure collection details**:
   - **Name**: "ReqRes API Testing Suite"
   - **Description**: "Comprehensive API testing for ReqRes endpoints including CRUD operations, authentication, and error handling"
4. **Click "Create"**

### Collection Overview Tab

After creating, you'll see these tabs:
- **Overview**: Collection description and documentation
- **Authorization**: Authentication settings for all requests
- **Pre-request Script**: Code that runs before each request
- **Tests**: Code that runs after each request
- **Variables**: Collection-specific variables

## Step 2: Collection Structure Design

### Planning Your Collection Structure

Before adding requests, plan your organization:

```
ReqRes API Testing Suite/
├── 📁 01 - User Management
│   ├── GET All Users
│   ├── GET Single User (Valid)
│   ├── GET Single User (Not Found)
│   ├── POST Create User
│   ├── PUT Update User (Complete)
│   ├── PATCH Update User (Partial)
│   └── DELETE Remove User
├── 📁 02 - Authentication
│   ├── POST Register (Success)
│   ├── POST Register (Failure)
│   ├── POST Login (Success)
│   └── POST Login (Failure)
├── 📁 03 - Resource Management
│   ├── GET All Resources
│   ├── GET Single Resource
│   └── GET Resource Not Found
└── 📁 04 - Performance & Edge Cases
    ├── GET Delayed Response
    ├── GET Large Dataset
    └── GET Invalid Endpoint
```

### Folder Naming Best Practices

1. **Use numbering** for execution order: `01 - User Management`
2. **Be descriptive**: `Authentication` not `Auth`
3. **Group by functionality**: Related operations together
4. **Use consistent naming**: `GET All Users`, `GET Single User`

## Step 3: Create Folder Structure

### Creating Folders

1. **Right-click your collection** "ReqRes API Testing Suite"
2. **Select "Add Folder"**
3. **Create these folders in order**:

#### Folder 1: User Management
- **Name**: `01 - User Management`
- **Description**: `CRUD operations for user entities including creation, retrieval, updates, and deletion`

#### Folder 2: Authentication
- **Name**: `02 - Authentication`
- **Description**: `User registration and login flows with success and failure scenarios`

#### Folder 3: Resource Management
- **Name**: `03 - Resource Management`
- **Description**: `Operations on resource entities with various response scenarios`

#### Folder 4: Performance & Edge Cases
- **Name**: `04 - Performance & Edge Cases`
- **Description**: `Performance testing, error scenarios, and edge case validation`

## Step 4: Variables and Environments

### Collection Variables

Collection variables are shared across all requests in the collection.

1. **Click on your collection**
2. **Go to "Variables" tab**
3. **Add these variables**:

| Variable Name | Initial Value | Current Value | Description |
|---------------|---------------|---------------|-------------|
| `baseUrl` | `https://reqres.in/api` | `https://reqres.in/api` | Base API URL |
| `userId` | `2` | `2` | Default user ID for testing |
| `resourceId` | `2` | `2` | Default resource ID |
| `timestamp` | `` | `` | Dynamic timestamp (set by scripts) |

### Environment Variables

Environments allow you to switch between different contexts (dev, staging, prod).

#### Create Development Environment

1. **Click "Environments"** in sidebar
2. **Click "Create Environment"**
3. **Configure**:
   - **Name**: `Development`
   - **Variables**:

| Variable | Initial Value | Current Value |
|----------|---------------|---------------|
| `baseUrl` | `https://reqres.in/api` | `https://reqres.in/api` |
| `timeout` | `5000` | `5000` |
| `retries` | `3` | `3` |
| `environment` | `development` | `development` |

#### Create Production Environment

1. **Create another environment**:
   - **Name**: `Production`
   - **Variables**:

| Variable | Initial Value | Current Value |
|----------|---------------|---------------|
| `baseUrl` | `https://reqres.in/api` | `https://reqres.in/api` |
| `timeout` | `10000` | `10000` |
| `retries` | `1` | `1` |
| `environment` | `production` | `production` |

### Using Variables in Requests

Replace hardcoded URLs with variables:

**Before (hardcoded):**
```
https://reqres.in/api/users/2
```

**After (with variables):**
```
{{baseUrl}}/users/{{userId}}
```

## Step 5: Adding Requests to Collections

### Moving Existing Requests

If you have existing requests:

1. **Right-click the request**
2. **Select "Move"**
3. **Choose destination folder**
4. **Click "Move"**

### Creating New Requests in Folders

1. **Right-click desired folder**
2. **Select "Add Request"**
3. **Configure request details**

### User Management Folder Requests

#### GET All Users
```
Name: GET All Users
Method: GET
URL: {{baseUrl}}/users
Description: Retrieve paginated list of all users
```

**Tests to add:**
```javascript
const responseJson = pm.response.json();

pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response has pagination structure", function () {
    pm.expect(responseJson).to.have.property('page');
    pm.expect(responseJson).to.have.property('per_page');
    pm.expect(responseJson).to.have.property('total');
    pm.expect(responseJson).to.have.property('data');
});

pm.test("Data array contains users", function () {
    pm.expect(responseJson.data).to.be.an('array');
    pm.expect(responseJson.data.length).to.be.above(0);
});
```

#### POST Create User
```
Name: POST Create User
Method: POST
URL: {{baseUrl}}/users
Headers: Content-Type: application/json
Body (raw JSON):
{
    "name": "Test User {{timestamp}}",
    "job": "Database Tester"
}
```

**Pre-request Script:**
```javascript
// Generate unique timestamp for this request
pm.collectionVariables.set("timestamp", Date.now());
```

**Tests:**
```javascript
const responseJson = pm.response.json();

pm.test("User created successfully", function () {
    pm.response.to.have.status(201);
});

pm.test("Response contains user data", function () {
    pm.expect(responseJson).to.have.property('name');
    pm.expect(responseJson).to.have.property('job');
    pm.expect(responseJson).to.have.property('id');
    pm.expect(responseJson).to.have.property('createdAt');
});

// Store created user ID for subsequent requests
pm.collectionVariables.set("createdUserId", responseJson.id);
```

#### DELETE Remove User
```
Name: DELETE Remove User
Method: DELETE
URL: {{baseUrl}}/users/{{userId}}
```

**Tests:**
```javascript
pm.test("User deleted successfully", function () {
    pm.response.to.have.status(204);
});

pm.test("Response body is empty", function () {
    pm.expect(pm.response.text()).to.eql("");
});
```

## Step 6: Collection-Level Configuration

### Pre-request Scripts (Collection Level)

Collection-level scripts run before every request:

1. **Click on collection**
2. **Go to "Pre-request Script" tab**
3. **Add this code**:

```javascript
// Global pre-request script for all requests in collection
console.log(`Starting request: ${pm.info.requestName}`);

// Set dynamic timestamp
pm.collectionVariables.set('timestamp', Date.now());

// Log current environment
console.log(`Environment: ${pm.environment.get('environment') || 'None'}`);

// Add request start time for performance tracking
pm.collectionVariables.set('requestStartTime', Date.now());
```

### Tests (Collection Level)

Collection-level tests run after every request:

1. **Go to "Tests" tab**
2. **Add this code**:

```javascript
// Global post-request tests for all requests in collection

// Performance test - response time
pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(2000);
});

// Security test - no server errors
pm.test("No server errors (5xx)", function () {
    pm.expect(pm.response.code).to.not.be.within(500, 599);
});

// Content type validation
pm.test("Content-Type header is present", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.exist;
});

// Log response summary
const startTime = pm.collectionVariables.get('requestStartTime');
const duration = Date.now() - startTime;
console.log(`Request completed: ${pm.info.requestName} | Status: ${pm.response.code} | Time: ${pm.response.responseTime}ms`);
```

### Authorization (Collection Level)

If your API requires authentication:

1. **Go to "Authorization" tab**
2. **Select auth type** (Bearer Token, Basic Auth, etc.)
3. **Configure credentials**

Example for Bearer Token:
```
Type: Bearer Token
Token: {{authToken}}
```

## Step 7: Request Organization Best Practices

### Naming Conventions

**Good naming:**
```
✅ GET All Users
✅ POST Create User
✅ PUT Update User (Complete)
✅ DELETE Remove User
✅ GET Single User (Valid)
✅ GET Single User (Not Found)
```

**Poor naming:**
```
❌ Users
❌ Create
❌ Update
❌ Delete
❌ Get User
❌ Test 1
```

### Request Descriptions

Add meaningful descriptions:

```markdown
## Purpose
Retrieve a paginated list of all users from the system.

## Expected Response
- Status: 200 OK
- Body: JSON with pagination info and user array

## Test Coverage
- Status code validation
- Response structure verification
- Data type validation
- Pagination logic testing
```

### Request Organization Tips

1. **Order by workflow**: Create → Read → Update → Delete
2. **Group similar operations**: All user operations together
3. **Separate happy/sad paths**: Valid requests vs error scenarios
4. **Use consistent patterns**: Same structure across folders

## Step 8: Running Collections

### Running Entire Collection

1. **Click on collection name**
2. **Click "Run collection" button**
3. **Configure run settings**:
   - **Environment**: Select Development/Production
   - **Iterations**: Number of times to run (usually 1)
   - **Delay**: Time between requests (0-5000ms)
   - **Data**: Optional CSV/JSON data file

4. **Click "Run ReqRes API Testing Suite"**

### Running Specific Folders

1. **Right-click folder**
2. **Select "Run folder"**
3. **Configure and execute**

### Analyzing Collection Run Results

After running, you'll see:
- **Summary**: Pass/fail statistics
- **Request details**: Individual request results
- **Test results**: Which assertions passed/failed
- **Response times**: Performance metrics

## Step 9: Collection Export and Sharing

### Exporting Collections

1. **Right-click collection**
2. **Select "Export"**
3. **Choose format**:
   - **Collection v2.1** (recommended for Newman)
   - **Collection v2.0** (legacy compatibility)
4. **Save file**: `reqres-api-testing-suite.json`

### Sharing Collections

**Methods for sharing:**
1. **Export/Import**: JSON files
2. **Postman Cloud**: Built-in sync
3. **Version control**: Git repositories
4. **Team workspaces**: Postman Teams feature

### Collection Documentation

1. **Click collection**
2. **Go to "Documentation" tab**
3. **Click "Publish Docs"**
4. **Generate public documentation URL**

## Step 10: Advanced Collection Features

### Collection Variables Scope

Variable precedence (highest to lowest):
1. **Local variables** (within request)
2. **Environment variables**
3. **Collection variables**
4. **Global variables**

### Dynamic Variables

Postman provides built-in dynamic variables:

```javascript
// In pre-request scripts or tests
{{$timestamp}}     // Current timestamp
{{$randomInt}}     // Random integer
{{$guid}}          // Random GUID
{{$randomEmail}}   // Random email
{{$randomFirstName}} // Random first name
```

### Data-Driven Testing

Create CSV file for multiple test data:

**users.csv:**
```csv
name,job,expectedStatus
John Doe,Developer,201
Jane Smith,Tester,201
Invalid User,,400
```

Use in collection runner:
1. **Run collection**
2. **Select data file**
3. **Collection runs once per data row**

### Collection Monitors

Set up automated collection runs:

1. **Click collection**
2. **Click "Monitor collection"**
3. **Configure schedule**:
   - **Frequency**: Hourly, daily, weekly
   - **Environment**: Which environment to use
   - **Notifications**: Email alerts on failures

## Step 11: Collaboration Best Practices

### Team Collection Standards

1. **Consistent naming**: Agree on naming conventions
2. **Documentation**: Document all requests clearly
3. **Variable usage**: Use variables instead of hardcoded values
4. **Test coverage**: Ensure all requests have tests
5. **Environment management**: Separate dev/staging/prod

### Version Control

**Track collections in Git:**
```bash
# Export collection
postman-collection-export.json

# Commit to repository
git add collections/
git commit -m "Update API collection with new endpoints"
git push origin main
```

### Code Reviews for Collections

Review checklist:
- [ ] Clear, descriptive request names
- [ ] Proper use of variables
- [ ] Comprehensive test assertions
- [ ] Appropriate folder organization
- [ ] Documentation is complete
- [ ] No hardcoded sensitive data

## Summary and Next Steps

In this lesson, you've mastered:

1. **✅ Collection creation and organization**
2. **✅ Folder structure design**
3. **✅ Variables and environments**
4. **✅ Collection-level scripts**
5. **✅ Request organization best practices**
6. **✅ Collection running and analysis**
7. **✅ Export and sharing workflows**

### Key Achievements:
- **Organized testing structure** for maintainability
- **Variable-driven requests** for flexibility
- **Comprehensive test coverage** across operations
- **Team collaboration capabilities** for sharing
- **Automated execution** preparation

**Ready for Lesson 6**: Installing and configuring Newman CLI for command-line automation and CI/CD integration.

---

**Continue to [Lesson 6: Newman CLI Setup](lesson-06-newman-cli.md)**