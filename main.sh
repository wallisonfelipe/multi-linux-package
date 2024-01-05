#!/bin/bash

while true; do
    # Display main menu
    echo "Select software to install:"
    echo "1. MySQL"
    echo "2. PHP"
    echo "3. Quit"
    read -p "Enter the number corresponding to your choice: " main_choice

    case $main_choice in
        1)
            software="MySQL"
            ;;
        2)
            software="PHP"
            ;;
        3)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 1, 2, or 3."
            continue
            ;;
    esac

    # Prompt user to select version
    echo "Select $software version to install:"
    if [ "$software" == "MySQL" ]; then
        echo "1. MySQL 5.7"
        echo "2. MySQL 8.0"
    elif [ "$software" == "PHP" ]; then
        echo "1. PHP 7.4"
        echo "2. PHP 8.0"
        echo "3. PHP 8.1"
        echo "4. PHP 8.2"
        echo "5. PHP 8.3"
    fi
    read -p "Enter the number corresponding to your choice: " version_choice

    # Install the selected version
    case $version_choice in
        1)
            version="5.7"
            ;;
        2)
            if [ "$software" == "MySQL" ]; then
                version="8.0"
            elif [ "$software" == "PHP" ]; then
                version="8.0"
            fi
            ;;
        3)
            if [ "$software" == "PHP" ]; then
                version="8.1"
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
            ;;
        4)
            if [ "$software" == "PHP" ]; then
                version="8.2"
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
            ;;
        5)
            if [ "$software" == "PHP" ]; then
                version="8.3"
            else
                echo "Invalid choice. Exiting."
                exit 1
            fi
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac

    # Install software and display installed version
    echo "Installing $software $version..."
    if [ "$software" == "MySQL" ]; then
        sudo apt update
        sudo apt install -y mysql-server-$version
        installed_version=$(mysql --version | awk '{print $5}')
    elif [ "$software" == "PHP" ]; then
        sudo apt update
        sudo apt install -y php$version
        sudo apt install openssl php$version-bcmath php$version-curl php$version-json php$version-mbstring php$version-mysql php$version-tokenizer php$version-xml php$version-zip
        installed_version=$(php -v | head -n 1 | cut -d " " -f 2)
    fi

    echo "$software $installed_version has been successfully installed."
done
