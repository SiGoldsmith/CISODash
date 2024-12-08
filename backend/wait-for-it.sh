#!/bin/bash

host="$1"
port="$2"
shift 2
cmd="$@"

# Maximum number of attempts
max_attempts=30
attempt=1

until pg_isready -h "$host" -p "$port" -U "postgres" >/dev/null 2>&1; do
    if [ $attempt -ge $max_attempts ]; then
        echo "Could not connect to Postgres after $max_attempts attempts. Starting anyway..."
        break
    fi
    attempt=$((attempt + 1))
    sleep 2
done

# Execute the command
exec $cmd