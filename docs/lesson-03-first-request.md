# Lesson 3: Your First API Request and Response Analysis

## Learning Objectives
- Send your first comprehensive API request using Postman
- Analyze and understand API response structure in detail
- Master response time analysis and performance considerations
- Understand HTTP headers and their significance
- Practice with different endpoints and HTTP methods
- Learn to interpret response data for testing purposes

## Prerequisites
- Completed Lessons 0-2 (Prerequisites, Installation, RESTful APIs)
- Postman installed and configured
- Understanding of HTTP methods and status codes
- Basic familiarity with JSON format

## Step 1: Create Your First Request

### Setting Up the Request

1. **Open Postman**
2. **Click "New" → "HTTP Request"**
3. **Name your request**: "My First API Call"

### Configure Basic GET Request

**Request Configuration:**
- **Method**: GET (already selected by default)
- **URL**: `https://reqres.in/api/users`
- **Description**: "Retrieve list of users from ReqRes API"

### Understanding the Request URL

Let's break down `https://reqres.in/api/users`:

```
https://reqres.in/api/users
│     │              │   │
│     │              │   └── Resource (users)
│     │              └── API path prefix
│     └── Domain (reqres.in)
└── Protocol (HTTPS - secure)
```

### Send Your First Request

1. **Click the blue "Send" button**
2. **Wait for the response** (should take ~100-300ms)
3. **Observe the response panel** that appears below

## Step 2: Analyzing the Response

### Response Status Information

Look at the **status section** in the top-right of the response panel:

```
Status: 200 OK
Time: 156 ms
Size: 1.89 KB
```

**What this means:**
- **200 OK**: Request was successful
- **156 ms**: Server response time (very fast!)
- **1.89 KB**: Size of response data

### Response Headers Analysis

Click the **"Headers"** tab in the response section:

```
Content-Type: application/json; charset=utf-8
Content-Length: 1934
Date: Thu, 19 Sep 2024 10:30:00 GMT
Server: cloudflare
Access-Control-Allow-Origin: *
Cache-Control: max-age=14400
```

**Key Headers Explained:**
- **Content-Type**: Tells us the response is JSON format
- **Content-Length**: Exact size of response in bytes
- **Date**: When the server processed the request
- **Server**: What server technology is being used
- **Access-Control-Allow-Origin**: CORS settings (allows browser requests)
- **Cache-Control**: How long browsers can cache this response

### Response Body Analysis

Click the **"Body"** tab to see the actual data:

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
    },
    {
      "id": 2,
      "email": "janet.weaver@reqres.in",
      "first_name": "Janet",
      "last_name": "Weaver",
      "avatar": "https://reqres.in/img/faces/2-image.jpg"
    }
    // ... 4 more users
  ],
  "support": {
    "url": "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
    "text": "Tired of writing endless social media content? Let Content Caddy generate it for you."
  }
}
```

### Understanding the Response Structure

#### Pagination Information
```json
{
  "page": 1,           // Current page number
  "per_page": 6,       // Items shown per page
  "total": 12,         // Total items available
  "total_pages": 2     // Total pages needed to show all items
}
```

**Real-world usage**: This tells you there are 12 users total, showing 6 per page, so you need 2 pages to see all users.

#### Data Array
```json
{
  "data": [
    // Array of 6 user objects
  ]
}
```

Each user object contains:
- **id**: Unique identifier (number)
- **email**: User's email address (string)
- **first_name**: User's first name (string)
- **last_name**: User's last name (string)
- **avatar**: URL to profile picture (string)

#### Support Object
```json
{
  "support": {
    "url": "https://contentcaddy.io...",
    "text": "Tired of writing endless..."
  }
}
```

**Note**: This is metadata that can be ignored for testing purposes.

## Step 3: Testing Different Endpoints

### Exercise 1: Get Single User

1. **Create new request**:
   - **Method**: GET
   - **URL**: `https://reqres.in/api/users/2`
   - **Name**: "Get Single User"

2. **Send request and analyze**:
   - **Expected Status**: 200 OK
   - **Response Time**: Should be faster (less data)
   - **Response Structure**: Single user object instead of array

**Response Analysis:**
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
    // ... support info
  }
}
```

**Key Differences from Previous Response:**
- No pagination info (not needed for single item)
- `data` is an object, not an array
- Faster response time due to less data

### Exercise 2: Test User Not Found

1. **Create new request**:
   - **Method**: GET
   - **URL**: `https://reqres.in/api/users/23`
   - **Name**: "Get Non-Existent User"

2. **Send request and analyze**:
   - **Expected Status**: 404 Not Found
   - **Response Body**: Empty object `{}`

**This demonstrates:**
- How APIs handle invalid requests
- Proper HTTP status code usage
- Empty response for not found items

### Exercise 3: Test with Query Parameters

1. **Create new request**:
   - **Method**: GET
   - **URL**: `https://reqres.in/api/users?page=2`
   - **Name**: "Get Users Page 2"

2. **Analyze pagination**:
   - **Page number**: Should be 2
   - **Different users**: Different user IDs
   - **Same structure**: Consistent API design

**Query Parameter Breakdown:**
```
https://reqres.in/api/users?page=2
                           │
                           └── Query parameter: page=2
```

## Step 4: Testing POST Requests

### Creating New Data

1. **Create new request**:
   - **Method**: POST
   - **URL**: `https://reqres.in/api/users`
   - **Name**: "Create New User"

2. **Set headers**:
   - Click **"Headers"** tab
   - Add: `Content-Type: application/json`

