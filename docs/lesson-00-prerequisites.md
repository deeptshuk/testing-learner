# Lesson 0: Prerequisites - Understanding the Fundamentals

## Learning Objectives
- Understand what APIs are and why they matter
- Learn HTTP protocol fundamentals and how web communication works
- Master REST architecture principles and concepts
- Understand command line interface (CLI) basics
- Learn HTTP status codes and their meanings
- Understand JSON data format and structure
- Know what to expect in API calls and responses

## Who This Lesson Is For
This lesson is designed for complete beginners who may not have prior experience with:
- Web development concepts
- API testing or integration
- Command line interfaces
- HTTP protocols and web communication

## What is an API?

### API Definition
**API** stands for **Application Programming Interface**

Think of an API as a **waiter in a restaurant**:
- **You (the client)** want to order food
- **The kitchen (the server)** prepares the food
- **The waiter (the API)** takes your order to the kitchen and brings back your food

### Real-World API Examples

#### 1. Weather App
When you check weather on your phone:
- **Your app** sends a request to a weather API
- **Weather service** sends back temperature, conditions, forecast
- **Your app** displays this information in a user-friendly way

#### 2. Social Media Login
When you "Login with Google" on a website:
- **Website** asks Google's API to verify your identity
- **Google** confirms you're logged in
- **Website** grants you access without needing a separate password

#### 3. Payment Processing
When you buy something online:
- **Store's website** sends payment info to payment API (like Stripe)
- **Payment service** processes your card
- **API** returns success/failure status to the store

### Why APIs Matter for Database Testers
As a database tester, you'll often need to:
- **Verify data integrity** between systems
- **Test data flows** from databases to applications
- **Validate business logic** implemented in APIs
- **Ensure data security** and access controls
- **Performance test** database-backed APIs

## Understanding HTTP Protocol

### What is HTTP?
**HTTP** = **HyperText Transfer Protocol**

HTTP is the **language** that computers use to communicate over the internet.

### HTTP is Like Postal Mail

| Postal Mail | HTTP Request |
|-------------|--------------|
| **Sender Address** | Client (your computer/app) |
| **Recipient Address** | Server (website/API) |
| **Letter Content** | Request data (what you want) |
| **Return Address** | Where to send the response |
| **Mail Type** (regular, express, certified) | HTTP Method (GET, POST, PUT, DELETE) |

### HTTP Request Structure

Every HTTP request has these parts:

#### 1. HTTP Method (Verb)
**What** you want to do:
```
GET    - "Please give me some data"
POST   - "Please save this new data"
PUT    - "Please update this data completely"
PATCH  - "Please update part of this data"
DELETE - "Please remove this data"
```

#### 2. URL (Uniform Resource Locator)
**Where** to send the request:
```
https://api.example.com/users/123
│     │ │              │     │
│     │ │              │     └── Specific user ID
│     │ │              └── Resource (users)
│     │ └── Domain name
│     └── Protocol (secure HTTP)
```

#### 3. Headers
**Metadata** about the request:
```
Content-Type: application/json    ← What format is the data?
Authorization: Bearer xyz123      ← Who am I?
Accept: application/json          ← What format do I want back?
```

