#!/bin/bash

# Test script for postgres-sample-dbs
# This script creates databases, loads data, runs example queries, and cleans up

# Don't exit on error - we want to see all results
set +e

# Function to show help
show_help() {
    cat << EOF
Usage: ./test_databases.sh [OPTIONS] [database_name]

Test PostgreSQL sample databases by creating, loading, querying, and cleaning up.

OPTIONS:
    --all           Test all databases
    --debug         Enable debug output
    --help, -h      Show this help message

DATABASES:
    periodic_table      Periodic table of elements (smallest, ~17 KB)
    world_happiness     World Happiness Index data
    titanic             Titanic passenger data
    netflix             Netflix movies and TV shows
    dvdrental           DVD rental tutorial database
    pagila              DVD rental store (Pagila)
    chinook             Digital media store (Chinook)
    lego                LEGO sets database
    employees           Employee records (largest, ~34 MB, uses pg_restore)

EXAMPLES:
    ./test_databases.sh periodic_table          # Test one database
    ./test_databases.sh --all                   # Test all databases
    ./test_databases.sh periodic_table --debug  # Test with debug output
    DEBUG=1 ./test_databases.sh --all          # Test all with debug via env var

ENVIRONMENT:
    DB_CONNECTION       Set database connection string manually
    DEBUG               Set to 1 to enable debug mode

The script will automatically get a database connection using 'npx get-db' if
DATABASE_URL is not found in .env file.

EOF
}

# Check for flags and database name
DEBUG_MODE=0
SPECIFIC_DB=""
RUN_ALL=0

if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

for arg in "$@"; do
    case "$arg" in
        --help|-h)
            show_help
            exit 0
            ;;
        --debug)
            DEBUG_MODE=1
            ;;
        --all)
            RUN_ALL=1
            ;;
        -*)
            echo "Unknown option: $arg"
            echo "Use --help for usage information"
            exit 1
            ;;
        *)
            if [ -z "$SPECIFIC_DB" ]; then
                SPECIFIC_DB="$arg"
            else
                echo "Error: Multiple database names specified"
                echo "Use --help for usage information"
                exit 1
            fi
            ;;
    esac
done

# Validate that --all and specific database are not both specified
if [ $RUN_ALL -eq 1 ] && [ -n "$SPECIFIC_DB" ]; then
    echo "Error: Cannot specify both --all and a specific database name"
    exit 1
fi

# Check if both flags are missing (should have been caught above, but just in case)
if [ $RUN_ALL -eq 0 ] && [ -z "$SPECIFIC_DB" ]; then
    show_help
    exit 0
fi

# Also check DEBUG environment variable
if [ -n "$DEBUG" ]; then
    DEBUG_MODE=1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print debug output
debug() {
    if [ $DEBUG_MODE -eq 1 ]; then
        echo -e "${BLUE}[DEBUG]${NC} $1"
    fi
}

# Configuration
# Get database connection using npx get-db or from .env file
if [ -z "$DB_CONNECTION" ]; then
    # First, check if .env file exists and has DATABASE_URL
    if [ -f ".env" ] && grep -q "DATABASE_URL" ".env"; then
        echo "Found existing DATABASE_URL in .env file..."
        # Extract DATABASE_URL, remove quotes, and trim whitespace
        DB_CONNECTION=$(grep "^DATABASE_URL" .env | head -1 | cut -d '=' -f2- | sed 's/^["\x27 ]*//' | sed 's/["\x27 ]*$//' | tr -d '\r\n')
    else
        echo "Getting database connection via npx get-db..."
        npx --yes get-db --yes >/dev/null 2>&1
        
        if [ -f ".env" ] && grep -q "DATABASE_URL" ".env"; then
            DB_CONNECTION=$(grep "^DATABASE_URL" .env | head -1 | cut -d '=' -f2- | sed 's/^["\x27 ]*//' | sed 's/["\x27 ]*$//' | tr -d '\r\n')
        else
            echo -e "${RED}Failed to get database connection via npx get-db${NC}"
            echo "Please ensure you have npx installed or set DB_CONNECTION manually:"
            echo "export DB_CONNECTION='postgres://user:password@hostname/dbname'"
            exit 1
        fi
    fi
    
    # Remove the database name from the connection string if present
    DB_CONNECTION=$(echo "$DB_CONNECTION" | sed 's|/[^/]*$||')
    
    echo -e "${GREEN}✓ Database connection obtained${NC}"
    echo "Base connection: $DB_CONNECTION"
fi

# Directory where SQL files are located (current directory by default)
SQL_DIR="."

