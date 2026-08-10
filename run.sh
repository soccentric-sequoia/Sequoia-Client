#!/bin/bash
set -e

# Sequoia-Client Development Run Script
# Creates necessary directories and runs the client with development config

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Sequoia-Client Development Run ===${NC}"

# Kill any existing sequoia-client processes
echo -e "${BLUE}Checking for existing sequoia-client processes...${NC}"
if pgrep -x "sequoia-client" > /dev/null; then
    echo -e "${YELLOW}Found running sequoia-client process(es). Terminating...${NC}"
    pkill -SIGTERM sequoia-client || true
    sleep 1
    
    # Force kill if still running
    if pgrep -x "sequoia-client" > /dev/null; then
        echo -e "${YELLOW}Process still running, force killing...${NC}"
        pkill -SIGKILL sequoia-client || true
        sleep 1
    fi
    echo -e "${GREEN}✓ All sequoia-client processes terminated${NC}"
else
    echo -e "${GREEN}✓ No existing processes found${NC}"
fi

# Clean up stale socket files and locks
echo -e "${BLUE}Cleaning up stale sockets and locks...${NC}"
rm -f /tmp/sequoia-diag.sock 2>/dev/null || true
rm -f ./data/spool/spool.db-shm 2>/dev/null || true
rm -f ./data/spool/spool.db-wal 2>/dev/null || true
echo -e "${GREEN}✓ Cleanup complete${NC}"

# Create necessary directories
echo -e "${BLUE}Creating required directories...${NC}"
mkdir -p ./data/spool
mkdir -p ./data/logs
mkdir -p /tmp/sequoia 2>/dev/null || true
echo -e "${GREEN}✓ Directories ready${NC}"

# Check if binary exists
if [ ! -f "./build/bin/sequoia-client" ]; then
    echo -e "${RED}ERROR: Binary not found at ./build/bin/sequoia-client${NC}"
    echo "Please build the project first:"
    echo "  make build"
    echo "  OR: cd build && cmake --build . --parallel"
    exit 1
fi

# Check if dev config exists
if [ ! -f "./conf/client.conf.dev" ]; then
    echo -e "${RED}ERROR: Development config not found at ./conf/client.conf.dev${NC}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Starting sequoia-client with debug logging...${NC}"
echo "Config: ./conf/client.conf.dev"
echo "Spool:  ./data/spool/spool.db"
echo "Press Ctrl+C to stop"
echo ""

# Set up trap to clean up on exit
cleanup() {
    echo ""
    echo -e "${YELLOW}Caught signal, cleaning up...${NC}"
    pkill -SIGTERM sequoia-client 2>/dev/null || true
    sleep 1
    rm -f /tmp/sequoia-diag.sock 2>/dev/null || true
    echo -e "${GREEN}✓ Cleanup complete${NC}"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Run with debug logging
SPDLOG_LEVEL=debug ./build/bin/sequoia-client --config ./conf/client.conf.dev