# Postman API Testing Guide for Database Testers

> A comprehensive, hands-on learning guide for mastering Postman API testing and Newman CLI automation, specifically designed for database testers starting their API testing journey.

## 🎯 Learning Objectives

By the end of this guide, you will:
- ✅ Write comprehensive test assertions for response bodies and status codes
- ✅ Organize APIs efficiently in Postman Collections
- ✅ Run collections with Newman CLI and generate professional HTML reports
- ✅ Deliver production-ready Postman collections for your team

## 📋 Prerequisites

### Required Knowledge
- Basic understanding of HTTP protocols
- Familiarity with JSON data format
- Basic command line usage on macOS

### System Requirements
- **macOS Intel** (as specified)
- **Node.js v16+** (for Newman CLI)
- **Homebrew** (for easy installation)

### RESTful API Fundamentals
- **REST** = REpresentational State Transfer
- **HTTP Methods**: GET (read), POST (create), PUT (update), DELETE (remove)
- **Status Codes**: 200 (OK), 201 (Created), 404 (Not Found), 500 (Server Error)
- **JSON Structure**: Key-value pairs, arrays, nested objects

## 🗂️ Course Structure

### [Lesson 1: Postman Installation and Setup](docs/lesson-01-installation.md)
- Install Postman on macOS Intel
- Understand the Postman interface
- Create your first workspace

### [Lesson 2: Understanding RESTful APIs](docs/lesson-02-rest-apis.md)
- Learn ReqRes API endpoints
- Understand request/response structure
- Master HTTP methods and status codes

### [Lesson 3: Your First API Request](docs/lesson-03-first-request.md)
- Send your first GET request
- Analyze response structure
- Understand response time and headers

### [Lesson 4: Writing Test Assertions](docs/lesson-04-assertions.md)
- Master response body validation
- Write status code tests
- Create comprehensive test suites

### [Lesson 5: Organizing Postman Collections](docs/lesson-05-collections.md)
- Structure collections with folders
- Use variables and environments
- Export collections for sharing

### [Lesson 6: Newman CLI Setup](docs/lesson-06-newman-cli.md)
- Install Newman and HTML reporters
- Understand command structure
- Run basic collection tests

### [Lesson 7: HTML Reports and Automation](docs/lesson-07-html-reports.md)
- Generate professional HTML reports
- Automate test execution
- Schedule and monitor API tests

## 🚀 Quick Start

1. **Clone this repository:**
   ```bash
   git clone https://github.com/deeptshuk/testing-learner.git
   cd testing-learner
   ```

2. **Install Postman:**
   ```bash
   brew install --cask postman
   ```

3. **Install Newman CLI:**
   ```bash
   npm install -g newman newman-reporter-htmlextra
   ```

4. **Import the sample collection:**
   - Open Postman
   - File → Import → Choose `collections/reqres-database-tester-collection.json`

5. **Run your first Newman test:**
   ```bash
   newman run collections/reqres-database-tester-collection.json -r htmlextra --reporter-htmlextra-export test-report.html
   ```

## 📁 Repository Structure

```
testing-learner/
├── README.md                          # This file
├── docs/                              # Detailed lesson documentation
│   ├── lesson-01-installation.md
│   ├── lesson-02-rest-apis.md
│   ├── lesson-03-first-request.md
│   ├── lesson-04-assertions.md
│   ├── lesson-05-collections.md
│   ├── lesson-06-newman-cli.md
│   └── lesson-07-html-reports.md
├── collections/                       # Ready-to-use Postman collections
│   └── reqres-database-tester-collection.json
├── environments/                      # Environment configuration files
│   ├── development.json
│   └── production.json
├── scripts/                          # Automation scripts
│   └── run-api-tests.sh
└── examples/                         # Sample reports and outputs
    ├── sample-html-report.html
    └── newman-output-example.txt
```

## 🎯 Deliverable: Production-Ready Collection

The main deliverable is a comprehensive Postman collection (`collections/reqres-database-tester-collection.json`) that includes:

- **15+ API test requests** covering CRUD operations
- **50+ automated assertions** for thorough validation
- **Organized folder structure** for easy navigation
- **Environment variables** for different testing environments
- **Newman CLI compatibility** for automation

### Collection Features:
- ✅ User Management (GET, POST, PUT, DELETE)
- ✅ Authentication (Register, Login)
- ✅ Error Handling (404, 400 responses)
- ✅ Performance Testing (Response time validation)
- ✅ Edge Cases (Invalid data, timeouts)

## 🛠️ Key Commands Reference

### Newman CLI Commands
```bash
# Basic collection run
newman run collection.json

# Generate HTML report
newman run collection.json -r htmlextra --reporter-htmlextra-export report.html

# Run with environment
newman run collection.json -e environment.json

# Multiple iterations
newman run collection.json -n 3

# With delays for stability
newman run collection.json --delay-request 1000
```

### Essential Postman Test Patterns
```javascript
// Status code validation
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// Response body validation
pm.test("Response has required fields", function () {
    const json = pm.response.json();
    pm.expect(json).to.have.property('data');
});

// Response time validation
pm.test("Response time is acceptable", function () {
    pm.expect(pm.response.responseTime).to.be.below(1000);
});
```

## 🎓 Learning Path Recommendations

### Beginner (Week 1)
- Complete Lessons 1-3
- Practice basic GET/POST requests
- Understand response structure

### Intermediate (Week 2)
- Complete Lessons 4-5
- Write comprehensive test assertions
- Organize collections with folders

### Advanced (Week 3)
- Complete Lessons 6-7
- Master Newman CLI automation
- Generate and analyze HTML reports

### Expert (Week 4)
- Customize collections for your APIs
- Integrate with CI/CD pipelines
- Create advanced test scenarios

## 🔧 Troubleshooting

### Common Issues

**Postman Installation:**
```bash
# If Homebrew installation fails
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cask postman
```

**Newman CLI Issues:**
```bash
# Node.js version check
node --version  # Should be v16+

# Reinstall Newman
npm uninstall -g newman
npm install -g newman newman-reporter-htmlextra
```

**Permission Errors:**
```bash
# Fix npm permissions
sudo chown -R $(whoami) ~/.npm
```

## 📚 Additional Resources

- [Postman Official Documentation](https://learning.postman.com/)
- [Newman CLI Documentation](https://github.com/postmanlabs/newman)
- [ReqRes API Documentation](https://reqres.in/)
- [Chai.js Assertion Library](https://www.chaijs.com/)

## 🤝 Contributing

Found an issue or want to improve the guide? Feel free to:
1. Fork this repository
2. Create a feature branch
3. Submit a pull request

## 📞 Support

If you encounter any issues while following this guide:
1. Check the troubleshooting section above
2. Review the specific lesson documentation
3. Open an issue in this repository

## 📄 License

This learning guide is created for educational purposes. All code examples and collections are free to use and modify.

---

**Happy API Testing! 🚀**

*Created specifically for database testers transitioning to API testing with Postman and Newman CLI automation.*