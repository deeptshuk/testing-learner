# Lesson 4: Writing Test Assertions - Response Body & Status Codes

## Learning Objectives
- Master Postman's testing framework and syntax
- Write comprehensive status code validation tests
- Create robust response body assertions
- Understand test organization and best practices
- Build complete test suites for API validation

## Prerequisites
- Completed Lessons 1-3
- Understanding of JSON structure
- Basic familiarity with JavaScript syntax
- Knowledge of ReqRes API endpoints

## Understanding Postman's Testing Framework

### Test Framework Components
Postman uses several powerful libraries for testing:
- **pm library**: Postman's built-in testing interface
- **Chai.js**: Behavior-driven development (BDD) assertion library
- **JavaScript**: For test logic and data manipulation

### Where to Write Tests
1. **Open any request** in Postman
2. **Navigate to Scripts tab**
3. **Select "Post-response" sub-tab**
4. **Write your test code** in the editor

### Basic Test Structure
```javascript
pm.test("Test description here", function () {
    // Your assertion goes here
});
```

## Status Code Testing

### Basic Status Code Assertions

#### Test for Successful Response (200)
```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});
```

#### Test for Created Response (201)
```javascript
pm.test("User created successfully", function () {
    pm.response.to.have.status(201);
});
```

#### Test for No Content Response (204)
```javascript
pm.test("User deleted successfully", function () {
    pm.response.to.have.status(204);
});
```

#### Test for Not Found (404)
```javascript
pm.test("User not found", function () {
    pm.response.to.have.status(404);
});
```

#### Test for Bad Request (400)
```javascript
pm.test("Invalid request format", function () {
    pm.response.to.have.status(400);
});
```

### Advanced Status Code Testing

#### Test Status Code by Name
```javascript
pm.test("Status code name is OK", function () {
    pm.response.to.have.status("OK");
});
```

#### Test Multiple Acceptable Status Codes
```javascript
pm.test("Successful response", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 201, 202]);
});
```

#### Test Status Code Ranges
```javascript
pm.test("No server errors", function () {
    pm.expect(pm.response.code).to.not.be.within(500, 599);
});

pm.test("Successful status code", function () {
    pm.expect(pm.response.code).to.be.within(200, 299);
});
```

## Response Time Testing

### Basic Response Time Validation
```javascript
pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});
```

### Response Time Ranges
```javascript
pm.test("Response time is fast", function () {
    pm.expect(pm.response.responseTime).to.be.below(200);
});

pm.test("Response time is reasonable", function () {
    pm.expect(pm.response.responseTime).to.be.below(2000);
});
```

## Response Body Testing

### JSON Validation

#### Parse Response to JSON
```javascript
// Always start with parsing the response
const responseJson = pm.response.json();
```

#### Test if Response is Valid JSON
```javascript
pm.test("Response is valid JSON", function () {
    pm.response.to.be.json;
});
```

### Property Existence Testing

#### Test for Required Properties
```javascript
pm.test("Response has required properties", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson).to.have.property('data');
    pm.expect(responseJson).to.have.property('page');
    pm.expect(responseJson).to.have.property('total');
});
```

#### Test Nested Property Existence
```javascript
pm.test("User object has all fields", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.data).to.have.property('id');
    pm.expect(responseJson.data).to.have.property('email');
    pm.expect(responseJson.data).to.have.property('first_name');
    pm.expect(responseJson.data).to.have.property('last_name');
});
```

### Data Type Validation

#### Test Data Types
```javascript
pm.test("Data types are correct", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.page).to.be.a('number');
    pm.expect(responseJson.data).to.be.an('array');
    pm.expect(responseJson.data[0].email).to.be.a('string');
    pm.expect(responseJson.data[0].id).to.be.a('number');
});
```

### Value Validation

#### Test Specific Values
```javascript
pm.test("Page number is correct", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.page).to.eql(1);
});

pm.test("Per page count is 6", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.per_page).to.eql(6);
});
```

#### Test Value Ranges
```javascript
pm.test("User ID is positive", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.data[0].id).to.be.above(0);
});

pm.test("Total users is reasonable", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.total).to.be.within(1, 100);
});
```

### Array Testing

#### Test Array Length
```javascript
pm.test("Data array has 6 users", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.data).to.have.lengthOf(6);
});
```

#### Test Array Contents
```javascript
pm.test("Data array is not empty", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.data).to.not.be.empty;
});
```