# Test counter
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    if [ "$status" == "PASS" ]; then
        echo -e "${GREEN}✓ PASS${NC}: $message"
        ((PASSED_TESTS++))
    elif [ "$status" == "FAIL" ]; then
        echo -e "${RED}✗ FAIL${NC}: $message"
        ((FAILED_TESTS++))
    elif [ "$status" == "INFO" ]; then
        echo -e "${YELLOW}ℹ INFO${NC}: $message"
    fi
    ((TOTAL_TESTS++))
}

# Function to create and test a database
test_database() {
    local db_name=$1
    local sql_file=$2
    local test_query=$3
    local load_type=${4:-"psql"}  # psql or pg_restore
    
    echo ""
    echo "=========================================="
    echo "Testing: $db_name"
    echo "=========================================="
    debug "db_name=$db_name"
    debug "sql_file=$sql_file"
    debug "load_type=$load_type"
    
    # Create database
    echo "Creating database: $db_name"
    
    # First, try to drop if it exists (to avoid the "already exists" issue)
    echo "Checking for existing database..."
    # Terminate any active connections to the database
    psql "${DB_CONNECTION}/postgres" -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '${db_name}' AND pid <> pg_backend_pid();" >/dev/null 2>&1
    # Now drop the database
    psql "${DB_CONNECTION}/postgres" -c "DROP DATABASE IF EXISTS ${db_name};" 2>&1 | grep -v "does not exist" || true
    
    echo "Creating new database..."
    if psql "${DB_CONNECTION}/postgres" -c "CREATE DATABASE ${db_name};"; then
        print_status "PASS" "Database $db_name created"
    else
        print_status "FAIL" "Could not create database $db_name"
        return 1
    fi
    
    debug "Database created successfully, continuing..."
    
    # Load data
    echo "Loading data from $sql_file..."
    if [ "$load_type" == "pg_restore" ]; then
        if pg_restore -d "${DB_CONNECTION}/${db_name}" -Fc "${SQL_DIR}/${sql_file}" --no-owner --no-privileges 2>&1; then
            print_status "PASS" "Data loaded via pg_restore"
        else
            print_status "FAIL" "Failed to load data via pg_restore"
            return 1
        fi
    else
        LOAD_OUTPUT=$(psql -d "${DB_CONNECTION}/${db_name}" -f "${SQL_DIR}/${sql_file}" 2>&1)
        LOAD_RESULT=$?
        if [ $DEBUG_MODE -eq 1 ]; then
            echo "Load output (last 5 lines):"
            echo "$LOAD_OUTPUT" | tail -5
        fi
        if [ $LOAD_RESULT -eq 0 ]; then
            print_status "PASS" "Data loaded via psql"
        else
            print_status "FAIL" "Failed to load data via psql"
            echo "Full error output:"
            echo "$LOAD_OUTPUT"
            return 1
        fi
    fi
    
    # Run test query
    echo "Running test query..."
    if [ $DEBUG_MODE -eq 1 ]; then
        echo "Query: $test_query"
        echo ""
    fi
    if result=$(psql "${DB_CONNECTION}/${db_name}" -c "$test_query" 2>&1); then
        if [ -n "$result" ]; then
            print_status "PASS" "Test query executed successfully"
            echo ""
            echo "Query results:"
            echo "$result"
            echo ""
        else
            print_status "FAIL" "Test query returned no results"
        fi
    else
        print_status "FAIL" "Test query failed"
        echo "Error: $result"
    fi
    
    # Show database size
    echo "Checking database size..."
    if size_result=$(psql "${DB_CONNECTION}/${db_name}" -t -c "SELECT pg_size_pretty(pg_database_size('${db_name}'));" 2>&1); then
        echo "Database size: $(echo $size_result | tr -d ' ')"
    else
        echo "Could not determine database size"
    fi
    
    # Clean up
    echo "Dropping database: $db_name"
    # First, terminate all connections to the database
    psql "${DB_CONNECTION}/postgres" -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '${db_name}' AND pid <> pg_backend_pid();" >/dev/null 2>&1
    # Now drop the database
    if psql "${DB_CONNECTION}/postgres" -c "DROP DATABASE ${db_name};"; then
        print_status "PASS" "Database $db_name dropped"
    else
        print_status "FAIL" "Failed to drop database $db_name"
    fi
}

echo "=========================================="
if [ $RUN_ALL -eq 1 ]; then
    echo "Testing All Databases"
else
    echo "Testing Single Database: $SPECIFIC_DB"
fi
echo "=========================================="
echo "SQL Directory: ${SQL_DIR}"
echo ""

