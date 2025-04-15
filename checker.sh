#!/bin/bash
# Define color codes for terminal output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No Color

# Path to your shell executable
# CHANGE hsh TO WHATEVER YOUR EXECUTABLE IS CALLED WHEN YOU GCC
SHELL_EXEC=../holbertonschool-simple_shell/hsh

# Check if the shell exists and is executable
if [ ! -x "$SHELL_EXEC" ]; then
    echo -e "${RED}Error: $SHELL_EXEC not found or not executable${NC}"
    exit 1
fi

#############################################
# Task 2: Execute /bin/ls in non-interactive mode
#############################################
echo "/bin/ls" | $SHELL_EXEC > my_output.txt
/bin/ls > expected_output.txt

if diff my_output.txt expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 2: PASS${NC}"
else
    echo -e "${RED}Task 2: FAIL${NC}"
    diff my_output.txt expected_output.txt
fi

#############################################
# Task 3: Execute /bin/echo with arguments
#############################################
echo "/bin/echo hello world" | $SHELL_EXEC > my_output.txt
/bin/echo hello world > expected_output.txt

if diff my_output.txt expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 3: PASS${NC}"
else
    echo -e "${RED}Task 3: FAIL${NC}"
    diff my_output.txt expected_output.txt
fi

#############################################
# Task 4: Use PATH to resolve command (e.g. ls)
#############################################
echo "ls" | $SHELL_EXEC > my_output.txt
ls > expected_output.txt

if diff my_output.txt expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 4: PASS${NC}"
else
    echo -e "${RED}Task 4: FAIL${NC}"
    diff my_output.txt expected_output.txt
fi

#############################################
# Task 5: Built-in 'exit' command
#############################################
echo "exit" | $SHELL_EXEC
status=$?

if [ $status -eq 0 ]; then
    echo -e "${GREEN}Task 5: PASS${NC}"
else
    echo -e "${RED}Task 5: FAIL (exit status: $status)${NC}"
fi

#############################################
# Task 6: Built-in 'env' command
#############################################
echo "env" | $SHELL_EXEC > my_output.txt
env > expected_output.txt

if diff my_output.txt expected_output.txt > /dev/null; then
    echo -e "${GREEN}Task 6: PASS${NC}"
else
    echo -e "${RED}Task 6: FAIL${NC}"
    diff my_output.txt expected_output.txt
fi

#############################################
# Task 7: Handle EOF (Ctrl+D) with no input
#############################################
$SHELL_EXEC < /dev/null > my_output.txt
status=$?

if [ $status -eq 0 ]; then
    echo -e "${GREEN}Task 7: PASS${NC}"
else
    echo -e "${RED}Task 7: FAIL (exit status: $status)${NC}"
fi

#############################################
# Task 8: Invalid command should show error
#############################################
echo "garbagecommand" | $SHELL_EXEC > my_output.txt 2>&1

if grep -q "not found" my_output.txt; then
    echo -e "${GREEN}Task 8: PASS${NC}"
else
    echo -e "${RED}Task 8: FAIL (no error message for invalid command)${NC}"
    cat my_output.txt
fi

#############################################
# Optional: Clean up temporary files
#############################################
rm -f my_output.txt expected_output.txt