#### 4. Body (for POST/PUT requests)
**The actual data** being sent:
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "job": "Database Tester"
}
```

### HTTP Response Structure

Every HTTP response includes:

#### 1. Status Code
**How did it go?**
```
200 - "Success! Here's your data"
404 - "Sorry, couldn't find what you asked for"
500 - "Oops, something went wrong on our end"
```

#### 2. Headers
**Metadata** about the response:
```
Content-Type: application/json
Content-Length: 1234
Date: Mon, 15 Jan 2024 10:30:00 GMT
```

#### 3. Body
**The actual data** being returned:
```json
{
  "id": 123,
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2024-01-15T10:30:00Z"
}
```

## HTTP Status Codes Explained

Status codes tell you **what happened** with your request.

### Success Codes (2xx) - "Everything went well"

| Code | Name | Meaning | When You See It |
|------|------|---------|-----------------|
| **200** | OK | Request successful | GET requests that found data |
| **201** | Created | New resource created | POST requests that saved data |
| **204** | No Content | Success, but no data to return | DELETE requests |

**Example**: You ask for user info, get 200 + user data

### Client Error Codes (4xx) - "You made a mistake"

| Code | Name | Meaning | When You See It |
|------|------|---------|-----------------|
| **400** | Bad Request | Request format is wrong | Missing required fields, invalid JSON |
| **401** | Unauthorized | You need to log in | Missing or invalid credentials |
| **403** | Forbidden | You don't have permission | Valid login, but insufficient rights |
| **404** | Not Found | Resource doesn't exist | Wrong URL, deleted item |
| **422** | Unprocessable Entity | Data format OK, but invalid | Valid JSON, but business rule violation |

**Example**: You ask for user ID 999999, get 404 because that user doesn't exist

### Server Error Codes (5xx) - "We made a mistake"

| Code | Name | Meaning | When You See It |
|------|------|---------|-----------------|
| **500** | Internal Server Error | Something broke on the server | Database crashes, code bugs |
| **502** | Bad Gateway | Proxy/load balancer issues | Server infrastructure problems |
| **503** | Service Unavailable | Server temporarily down | Maintenance, overload |

**Example**: Server database crashes, you get 500 even though your request was perfect

## What is REST?

### REST Definition
**REST** = **REpresentational State Transfer**

REST is a **set of rules** for designing APIs that are:
- **Simple** to understand
- **Predictable** in behavior
- **Scalable** for large systems

### REST Principles

#### 1. Resources and URLs
Everything is a **resource** with a unique **URL**:

```
Users resource:     /api/users
Specific user:      /api/users/123
User's orders:      /api/users/123/orders
Specific order:     /api/users/123/orders/456
```

#### 2. HTTP Methods Define Actions
Use standard HTTP methods for actions:

| Method | Purpose | Example |
|--------|---------|---------|
| GET | Read/retrieve | `GET /api/users` → Get all users |
| POST | Create new | `POST /api/users` → Create new user |
| PUT | Update completely | `PUT /api/users/123` → Replace user 123 |
| PATCH | Update partially | `PATCH /api/users/123` → Update some fields |
| DELETE | Remove | `DELETE /api/users/123` → Delete user 123 |

#### 3. Stateless
Each request is **independent**:
- Server doesn't remember previous requests
- Each request contains all needed information
- No server-side sessions or cookies for state

#### 4. Standard Data Format
Usually **JSON** (JavaScript Object Notation):
```json
{
  "id": 123,
  "name": "John Doe",
  "email": "john@example.com",
  "active": true,
  "roles": ["user", "tester"]
}
```

### RESTful API Example

**Task**: Manage a user in a system

```bash
# Create a new user
POST /api/users
{
  "name": "Alice Smith",
  "email": "alice@example.com"
}
→ Response: 201 Created + user data with new ID

# Get all users
GET /api/users
→ Response: 200 OK + array of all users

# Get specific user
GET /api/users/123
→ Response: 200 OK + user 123 data

# Update user
PUT /api/users/123
{
  "name": "Alice Johnson",
  "email": "alice.johnson@example.com"
}
→ Response: 200 OK + updated user data

# Delete user
DELETE /api/users/123
→ Response: 204 No Content
```

## Understanding JSON

### What is JSON?
**JSON** = **JavaScript Object Notation**

JSON is a **text format** for storing and exchanging data.

### JSON vs Other Formats

#### JSON (Easy to read)
```json
{
  "name": "John",
  "age": 30,
  "active": true
}
```

#### XML (Verbose)
```xml
<user>
  <name>John</name>
  <age>30</age>
  <active>true</active>
