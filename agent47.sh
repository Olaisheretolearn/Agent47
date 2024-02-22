#!/bin/bash

case $1 in
    "newjob")
    
        read -p "Enter name for your new script: " script_name
        touch "$script_name.sh"
        echo "#!/bin/bash" > "$script_name.sh"
        chmod +x "$script_name.sh"
        echo "Script '$script_name.sh' created. You can now add commands using 'agent47 target $script_name'."
        ;;
    "target")
  
        script_name=$2
        if [ -f "$script_name.sh" ]; then
            echo "Enter commands to add to '$script_name.sh' (press Ctrl+D to finish):"
            commands=""
            while IFS= read -r line; do
                commands+="$line"$'\n'
            done
            echo "$commands" >> "$script_name.sh"
            echo "Commands added to '$script_name.sh'."
        else
            echo "Error: Script '$script_name.sh' does not exist."
            exit 1
        fi
        ;;
    "run")

        script_name=$2
        if [ -f "$script_name.sh" ]; then
            chmod +x "$script_name.sh"
            ./"$script_name.sh"
        else
            echo "Error: Script '$script_name.sh' does not exist."
            exit 1
        fi
        ;;
    *)
        echo "Usage: agent47 [newjob|target|run] <script_name>"
        exit 1
        ;;
esac
