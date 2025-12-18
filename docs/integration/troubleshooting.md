# Troubleshooting

**Purpose:** Common integration issues and solutions  
**Status:** ✅ Complete  
**Last Updated:** 2025-01-27

---

## 🎯 Overview

This guide covers common issues encountered when integrating dev-infra templates and provides solutions and debugging techniques.

### What You'll Learn
- Common integration problems
- Debugging techniques
- Error resolution strategies
- Prevention best practices

---

## 🚨 Common Issues

### Download Issues

**Issue: Download fails with network error**
```bash
# Symptoms
curl: (7) Failed to connect to github.com port 443: Connection refused
```

**Solutions:**
```bash
# Check network connectivity
ping github.com

# Test HTTPS connection
curl -I https://github.com

# Use different DNS
nslookup github.com 8.8.8.8

# Check firewall/proxy settings
curl --proxy http://proxy:port https://github.com
```

**Issue: Download fails with SSL error**
```bash
# Symptoms
curl: (60) SSL certificate problem: unable to get local issuer certificate
```

**Solutions:**
```bash
# Update certificates (Ubuntu/Debian)
sudo apt-get update && sudo apt-get install ca-certificates

# Update certificates (macOS)
brew install ca-certificates

# Skip SSL verification (not recommended for production)
curl -k -L "https://github.com/grimm00/dev-infra/archive/v0.1.0.tar.gz"
```

**Issue: Download fails with 404 error**
```bash
# Symptoms
curl: (22) The requested URL returned error: 404
```

**Solutions:**
```bash
# Verify version exists
curl -s "https://api.github.com/repos/grimm00/dev-infra/releases" | grep '"tag_name"'

# Check for typos in version
echo "Checking version: v0.1.0"

# Use latest version
LATEST=$(curl -s "https://api.github.com/repos/grimm00/dev-infra/releases/latest" | grep '"tag_name"' | sed -E 's/.*"v([^"]+)".*/\1/')
echo "Latest version: v${LATEST}"
```

### Extraction Issues

**Issue: tar extraction fails**
```bash
# Symptoms
tar: Error is not recoverable: exiting now
```

**Solutions:**
```bash
# Check file integrity
file dev-infra-0.1.0.tar.gz

# Test archive
tar -tzf dev-infra-0.1.0.tar.gz | head -10

# Check disk space
df -h

# Check permissions
ls -la dev-infra-0.1.0.tar.gz
```

**Issue: Permission denied during extraction**
```bash
# Symptoms
tar: ./templates: Cannot mkdir: Permission denied
```

**Solutions:**
```bash
# Check directory permissions
ls -la ./templates/

# Fix permissions
chmod 755 ./templates/

# Use sudo if necessary (not recommended)
sudo chown -R $USER:$USER ./templates/
```

### Template Issues

**Issue: Templates not found after extraction**
```bash
# Symptoms
ls: cannot access './templates/dev-infra/': No such file or directory
```

**Solutions:**
```bash
# Check extraction path
find /tmp -name "dev-infra-*" -type d

# Verify template structure
ls -la /tmp/dev-infra-0.1.0/templates/

# Check copy command
cp -r "/tmp/dev-infra-0.1.0/templates/"* "./templates/"
```

**Issue: Template validation fails**
```bash
# Symptoms
./scripts/validate-templates.sh: line 1: ./scripts/validate-templates.sh: Permission denied
```

**Solutions:**
```bash
# Make script executable
chmod +x ./scripts/validate-templates.sh

# Check script location
which ./scripts/validate-templates.sh

# Run with bash explicitly
bash ./scripts/validate-templates.sh
```

### Version Issues

**Issue: Version mismatch**
```bash
# Symptoms
Current version: 0.0.0
Latest version: 0.1.0
```

**Solutions:**
```bash
# Check version file
cat ./templates/dev-infra/.version

# Re-download templates
./scripts/download-devinfra.sh 0.1.0

# Verify version file
echo "0.1.0" > ./templates/dev-infra/.version
```

**Issue: Version check fails**
```bash
# Symptoms
curl: (22) The requested URL returned error: 404
```

**Solutions:**
```bash
# Check API endpoint
curl -s "https://api.github.com/repos/grimm00/dev-infra/releases"

# Use alternative method
curl -s "https://api.github.com/repos/grimm00/dev-infra/tags" | grep '"name"'
```

---

## 🔧 Debugging Techniques

### Enable Debug Mode

**Bash Debug Mode:**
```bash
#!/bin/bash
# Enable debug mode
set -x  # Enable debug output
set -e  # Exit on error

# Your script here
```

**Verbose Download:**
```bash
# Verbose curl output
curl -L -v "https://github.com/grimm00/dev-infra/archive/v0.1.0.tar.gz" -o dev-infra.tar.gz

# Check download progress
curl -L --progress-bar "https://github.com/grimm00/dev-infra/archive/v0.1.0.tar.gz" -o dev-infra.tar.gz
```

**File System Debug:**
```bash
# Check file permissions
ls -la ./templates/dev-infra/

# Check disk usage
du -sh ./templates/dev-infra/

# Check file types
file ./templates/dev-infra/README.md
```

### Logging and Monitoring

**Add Logging to Scripts:**
```bash
#!/bin/bash
# Add logging to your scripts

LOG_FILE="./logs/dev-infra-$(date +%Y%m%d).log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting dev-infra download"
# Your script logic here
log "Download completed successfully"
```

