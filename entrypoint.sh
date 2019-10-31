#!/bin/bash
set -e

# Remove any pre-existing server.pid for Rails.
rm -f /password/tmp/pids/server.pid

# Then exec the container
exec "$@"