#!/bin/bash

# Get the absolute path of the root directory
root_dir=$(pwd)

# Get a list of all the package directories
package_dirs=$(find Packages -type d -mindepth 1 -maxdepth 1)

# Iterate over each package directory
for package_dir in $package_dirs; do
    # Get the package name from the directory name
    package_name=$(basename $package_dir)
    
    # Print the package name as a header
    echo "Running tests for package: $package_name"
    
    # Change to the package directory
    cd $package_dir/.swiftpm/xcode/

    SCHEME=$package_name-Package

    # Check if scheme exists from the `package.xcworkspace`
    if ! xcodebuild -list -workspace package.xcworkspace | grep -q $package_name-Package; then
        # If not, use the package name as the scheme
        SCHEME=$package_name
    fi

    # Build and run the package tests
    xcodebuild test -scheme $SCHEME -destination 'platform=iOS Simulator,name=iPhone 14 Pro'
    
    # Return to the root directory
    cd $root_dir
    
    # Print a blank line for separation
    echo
done