#### Loop Through Array Elements
```javascript
pm.test("All users have complete information", function () {
    const responseJson = pm.response.json();
    responseJson.data.forEach(function(user) {
        pm.expect(user).to.have.property('id');
        pm.expect(user).to.have.property('email');
        pm.expect(user).to.have.property('first_name');
        pm.expect(user).to.have.property('last_name');
        pm.expect(user.id).to.be.a('number');
        pm.expect(user.email).to.be.a('string');
    });
});
```

### String Pattern Testing

#### Email Format Validation
```javascript
pm.test("Email format is valid", function () {
    const responseJson = pm.response.json();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    responseJson.data.forEach(function(user) {
        pm.expect(user.email).to.match(emailRegex);
    });
});
```

#### URL Format Validation
```javascript
pm.test("Avatar URL is valid", function () {
    const responseJson = pm.response.json();
    pm.expect(responseJson.data[0].avatar).to.include('https://');
    pm.expect(responseJson.data[0].avatar).to.include('reqres.in');
});
```

#### Date Format Validation
```javascript
pm.test("CreatedAt is valid ISO date", function () {
    const responseJson = pm.response.json();
    const isoDateRegex = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/;
    pm.expect(responseJson.createdAt).to.match(isoDateRegex);
});
```

## Header Testing

### Content-Type Validation
```javascript
pm.test("Content-Type is application/json", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.include("application/json");
});
```

### Custom Header Testing
```javascript
pm.test("Server header is present", function () {
    pm.expect(pm.response.headers.get("Server")).to.exist;
});

pm.test("CORS header allows origin", function () {
    pm.expect(pm.response.headers.get("Access-Control-Allow-Origin")).to.eql("*");
});
```

## Complete Test Suites by HTTP Method

### GET Request Test Suite (List Users)
```javascript
const responseJson = pm.response.json();

// Status and response format
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});

pm.test("Response is valid JSON", function () {
    pm.response.to.be.json;
});

// Response structure validation
pm.test("Response has pagination structure", function () {
    pm.expect(responseJson).to.have.property('page');
    pm.expect(responseJson).to.have.property('per_page');
    pm.expect(responseJson).to.have.property('total');
    pm.expect(responseJson).to.have.property('total_pages');
    pm.expect(responseJson).to.have.property('data');
});

// Data validation
pm.test("Data is array with expected length", function () {
    pm.expect(responseJson.data).to.be.an('array');
    pm.expect(responseJson.data).to.have.lengthOf(6);
});

pm.test("All users have required fields", function () {
    responseJson.data.forEach(function(user) {
        pm.expect(user).to.have.property('id');
        pm.expect(user).to.have.property('email');
        pm.expect(user).to.have.property('first_name');
        pm.expect(user).to.have.property('last_name');
        pm.expect(user).to.have.property('avatar');
    });
});

// Content validation
pm.test("Email format validation", function () {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    responseJson.data.forEach(function(user) {
        pm.expect(user.email).to.match(emailRegex);
    });
});

pm.test("Content-Type header is correct", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.include("application/json");
});
```

### POST Request Test Suite (Create User)
```javascript
const responseJson = pm.response.json();

// Status validation
pm.test("User creation successful", function () {
    pm.response.to.have.status(201);
});

pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});

// Response structure
pm.test("Response contains created user data", function () {
    pm.expect(responseJson).to.have.property('name');
    pm.expect(responseJson).to.have.property('job');
    pm.expect(responseJson).to.have.property('id');
    pm.expect(responseJson).to.have.property('createdAt');
});

// Data validation
pm.test("Created user has correct data", function () {
    pm.expect(responseJson.name).to.eql("Database Tester");
    pm.expect(responseJson.job).to.eql("API Testing Specialist");
});

pm.test("ID and timestamp are valid", function () {
    pm.expect(responseJson.id).to.be.a('string');
    pm.expect(responseJson.createdAt).to.match(/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$/);
});
```

### DELETE Request Test Suite
```javascript
// Status validation
pm.test("Delete successful", function () {
    pm.response.to.have.status(204);
});

pm.test("Response body is empty", function () {
    pm.expect(pm.response.text()).to.eql("");
});

pm.test("Content-Length is 0", function () {
    pm.expect(pm.response.headers.get("Content-Length")).to.eql("0");
});
```

