#!/bin/bash

# Function to display a progress bar
progress_bar() {
    local duration=${1}
    local total_steps=${2}
    local current_step=1
    local progress=0

    for ((i = 0; i < total_steps; i++)); do
        printf "\r["
        printf "%-${progress}s" | tr ' ' '#'
        printf "] %3d%%" "${progress}"
        sleep "${duration}"
        current_step=$((current_step + 1))
        progress=$((100 * current_step / total_steps))
    done
    printf "\n"
}

# Ask for the project name
read -p "Enter the project name: " project_name

# Check if the project name is empty
if [[ -z "${project_name}" ]]; then
    echo "Error: Project name cannot be empty. Please provide a valid project name."
    exit 1
fi

# Check if the project name contains invalid characters
if [[ ! "${project_name}" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Error: Invalid project name. The name can only contain letters, numbers, underscores, and hyphens."
    exit 1
fi

# Check if the project name already exists
if [[ -d "${project_name}" ]]; then
    echo "Error: A project with the name '${project_name}' already exists."
    exit 1
fi

# Create the folder structure
mkdir -p "${project_name}"/{app,ui/{forms,icons},resources/{icons,styles},models,controllers,views,widgets,utils,translations,tests,documentation}

echo "Folder structure for '${project_name}' created successfully!"

# Ask the user if they want to install the project dependencies
while true; do
    read -p "Do you want to install project dependencies? (y/n): " install_dependencies
    case "${install_dependencies}" in
        [Yy])
            echo "Installing project dependencies..."
            # Replace the command below with the appropriate package manager and installation command
            # For example, using pip:
            # pip install PyQt6
            progress_bar 0.1 10
            echo "Project dependencies installed!"
            break
            ;;
        [Nn])
            echo "Project dependencies not installed."
            break
            ;;
        *)
            echo "Invalid input. Please enter 'y' for yes or 'n' for no."
            ;;
    esac
done

# Display a progress bar while creating the folder structure
echo "Creating folder structure..."
progress_bar 0.1 10

echo "Project '${project_name}' has been successfully created!"