# Helper function to check if we should run a test
should_run_test() {
    local db_name=$1
    if [ $RUN_ALL -eq 1 ] || [ "$SPECIFIC_DB" == "$db_name" ]; then
        return 0
    else
        return 1
    fi
}

# Test 1: Periodic Table
if should_run_test "periodic_table"; then
    test_database "periodic_table" \
        "periodic_table.sql" \
        "SELECT * FROM periodic_table WHERE \"AtomicNumber\" = 10;"
fi

# Test 2: World Happiness Index
if should_run_test "world_happiness"; then
    test_database "world_happiness" \
        "happiness_index.sql" \
        "SELECT country_or_region, score, gdp_per_capita FROM \"2019\" WHERE score > (SELECT AVG(score) FROM \"2019\") AND gdp_per_capita < (SELECT AVG(gdp_per_capita) FROM \"2019\") ORDER BY score DESC LIMIT 5;"
fi

# Test 3: Titanic
if should_run_test "titanic"; then
    test_database "titanic" \
        "titanic.sql" \
        "SELECT name, fare FROM passenger ORDER BY fare DESC LIMIT 10;"
fi

# Test 4: Netflix
if should_run_test "netflix"; then
    test_database "netflix" \
        "netflix.sql" \
        "SELECT director, COUNT(*) AS \"Number of Movies\" FROM netflix_shows WHERE type = 'Movie' AND director IS NOT NULL GROUP BY director ORDER BY \"Number of Movies\" DESC LIMIT 5;"
fi

# Test 5: DVD rental tutorial database
if should_run_test "dvdrental"; then
    test_database "dvdrental" \
        "dvdrental.sql" \
        "SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent FROM customer c JOIN payment p ON c.customer_id = p.customer_id GROUP BY c.customer_id, c.first_name, c.last_name ORDER BY total_spent DESC LIMIT 5;"
fi

# Test 6: Pagila
if should_run_test "pagila"; then
    test_database "pagila" \
        "pagila.sql" \
        "SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count FROM category c JOIN film_category fc ON c.category_id = fc.category_id JOIN inventory i ON fc.film_id = i.film_id JOIN rental r ON i.inventory_id = r.inventory_id GROUP BY c.name ORDER BY rental_count DESC LIMIT 10;"
fi

# Test 7: Chinook
if should_run_test "chinook"; then
    test_database "chinook" \
        "chinook.sql" \
        "SELECT T.\"Name\" AS \"Track Title\", SUM(IL.\"Quantity\") AS \"Total Sold\" FROM \"Track\" T JOIN \"InvoiceLine\" IL ON T.\"TrackId\" = IL.\"TrackId\" GROUP BY T.\"Name\" ORDER BY \"Total Sold\" DESC LIMIT 1;"
fi

# Test 8: Lego
if should_run_test "lego"; then
    test_database "lego" \
        "lego.sql" \
        "SELECT lt.name AS theme_name, COUNT(ls.set_num) AS number_of_sets FROM lego_themes lt JOIN lego_sets ls ON lt.id = ls.theme_id GROUP BY lt.name ORDER BY number_of_sets DESC LIMIT 5;"
fi

# Test 9: Employees (requires pg_restore)
if should_run_test "employees"; then
    test_database "employees" \
        "employees.sql.gz" \
        "SELECT d.dept_name, AVG(s.amount) AS average_salary FROM employees.salary s JOIN employees.department_employee de ON s.employee_id = de.employee_id JOIN employees.department d ON de.department_id = d.id WHERE s.to_date > CURRENT_DATE AND de.to_date > CURRENT_DATE GROUP BY d.dept_name ORDER BY average_salary DESC LIMIT 5;" \
        "pg_restore"
fi

# Check if specific database was valid
if [ -n "$SPECIFIC_DB" ] && [ $TOTAL_TESTS -eq 0 ]; then
    echo -e "${RED}Error: Unknown database '$SPECIFIC_DB'${NC}"
    echo ""
    echo "Available databases:"
    echo "  - periodic_table"
    echo "  - world_happiness"
    echo "  - titanic"
    echo "  - netflix"
    echo "  - dvdrental"
    echo "  - pagila"
    echo "  - chinook"
    echo "  - lego"
    echo "  - employees"
    echo ""
    echo "Use --help for more information"
    exit 1
fi

# Summary
echo ""
echo "=========================================="
echo "Test Summary"
echo "=========================================="
echo "Total tests: $TOTAL_TESTS"
echo -e "${GREEN}Passed: $PASSED_TESTS${NC}"
echo -e "${RED}Failed: $FAILED_TESTS${NC}"
echo "=========================================="

if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}Some tests failed.${NC}"
    exit 1
fi

