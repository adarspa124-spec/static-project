# Stage 1: Use official lightweight Python image
FROM python:3.11-slim AS base

# Set working directory inside container
WORKDIR /app

# Copy all project files from repo to container
COPY . .

# Expose port 8085 (same as Jenkins pipeline)
EXPOSE 8085

# Default command to start Python HTTP server
CMD ["python", "-m", "http.server", "8085"]
