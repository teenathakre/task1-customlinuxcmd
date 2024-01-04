#!/bin/bash

# Help function to display usage instructions
display_help() {
            echo "Usage: internsctl <command>"
            echo "  help           Show this help message"
            echo "Version: v0.1.0"
            echo "  internsctl cpu getinfo"
            echo "  internsctl memory getinfo"
            echo "  internsctl user create newuser"
            echo "  internsctl user list"
            echo "  internsctl user list --sudo-only"
            echo "  --size, -s            Print size of the file"
            echo "  --permissions, -p     Print file permissions"
            echo "  --owner, -o           Print file owner"
            echo "  --last-modified, -m   Print last modified time of the file"

            }


                        # Function to get CPU information
                        get_file_info() {
                            file="$1"
                                if [ ! -f "$file" ]; then
                                    echo "File '$file' not found."
                                    exit 1
                                fi

                                if [ "$2" == "--size" ] || [ "$2" == "-s" ]; then
                                    stat -c "%s" "$file"
                                    elif [ "$2" == "--permissions" ] || [ "$2" == "-p" ]; then
                                    stat -c "%A" "$file"
                                    elif [ "$2" == "--owner" ] || [ "$2" == "-o" ]; then
                                    stat -c "%U" "$file"
                                                                                                                                                                                                        elif [ "$2" == "--last-modified" ] || [ "$2" == "-m" ]; then

                            stat -c "%y" "$file"

                else

                                echo "Invalid option. Use 'internsctl file getinfo --help' for usage."

                                        exit 1

                                            fi

                                    }
                        get_cpu_info() {
                                    lscpu
                            }

                            # Function to get memory information
                            get_memory_info() {
                                        free -h
                                }
                            # Function to create a new user
                            create_user() {
                                        if [ -z "$1" ]; then
                                                        echo "Please provide a username to create."
                                                                exit 1
                                                                    fi

                                                                        sudo useradd -m "$1"
                                                                            echo "User '$1' created successfully."
                                                                    }

                                                                    # Function to list all regular users
                                                                    list_regular_users() {
                                                                                getent passwd | grep -E '/home/[^:]+:$' | cut -d: -f1
                                                                        }

                                                                        # Function to list users with sudo permissions
                                                                        list_sudo_users() {
                                                                                    grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n'
                                                                            }

                                # Handle --help option
                                if [ "$1" == "--help" ]; then
                                            display_help
                                                exit 0
                                fi

                                # Handle --version option
                                if [ "$1" == "--version" ]; then
                                            echo "internsctl version v0.1.0"
                                                exit 0
                                fi

                                # Handle cpu getinfo command
                                if [ "$1" == "cpu" ] && [ "$2" == "getinfo" ]; then
                                            get_cpu_info
                                                exit 0
                                fi

                                # Handle memory getinfo command
                                if [ "$1" == "memory" ] && [ "$2" == "getinfo" ]; then
                                            get_memory_info
                                                exit 0
                                fi
                                # Handle user create command
                                if [ "$1" == "user" ] && [ "$2" == "create" ]; then
                                            create_user "$3"
                                                exit 0
                                fi
                                # Handle user list command
                                if [ "$1" == "user" ] && [ "$2" == "list" ]; then
                                            if [ "$3" == "--sudo-only" ]; then
                                                list_sudo_users
                                            else
                                                list_regular_users
                                            fi
                                            exit 0
                                fi


                                # Check if no arguments provided, or if help, version, cpu getinfo, or memory getinfo option requested
                                if [ $# -eq 0 ] || [ "$1" == "help" ] || [ "$1" == "--help" ] || [ "$1" == "--version" ] || [ "$1" == "user" ] && [ "$2" == "create" ] || [ "$1" == "user" ] && [ "$2" == "list" ] || [ "$1" == "cpu" ] && [ "$2" == "getinfo" ] || [ "$1" == "memory" ] && [ "$2" == "getinfo" ]; then
                                            display_help
                                                exit 0
                                fi
                                # Handle different options for file information
                                if [ $# -eq 2 ]; then
                                            get_file_info "$2" "$1"
                                                exit 0
                                fi
                                # Display basic file information if no options are provided
                                if [ $# -eq 1 ]; then
                                            file="$1"
                                                if [ ! -f "$file" ]; then
                                                    echo "File '$file' not found."
                                                        exit 1
                                                fi

                                        echo "File: $file"
                                        stat -c "Access: %A" "$file"
                                        stat -c "Size(B): %s" "$file"
                                        stat -c "Owner: %U" "$file"
                                        stat -c "Modify: %y" "$file"
                                fi

                                # Handle different commands
                                #case "$1" in