</user>
```

#### CSV (Limited structure)
```csv
name,age,active
John,30,true
```

### JSON Data Types

#### 1. String (Text)
```json
{
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### 2. Number
```json
{
  "age": 30,
  "price": 99.99,
  "count": 0
}
```

#### 3. Boolean (True/False)
```json
{
  "active": true,
  "verified": false
}
```

#### 4. Array (List)
```json
{
  "hobbies": ["reading", "coding", "testing"],
  "scores": [85, 92, 78]
}
```

#### 5. Object (Nested data)
```json
{
  "user": {
    "name": "John",
    "address": {
      "street": "123 Main St",
      "city": "New York"
    }
  }
}
```

#### 6. Null (No value)
```json
{
  "middle_name": null,
  "notes": null
}
```

### Real API Response Example
```json
{
  "status": "success",
  "data": {
    "user_id": 12345,
    "username": "database_tester",
    "email": "tester@company.com",
    "roles": ["tester", "user"],
    "profile": {
      "first_name": "Jane",
      "last_name": "Smith",
      "department": "Quality Assurance"
    },
    "preferences": {
      "email_notifications": true,
      "theme": "dark"
    },
    "last_login": "2024-01-15T10:30:00Z",
    "account_balance": null
  },
  "timestamp": "2024-01-15T10:30:45Z"
}
```

## Command Line Interface (CLI) Basics

### What is CLI?
**CLI** = **Command Line Interface**

CLI is a **text-based way** to interact with your computer, instead of clicking buttons.

### Why Learn CLI for API Testing?
- **Newman CLI** runs Postman collections from command line
- **Automation scripts** use CLI commands
- **CI/CD pipelines** run tests via CLI
- **Server environments** often only have CLI access

### Essential CLI Concepts

#### 1. Terminal/Shell
The **black window** where you type commands:
- **macOS**: Terminal app (Applications → Utilities → Terminal)
- **Windows**: Command Prompt or PowerShell
- **Linux**: bash, zsh, or other shells

#### 2. Current Directory
Where you are **right now** in the file system:
```bash
pwd                    # Print Working Directory - where am I?
/Users/yourname/Desktop
```

#### 3. Navigation
Moving around the file system:
```bash
ls                     # List files in current directory
cd Documents           # Change Directory to Documents folder
cd ..                  # Go up one level (parent directory)
cd ~                   # Go to home directory
```

#### 4. File Operations
Working with files:
```bash
cat README.md          # Display file contents
mkdir test-folder      # Create new directory
touch newfile.txt      # Create empty file
rm oldfile.txt         # Delete file
cp file1.txt file2.txt # Copy file
```

### CLI Commands for API Testing

#### Node.js and npm
```bash
node --version         # Check if Node.js is installed
npm --version          # Check npm version
npm install -g newman  # Install Newman globally
```

#### Newman CLI Commands
```bash
newman --help          # Show help information
newman --version       # Show Newman version
newman run collection.json              # Run Postman collection
newman run collection.json -e env.json  # Run with environment
```

#### Git Commands
```bash
git status            # Check repository status
git add .             # Stage all changes
git commit -m "msg"   # Commit with message
git push              # Push to remote repository
```

## What to Expect in API Calls

### Typical API Request Flow

#### 1. Prepare Request
```
You need to:
- Choose HTTP method (GET, POST, etc.)
- Set the URL endpoint
- Add headers if needed
- Include request body for POST/PUT
```

#### 2. Send Request
```
Your tool (Postman/Newman) sends the request to the server
```

#### 3. Server Processing
```
Server:
- Receives your request
- Validates the data
- Processes business logic
- Queries database if needed
- Prepares response
```

#### 4. Receive Response
```
You get back:
- Status code (200, 404, 500, etc.)
- Response headers
- Response body (usually JSON)
- Response time
```

### Common API Patterns

#### 1. CRUD Operations
**C**reate, **R**ead, **U**pdate, **D**elete

```bash
# Create
POST /api/users
Body: {"name": "John", "email": "john@example.com"}
Response: 201 Created + new user with ID

# Read (all)
GET /api/users
Response: 200 OK + array of users

# Read (one)
GET /api/users/123
Response: 200 OK + user 123 data

# Update
PUT /api/users/123
Body: {"name": "John Smith", "email": "johnsmith@example.com"}
Response: 200 OK + updated user

# Delete
DELETE /api/users/123
Response: 204 No Content
```

#### 2. Authentication Flow
```bash
# 1. Login
POST /api/login
Body: {"email": "user@example.com", "password": "secret"}
Response: 200 OK + {"token": "abc123"}

# 2. Use token for protected requests
GET /api/profile
Headers: {"Authorization": "Bearer abc123"}
Response: 200 OK + user profile data
```

#### 3. Error Handling
```bash
# Bad request
POST /api/users
Body: {"name": ""}  # Missing required email
Response: 400 Bad Request + {"error": "Email is required"}

# Not found
GET /api/users/999999
Response: 404 Not Found + {"error": "User not found"}

# Server error
GET /api/users
Response: 500 Internal Server Error + {"error": "Database connection failed"}
```

### API Testing Requirements

When testing APIs, you should verify:

#### 1. Functional Requirements
- **Correct data** returned for valid requests
- **Proper error messages** for invalid requests
- **Business logic** implemented correctly
- **Data validation** working as expected

#### 2. Technical Requirements
- **Response times** within acceptable limits
- **Status codes** are appropriate
- **Data format** matches specification (JSON schema)
- **Headers** include required information

#### 3. Security Requirements
- **Authentication** required for protected endpoints
- **Authorization** prevents unauthorized access
- **Data sanitization** prevents injection attacks
- **Sensitive data** not exposed in responses

#### 4. Integration Requirements
- **Database operations** work correctly
- **External service calls** handled properly
- **Data consistency** across related operations
- **Transaction handling** for complex operations

## Database Tester Perspective

### How APIs Relate to Database Testing

#### 1. Data Flow Testing
```
User Input → API → Business Logic → Database → API → User Interface
```

You need to verify:
- Data is **correctly stored** in database
- Data is **correctly retrieved** from database
- **Transformations** happen as expected
- **Data integrity** is maintained

#### 2. Common Test Scenarios

**Create User Test:**
```bash
# 1. API Request
POST /api/users {"name": "John", "email": "john@example.com"}

# 2. Database Verification
SELECT * FROM users WHERE email = 'john@example.com'
# Should find new record with correct data

# 3. API Response Verification
Response should contain user ID and creation timestamp
```

**Update User Test:**
```bash
# 1. API Request
PUT /api/users/123 {"name": "John Smith"}

# 2. Database Verification
SELECT name FROM users WHERE id = 123
# Should show "John Smith", not old name

# 3. API Response Verification
Response should show updated data
```

#### 3. Data Validation Points
- **Input validation**: API rejects invalid data
- **Business rules**: API enforces business constraints
- **Data types**: Correct data types stored in database
- **Relationships**: Foreign keys and constraints respected
- **Audit trails**: Changes properly logged

## Next Steps

Now that you understand the fundamentals:

1. **✅ APIs and their purpose**
2. **✅ HTTP protocol and request/response cycle**
3. **✅ REST architecture principles**
4. **✅ JSON data format structure**
5. **✅ CLI basics for automation**
6. **✅ Status codes and their meanings**
7. **✅ What to expect in API testing**

**You're ready for Lesson 1**: Installing and setting up Postman for hands-on API testing.

## Key Terminology Reference

| Term | Definition |
|------|------------|
| **API** | Application Programming Interface - allows software to communicate |
| **HTTP** | HyperText Transfer Protocol - language for web communication |
| **REST** | REpresentational State Transfer - architectural style for APIs |
| **JSON** | JavaScript Object Notation - text format for data exchange |
| **CLI** | Command Line Interface - text-based computer interaction |
| **Endpoint** | Specific URL where an API can be accessed |
| **Request** | Message sent to API asking for something |
| **Response** | Message API sends back with data or status |
| **Status Code** | Number indicating success/failure of request |
| **Header** | Metadata sent with requests/responses |
| **Body** | Actual data content in requests/responses |
| **CRUD** | Create, Read, Update, Delete - basic operations |

---

**Continue to [Lesson 1: Postman Installation and Setup](lesson-01-installation.md)**