### Error Handling Test Suite (404)
```javascript
pm.test("User not found status", function () {
    pm.response.to.have.status(404);
});

pm.test("Response body is empty object", function () {
    pm.expect(pm.response.json()).to.eql({});
});

pm.test("Content-Type is still JSON", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.include("application/json");
});
```

## Advanced Testing Techniques

### Conditional Testing
```javascript
pm.test("Conditional validation based on status", function () {
    if (pm.response.code === 200) {
        const responseJson = pm.response.json();
        pm.expect(responseJson).to.have.property('data');
    } else if (pm.response.code === 404) {
        pm.expect(pm.response.json()).to.eql({});
    }
});
```

### Dynamic Data Testing
```javascript
pm.test("User ID matches request parameter", function () {
    const responseJson = pm.response.json();
    const requestedUserId = pm.request.url.path[1]; // Extract from URL
    pm.expect(responseJson.data.id).to.eql(parseInt(requestedUserId));
});
```

### Variable-Based Testing
```javascript
pm.test("Response matches environment variable", function () {
    const responseJson = pm.response.json();
    const expectedUserId = pm.environment.get("userId");
    pm.expect(responseJson.data.id).to.eql(parseInt(expectedUserId));
});
```

## Test Organization Best Practices

### 1. Use Descriptive Test Names
```javascript
// ❌ Bad
pm.test("Test 1", function () { ... });

// ✅ Good
pm.test("User creation returns 201 status with complete user data", function () { ... });
```

### 2. Group Related Tests
```javascript
// Status code tests
pm.test("Status code is 200", function () { ... });
pm.test("Status code name is OK", function () { ... });

// Response structure tests
pm.test("Response has pagination info", function () { ... });
pm.test("Data array is present", function () { ... });

// Data validation tests
pm.test("All users have required fields", function () { ... });
pm.test("Email format is valid", function () { ... });
```

### 3. One Assertion Per Test
```javascript
// ❌ Bad - Multiple assertions in one test
pm.test("User data validation", function () {
    pm.response.to.have.status(200);
    pm.expect(responseJson).to.have.property('data');
    pm.expect(responseJson.data).to.be.an('array');
});

// ✅ Good - Separate tests for each assertion
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

pm.test("Response contains data property", function () {
    pm.expect(responseJson).to.have.property('data');
});

pm.test("Data is an array", function () {
    pm.expect(responseJson.data).to.be.an('array');
});
```

## Common Testing Patterns

### Pattern 1: Complete API Validation
```javascript
const responseJson = pm.response.json();

// 1. Status validation
pm.test("Request successful", function () {
    pm.response.to.have.status(200);
});

// 2. Performance validation
pm.test("Response time acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});

// 3. Format validation
pm.test("Response is JSON", function () {
    pm.response.to.be.json;
});

// 4. Structure validation
pm.test("Required properties present", function () {
    pm.expect(responseJson).to.have.property('data');
});

// 5. Content validation
pm.test("Data content is valid", function () {
    pm.expect(responseJson.data).to.not.be.empty;
});
```

### Pattern 2: Error Response Validation
```javascript
if (pm.response.code >= 400) {
    pm.test("Error response has error property", function () {
        const responseJson = pm.response.json();
        pm.expect(responseJson).to.have.property('error');
    });

    pm.test("Error message is not empty", function () {
        const responseJson = pm.response.json();
        pm.expect(responseJson.error).to.not.be.empty;
    });
}
```

## Debugging Tests

### Using Console.log for Debugging
```javascript
// Log response for debugging
console.log("Response:", pm.response.json());
console.log("Status:", pm.response.code);
console.log("Headers:", pm.response.headers);
```

### Test Failure Analysis
```javascript
pm.test("Debug user data", function () {
    const responseJson = pm.response.json();
    console.log("Full response:", responseJson);
    console.log("Data array length:", responseJson.data.length);
    console.log("First user:", responseJson.data[0]);

    pm.expect(responseJson.data).to.have.lengthOf(6);
});
```

## Next Steps

Now that you can write comprehensive test assertions:

1. **✅ Status code testing mastered**
2. **✅ Response body validation techniques learned**
3. **✅ Test organization best practices understood**
4. **✅ Complete test suites created**

**Ready for Lesson 5**: Organizing APIs in Postman Collections for better structure and automation.

---

**Continue to [Lesson 5: Organizing APIs in Postman Collections](lesson-05-collections.md)**