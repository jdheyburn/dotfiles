
# WIP while fixing lost BT connection, it may need a sleep command
function restart_bluetooth() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        blueutil -p 0 && blueutil -p 1
    fi
}