# Lesson 2: Understanding RESTful APIs with ReqRes

## Learning Objectives
- Master RESTful API fundamentals and principles
- Understand HTTP methods and their purposes
- Learn HTTP status codes and their meanings
- Explore ReqRes API endpoints for hands-on practice
- Analyze JSON response structures

## Prerequisites
- Completed Lesson 1 (Postman installed and configured)
- Basic understanding of web concepts
- Familiarity with JSON format

## What is REST?

**REST** = **REpresentational State Transfer**

### Key REST Principles:

1. **Stateless**: Each request contains all needed information
2. **Client-Server**: Separation of concerns
3. **Cacheable**: Responses can be cached for performance
4. **Uniform Interface**: Consistent way to interact with resources
5. **Layered System**: Architecture can have multiple layers

### REST vs Other Approaches:
- **REST**: Uses standard HTTP methods (GET, POST, PUT, DELETE)
- **SOAP**: XML-based protocol with complex structure
- **GraphQL**: Single endpoint with flexible queries

## HTTP Methods (Verbs)

### GET - Retrieve Data
- **Purpose**: Read/fetch data from server
- **Safe**: Doesn't modify server state
- **Idempotent**: Multiple calls produce same result
- **Example**: Get user information, list products

```http
GET /api/users/2
```

### POST - Create Data
- **Purpose**: Create new resources
- **Not Safe**: Modifies server state
- **Not Idempotent**: Multiple calls create multiple resources
- **Example**: Create new user, submit form

```http
POST /api/users
Content-Type: application/json

{
  "name": "John Doe",
  "job": "Developer"
}
```

### PUT - Update/Replace Data
- **Purpose**: Update entire resource or create if doesn't exist
- **Not Safe**: Modifies server state
- **Idempotent**: Multiple calls produce same result
- **Example**: Update user profile completely

```http
PUT /api/users/2
Content-Type: application/json

{
  "name": "Jane Smith",
  "job": "Senior Developer"
}
```

### PATCH - Partial Update
- **Purpose**: Update specific fields of a resource
- **Not Safe**: Modifies server state
- **Idempotent**: Usually (depends on implementation)
- **Example**: Update only user's job title

```http
PATCH /api/users/2
Content-Type: application/json

{
  "job": "Team Lead"
}
```

### DELETE - Remove Data
- **Purpose**: Remove resources from server
- **Not Safe**: Modifies server state
- **Idempotent**: Multiple calls produce same result
- **Example**: Delete user account, remove product

```http
DELETE /api/users/2
```

## HTTP Status Codes

### Success Codes (2xx)
| Code | Name | Meaning | When Used |
|------|------|---------|-----------|
| 200 | OK | Request successful | GET, PUT, PATCH |
| 201 | Created | Resource created successfully | POST |
| 204 | No Content | Success, no response body | DELETE |

### Client Error Codes (4xx)
| Code | Name | Meaning | When Used |
|------|------|---------|-----------|
| 400 | Bad Request | Invalid request format | Malformed JSON, missing fields |
| 401 | Unauthorized | Authentication required | Missing/invalid credentials |
| 403 | Forbidden | Access denied | Valid auth, insufficient permissions |
| 404 | Not Found | Resource doesn't exist | Invalid ID, deleted resource |
| 422 | Unprocessable Entity | Valid format, invalid data | Business rule violations |

### Server Error Codes (5xx)
| Code | Name | Meaning | When Used |
|------|------|---------|-----------|
| 500 | Internal Server Error | Server-side problem | Database errors, crashes |
| 502 | Bad Gateway | Upstream server error | Proxy/load balancer issues |
| 503 | Service Unavailable | Server temporarily down | Maintenance, overload |

## Introduction to ReqRes API

### What is ReqRes?
**ReqRes** (Request + Response) is a hosted REST API designed specifically for testing and prototyping.

### Why Use ReqRes for Learning?
- ✅ **Real HTTP responses** to your requests
- ✅ **Consistent test data** (always available)
- ✅ **All CRUD operations** supported
- ✅ **CORS enabled** for browser testing
- ✅ **No authentication** required for basic endpoints
- ✅ **Realistic response structures**

### ReqRes Base URL
```
https://reqres.in/api
```

## Complete ReqRes API Endpoints

### User Management Endpoints

#### 1. List Users (Paginated)
```http
GET https://reqres.in/api/users
GET https://reqres.in/api/users?page=2
```

**Response Structure:**
```json
{
  "page": 1,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 1,
      "email": "george.bluth@reqres.in",
      "first_name": "George",
      "last_name": "Bluth",
      "avatar": "https://reqres.in/img/faces/1-image.jpg"
    }
  ],
  "support": {
    "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
    "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
  }
}
```

#### 2. Single User
```http
GET https://reqres.in/api/users/2
```

**Response Structure:**
```json
{
  "data": {
    "id": 2,
    "email": "janet.weaver@reqres.in",
    "first_name": "Janet",
    "last_name": "Weaver",
    "avatar": "https://reqres.in/img/faces/2-image.jpg"
  },
  "support": {
    "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
    "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
  }
}
```

#### 3. User Not Found
```http
GET https://reqres.in/api/users/23
```

**Response**: `{}` (empty object) with **404 status**

#### 4. Create User
```http
POST https://reqres.in/api/users
Content-Type: application/json

{
    "name": "morpheus",
    "job": "leader"
}
```

**Response Structure:**
```json
{
    "name": "morpheus",
    "job": "leader",
    "id": "7",
    "createdAt": "2024-01-15T10:30:45.123Z"
}
```