**Monitor System Resources:**
```bash
# Monitor disk usage
watch -n 1 'df -h'

# Monitor network usage
watch -n 1 'netstat -i'

# Monitor process usage
top -p $(pgrep -f "dev-infra")
```

---

## 🛠️ Error Resolution Strategies

### Network Issues

**Problem: Intermittent network failures**
```bash
# Solution: Retry logic
download_with_retry() {
    local url="$1"
    local output="$2"
    local max_attempts=3
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -L "$url" -o "$output"; then
            echo "Download successful on attempt $attempt"
            return 0
        else
            echo "Download failed on attempt $attempt"
            attempt=$((attempt + 1))
            sleep 5
        fi
    done
    
    echo "Download failed after $max_attempts attempts"
    return 1
}
```

**Problem: Slow downloads**
```bash
# Solution: Parallel downloads
download_parallel() {
    local url="$1"
    local output="$2"
    
    # Use aria2c for parallel downloads
    aria2c -x 16 -s 16 "$url" -o "$output"
    
    # Or use wget with multiple connections
    wget --progress=bar:force -O "$output" "$url"
}
```

### File System Issues

**Problem: Insufficient disk space**
```bash
# Solution: Check space before download
check_disk_space() {
    local required_space="100M"  # Adjust as needed
    local available_space=$(df -h . | awk 'NR==2 {print $4}')
    
    if [ "$available_space" -lt "$required_space" ]; then
        echo "Error: Insufficient disk space. Required: $required_space, Available: $available_space"
        return 1
    fi
}
```

**Problem: Permission issues**
```bash
# Solution: Check and fix permissions
fix_permissions() {
    local target_dir="$1"
    
    # Check if directory exists and is writable
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi
    
    if [ ! -w "$target_dir" ]; then
        echo "Error: Directory $target_dir is not writable"
        return 1
    fi
}
```

### Version Management Issues

**Problem: Version conflicts**
```bash
# Solution: Version validation
validate_version() {
    local version="$1"
    
    # Check if version follows semantic versioning
    if [[ ! "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Error: Invalid version format: $version"
        return 1
    fi
    
    # Check if version exists
    if ! curl -s "https://api.github.com/repos/grimm00/dev-infra/releases" | grep -q "\"v$version\""; then
        echo "Error: Version v$version does not exist"
        return 1
    fi
}
```

---

## 🚀 Prevention Best Practices

### Pre-Download Checks

**Check Prerequisites:**
```bash
#!/bin/bash
# check-prerequisites.sh

check_prerequisites() {
    # Check if curl is installed
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is not installed"
        return 1
    fi
    
    # Check if tar is installed
    if ! command -v tar &> /dev/null; then
        echo "Error: tar is not installed"
        return 1
    fi
    
    # Check network connectivity
    if ! ping -c 1 github.com &> /dev/null; then
        echo "Error: Cannot reach github.com"
        return 1
    fi
    
    # Check disk space
    if ! check_disk_space; then
        return 1
    fi
    
    echo "All prerequisites met"
    return 0
}
```

### Error Handling

**Comprehensive Error Handling:**
```bash
#!/bin/bash
# Comprehensive error handling

set -e  # Exit on error
set -u  # Exit on undefined variable
set -o pipefail  # Exit on pipe failure

# Error handler
error_handler() {
    local line_number="$1"
    local error_code="$2"
    echo "Error occurred at line $line_number with exit code $error_code"
    # Cleanup code here
    exit "$error_code"
}

trap 'error_handler ${LINENO} $?' ERR

# Your script logic here
```

### Validation

**Template Validation:**
```bash
#!/bin/bash
# validate-templates.sh

validate_templates() {
    local template_dir="$1"
    
    # Check if template directory exists
    if [ ! -d "$template_dir" ]; then
        echo "Error: Template directory does not exist: $template_dir"
        return 1
    fi
    
    # Check for required files
    local required_files=("README.md" "start.txt" ".gitignore")
    for file in "${required_files[@]}"; do
        if [ ! -f "$template_dir/$file" ]; then
            echo "Error: Required file missing: $file"
            return 1
        fi
    done
    
    # Check for required directories
    local required_dirs=("admin" "backend" "frontend")
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$template_dir/$dir" ]; then
            echo "Error: Required directory missing: $dir"
            return 1
        fi
    done
    
    echo "Template validation passed"
    return 0
}
```

---

## 📋 Troubleshooting Checklist

### Before Integration
- [ ] Check network connectivity
- [ ] Verify required tools (curl, tar, git)
- [ ] Check disk space
- [ ] Verify permissions
- [ ] Test download manually

### During Integration
- [ ] Monitor download progress
- [ ] Check extraction success
- [ ] Verify template structure
- [ ] Test template validation
- [ ] Check file permissions

### After Integration
- [ ] Test project generation
- [ ] Verify file customization
- [ ] Check git initialization
- [ ] Test update mechanism
- [ ] Monitor for errors

### Ongoing Maintenance
- [ ] Monitor for new releases
- [ ] Test updates in development
- [ ] Check for breaking changes
- [ ] Update documentation
- [ ] Gather user feedback

---

## 🔗 Related Documentation

- **[Version-Pinned Downloads](version-pinned.md)** - Detailed version-pinned approach
- **[Dev-Toolkit Integration](dev-toolkit.md)** - Specific dev-toolkit examples
- **[Best Practices](best-practices.md)** - Integration best practices

---

**Last Updated:** 2025-01-27  
**Status:** ✅ Complete  
**Next:** [Best Practices](best-practices.md)
