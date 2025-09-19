#!/bin/bash

# API Testing Automation Script for Database Testers
# This script runs the complete ReqRes API test suite and generates reports

# Configuration
DATE=$(date +%Y%m%d_%H%M%S)
REPORT_DIR="./test-reports"
COLLECTION="collections/reqres-database-tester-collection.json"
ENV_FILE="environments/production.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🚀 Starting API Test Suite Execution..."
echo "📅 Timestamp: $DATE"
echo "🗂️  Collection: $COLLECTION"
echo "🌍 Environment: $ENV_FILE"
echo ""

# Create reports directory
mkdir -p $REPORT_DIR
echo "📁 Created reports directory: $REPORT_DIR"

# Check if collection file exists
if [ ! -f "$COLLECTION" ]; then
    echo -e "${RED}❌ Collection file not found: $COLLECTION${NC}"
    exit 1
fi

# Check if environment file exists
if [ ! -f "$ENV_FILE" ]; then
    echo -e "${YELLOW}⚠️  Environment file not found: $ENV_FILE. Running without environment.${NC}"
    ENV_PARAM=""
else
    ENV_PARAM="-e $ENV_FILE"
fi

# Check if Newman is installed
if ! command -v newman &> /dev/null; then
    echo -e "${RED}❌ Newman CLI is not installed. Please install it first:${NC}"
    echo "   npm install -g newman newman-reporter-htmlextra"
    exit 1
fi

echo "🔍 Newman version: $(newman --version)"
echo ""

# Run the test suite
echo "🧪 Running API test suite..."
newman run $COLLECTION \
  $ENV_PARAM \
  -r cli,htmlextra,json \
  --reporter-htmlextra-export "$REPORT_DIR/api-test-$DATE.html" \
  --reporter-json-export "$REPORT_DIR/api-test-$DATE.json" \
  --reporter-htmlextra-title "Database Tester API Validation Report - $DATE" \
  --reporter-htmlextra-logs \
  --delay-request 500 \
  --timeout-request 10000

# Check exit code
NEWMAN_EXIT_CODE=$?

echo ""
echo "📊 Test Execution Summary:"
echo "=========================="

if [ $NEWMAN_EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed successfully!${NC}"
    echo "📄 HTML Report: $REPORT_DIR/api-test-$DATE.html"
    echo "📄 JSON Report: $REPORT_DIR/api-test-$DATE.json"

    # Open HTML report automatically (macOS)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "🌐 Opening HTML report in browser..."
        open "$REPORT_DIR/api-test-$DATE.html"
    fi

    # Send success notification (macOS)
    if command -v osascript &> /dev/null; then
        osascript -e "display notification \"All API tests passed successfully!\" with title \"Test Suite Complete\""
    fi

else
    echo -e "${RED}❌ Some tests failed! Exit code: $NEWMAN_EXIT_CODE${NC}"
    echo "📄 Check the reports for details:"
    echo "   HTML: $REPORT_DIR/api-test-$DATE.html"
    echo "   JSON: $REPORT_DIR/api-test-$DATE.json"

    # Send failure notification (macOS)
    if command -v osascript &> /dev/null; then
        osascript -e "display notification \"Some API tests failed. Check the reports.\" with title \"Test Suite Failed\""
    fi
fi

echo ""
echo "🔗 Quick Commands:"
echo "=================="
echo "View HTML report: open $REPORT_DIR/api-test-$DATE.html"
echo "View JSON report: cat $REPORT_DIR/api-test-$DATE.json | jq ."
echo "List all reports: ls -la $REPORT_DIR/"
echo ""

exit $NEWMAN_EXIT_CODE