#### 5. Update User (PUT)
```http
PUT https://reqres.in/api/users/2
Content-Type: application/json

{
    "name": "morpheus",
    "job": "zion resident"
}
```

**Response Structure:**
```json
{
    "name": "morpheus",
    "job": "zion resident",
    "updatedAt": "2024-01-15T10:35:22.456Z"
}
```

#### 6. Delete User
```http
DELETE https://reqres.in/api/users/2
```

**Response**: Empty body with **204 status**

### Authentication Endpoints

#### 7. Register Successful
```http
POST https://reqres.in/api/register
Content-Type: application/json

{
    "email": "eve.holt@reqres.in",
    "password": "pistol"
}
```

**Response Structure:**
```json
{
    "id": 4,
    "token": "QpwL5tke4Pnpja7X4"
}
```

#### 8. Register Unsuccessful
```http
POST https://reqres.in/api/register
Content-Type: application/json

{
    "email": "sydney@fife"
}
```

**Response Structure:**
```json
{
    "error": "Missing password"
}
```
**Status**: 400 Bad Request

#### 9. Login Successful
```http
POST https://reqres.in/api/login
Content-Type: application/json

{
    "email": "eve.holt@reqres.in",
    "password": "cityslicka"
}
```

**Response Structure:**
```json
{
    "token": "QpwL5tke4Pnpja7X4"
}
```

#### 10. Login Unsuccessful
```http
POST https://reqres.in/api/login
Content-Type: application/json

{
    "email": "peter@klaven"
}
```

**Response Structure:**
```json
{
    "error": "Missing password"
}
```
**Status**: 400 Bad Request

### Resource Management Endpoints

#### 11. List Resources
```http
GET https://reqres.in/api/unknown
```

#### 12. Single Resource
```http
GET https://reqres.in/api/unknown/2
```

#### 13. Resource Not Found
```http
GET https://reqres.in/api/unknown/23
```

### Special Features

#### Delayed Response
Add `?delay=3` to any endpoint to simulate network latency:
```http
GET https://reqres.in/api/users?delay=3
```

This will delay the response by 3 seconds, useful for testing timeouts and loading states.

## Understanding JSON Response Structure

### Pagination Object
```json
{
  "page": 1,           // Current page number
  "per_page": 6,       // Items per page
  "total": 12,         // Total items available
  "total_pages": 2     // Total pages available
}
```

### User Object
```json
{
  "id": 1,                                              // Unique identifier
  "email": "george.bluth@reqres.in",                   // Email address
  "first_name": "George",                              // First name
  "last_name": "Bluth",                                // Last name
  "avatar": "https://reqres.in/img/faces/1-image.jpg"  // Profile image URL
}
```

### Support Object
```json
{
  "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
  "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
}
```
*Note: Support object can be ignored for testing purposes*

## Hands-On Practice

### Exercise 1: Basic GET Request
1. **Open Postman**
2. **Create new request**: New → HTTP Request
3. **Configure**:
   - Method: GET
   - URL: `https://reqres.in/api/users`
4. **Send request**
5. **Analyze response**:
   - Status code: Should be 200
   - Response time: Note the duration
   - Body: JSON with user data array

### Exercise 2: Single User Request
1. **Create new request**
2. **Configure**:
   - Method: GET
   - URL: `https://reqres.in/api/users/2`
3. **Send and compare** with previous response structure

### Exercise 3: 404 Error Request
1. **Create new request**
2. **Configure**:
   - Method: GET
   - URL: `https://reqres.in/api/users/23`
3. **Send and observe**:
   - Status code: Should be 404
   - Body: Empty object `{}`

### Exercise 4: POST Request
1. **Create new request**
2. **Configure**:
   - Method: POST
   - URL: `https://reqres.in/api/users`
   - Headers: Content-Type: application/json
   - Body (raw):
   ```json
   {
       "name": "Your Name",
       "job": "API Tester"
   }
   ```
3. **Send and analyze**:
   - Status code: Should be 201
   - Response includes your data plus id and createdAt

## Key Terminology

**API (Application Programming Interface)**: Set of protocols for building software applications

**Endpoint**: Specific URL where an API can be accessed

**Resource**: Data object that can be accessed via API (users, products, orders)

**JSON (JavaScript Object Notation)**: Lightweight data-interchange format

**HTTP Headers**: Metadata sent with requests/responses

**Query Parameters**: Key-value pairs in URL for filtering/configuration

**Request Body**: Data sent in POST/PUT requests

**Response Body**: Data returned by the API

## Common Response Headers

```http
Content-Type: application/json; charset=utf-8
Content-Length: 1234
Date: Mon, 15 Jan 2024 10:30:00 GMT
Server: cloudflare
Access-Control-Allow-Origin: *
```

## Best Practices for API Testing

1. **Always check status codes** before analyzing response body
2. **Validate response structure** against documentation
3. **Test error scenarios** (404, 400, 500) not just success cases
4. **Check response times** for performance issues
5. **Verify data types** (string, number, boolean, array)
6. **Test edge cases** (empty responses, large datasets)

## Next Steps

Now that you understand RESTful APIs and ReqRes endpoints:

1. **✅ HTTP methods mastered** (GET, POST, PUT, DELETE)
2. **✅ Status codes understood** (200, 201, 404, 400, 500)
3. **✅ ReqRes API explored** with real requests
4. **✅ JSON structure analyzed** and understood

**Ready for Lesson 3**: Making your first comprehensive API request and response analysis.

---

**Continue to [Lesson 3: Your First API Request](lesson-03-first-request.md)**