3. **Add request body**:
   - Click **"Body"** tab
   - Select **"raw"**
   - Choose **"JSON"** from dropdown
   - Enter this data:
   ```json
   {
     "name": "Database Tester",
     "job": "API Quality Assurance"
   }
   ```

4. **Send request and analyze**:
   - **Expected Status**: 201 Created
   - **Response includes**: Your data + id + createdAt timestamp

**Response Analysis:**
```json
{
  "name": "Database Tester",
  "job": "API Quality Assurance",
  "id": "7",
  "createdAt": "2024-09-19T10:30:45.123Z"
}
```

**What happened:**
- Server received your data
- Created new user record
- Generated unique ID
- Added creation timestamp
- Returned complete user object

## Step 5: Response Time Analysis

### Understanding Response Times

**Response time categories:**
- **Excellent**: < 100ms
- **Good**: 100-300ms
- **Acceptable**: 300-1000ms
- **Slow**: 1000-3000ms
- **Very slow**: > 3000ms

### Factors Affecting Response Time

1. **Network latency**: Distance to server
2. **Server processing**: Database queries, business logic
3. **Data size**: Larger responses take longer
4. **Server load**: High traffic slows responses

### Testing Delayed Responses

1. **Create new request**:
   - **Method**: GET
   - **URL**: `https://reqres.in/api/users?delay=3`
   - **Name**: "Test Delayed Response"

2. **Send and observe**:
   - **Response time**: Should be ~3000ms (3 seconds)
   - **Status**: Still 200 OK
   - **Data**: Same as normal request

**This simulates**:
- Slow network conditions
- Heavy server processing
- Database performance issues

## Step 6: Headers Deep Dive

### Request Headers Analysis

In your request, click **"Headers"** tab to see what Postman sends:

```
User-Agent: PostmanRuntime/7.34.0
Accept: */*
Cache-Control: no-cache
Postman-Token: 12345678-1234-1234-1234-123456789012
Host: reqres.in
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
```

**Key Request Headers:**
- **User-Agent**: Identifies the client (Postman)
- **Accept**: What content types we'll accept
- **Host**: Which server we're requesting from
- **Accept-Encoding**: Compression formats we support

### Custom Headers Exercise

1. **Add custom header**:
   - Header: `X-My-Custom-Header`
   - Value: `DatabaseTester-Learning`

2. **Send request**:
   - Check that it doesn't affect the response
   - Server ignores unknown headers gracefully

## Step 7: Common Response Patterns

### Successful Response Pattern
```json
{
  "status": "success",
  "data": {
    // Actual data here
  },
  "message": "Operation completed successfully"
}
```

### Error Response Pattern
```json
{
  "status": "error",
  "error": {
    "code": 400,
    "message": "Invalid input data",
    "details": "Email field is required"
  }
}
```

### Paginated Response Pattern
```json
{
  "data": [ /* items */ ],
  "pagination": {
    "page": 1,
    "per_page": 10,
    "total": 100,
    "total_pages": 10,
    "has_next": true,
    "has_prev": false
  }
}
```

## Step 8: Practical Exercises

### Exercise A: Complete User Journey

1. **Get all users** (GET /api/users)
2. **Get specific user** (GET /api/users/2)
3. **Create new user** (POST /api/users)
4. **Update the user** (PUT /api/users/2)
5. **Delete the user** (DELETE /api/users/2)

**Document for each request:**
- Status code received
- Response time
- Key data in response
- Any unexpected behavior

### Exercise B: Error Handling

Test these scenarios:
1. **Invalid URL**: `https://reqres.in/api/invalid`
2. **Malformed JSON**: POST with invalid JSON body
3. **Missing headers**: POST without Content-Type

### Exercise C: Performance Testing

1. **Measure baseline**: Normal GET request time
2. **Test with delay**: ?delay=1, ?delay=5
3. **Large dataset**: Different page numbers
4. **Document findings**: Create response time log

## Step 9: Best Practices for Response Analysis

### 1. Always Check Status First
```
✅ Status 200? → Proceed to analyze body
❌ Status 400+? → Focus on error message
⚠️  Status 500+? → Server issue, retry later
```

### 2. Validate Response Structure
- Does the response match expected format?
- Are required fields present?
- Are data types correct?

### 3. Monitor Performance
- Is response time acceptable?
- Are there performance patterns?
- Does response time increase with data size?

### 4. Understand Error Responses
- What error codes does the API return?
- Are error messages helpful for debugging?
- How does the API handle edge cases?

## Step 10: Common Issues and Troubleshooting

### Issue 1: Request Timeout
**Symptoms**: No response after long wait
**Solutions**:
- Check internet connection
- Verify URL spelling
- Try with shorter timeout

### Issue 2: Unexpected Status Code
**Symptoms**: Getting 500 instead of 200
**Solutions**:
- Check request format
- Verify required headers
- Review request body syntax

### Issue 3: Empty Response
**Symptoms**: Status 200 but no data
**Solutions**:
- Check if resource exists
- Verify permissions
- Review API documentation

## Summary and Next Steps

In this lesson, you've learned to:

1. **✅ Send GET and POST requests** using Postman
2. **✅ Analyze response status, headers, and body**
3. **✅ Understand response time implications**
4. **✅ Test different endpoints** and scenarios
5. **✅ Handle error responses** appropriately
6. **✅ Document API behavior** for testing

### Key Takeaways:
- **Status codes** tell you what happened
- **Response time** matters for user experience
- **Headers** provide important metadata
- **Response structure** should be consistent
- **Error handling** reveals API quality

**Ready for Lesson 4**: Writing comprehensive test assertions to automate response validation.

---

**Continue to [Lesson 4: Writing Test Assertions](lesson-04-assertions.md)**