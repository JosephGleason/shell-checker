#!/bin/bash

# Color codes
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

# Path to your compiled shell executable
SHELL_EXEC=../holbertonschool-simple_shell/hsh

# Check if your shell binary exists
if [ ! -x "$SHELL_EXEC" ]; then
    echo -e "${RED}Error: $SHELL_EXEC not found or not executable${NC}"
    exit 1
fi

# Create a unique clean test environment in /tmp
TEST_DIR=$(mktemp -d /tmp/shell_test_XXXXXX)
cp "$SHELL_EXEC" "$TEST_DIR/hsh"
cd "$TEST_DIR" || exit 1

#############################################
# Task 2: /bin/ls non-interactive
#############################################
echo "/bin/ls" | ./hsh > .shell_output.txt
/bin/ls > .expected_output.txt

if diff .shell_output.txt .expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 2: PASS${NC}"
else
    echo -e "${RED}Task 2: FAIL${NC}"
    diff .shell_output.txt .expected_output.txt
fi
#############################################
# Task 3: /bin/echo hello world
#############################################
echo "/bin/echo hello world" | ./hsh > shell_output.txt
/bin/echo hello world > .expected_output.txt

if diff shell_output.txt .expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 3: PASS${NC}"
else
    echo -e "${RED}Task 3: FAIL${NC}"
    diff shell_output.txt .expected_output.txt
fi

#############################################
# Task 4: PATH-resolved ls
#############################################
echo "ls" | ./hsh > shell_output.txt
ls > expected_output.txt

if diff shell_output.txt expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 4: PASS${NC}"
else
    echo -e "${RED}Task 4: FAIL${NC}"
    diff shell_output.txt expected_output.txt
fi

#############################################
# Task 5: Built-in exit
#############################################
echo "exit" | ./hsh
status=$?

if [ $status -eq 0 ]; then
    echo -e "${GREEN}Task 5: PASS${NC}"
else
    echo -e "${RED}Task 5: FAIL (exit status: $status)${NC}"
fi

#############################################
# Task 6: Built-in env
#############################################
echo "env" | ./hsh > shell_output.txt
env > expected_output.txt

grep -v "^_=" shell_output.txt > tmp_shell.txt
grep -v "^_=" expected_output.txt > tmp_expected.txt

if diff tmp_shell.txt tmp_expected.txt > /dev/null; then
    echo -e "${GREEN}Task 6: PASS${NC}"
else
    echo -e "${RED}Task 6: FAIL${NC}"
    diff tmp_shell.txt tmp_expected.txt
fi

#############################################
# Task 7: Handle EOF (Ctrl+D)
#############################################
./hsh < /dev/null > shell_output.txt
status=$?

if [ $status -eq 0 ]; then
    echo -e "${GREEN}Task 7: PASS${NC}"
else
    echo -e "${RED}Task 7: FAIL (exit status: $status)${NC}"
fi

#############################################
# Task 8: Invalid command error
#############################################
echo "badcommand" | ./hsh > shell_output.txt 2>&1

if grep -q "not found" shell_output.txt; then
    echo -e "${GREEN}Task 8: PASS${NC}"
else
    echo -e "${RED}Task 8: FAIL (no error for invalid command)${NC}"
    cat shell_output.txt
fi

#############################################
# Cleanup
#############################################
cd /
rm -rf "$TEST_DIR"
