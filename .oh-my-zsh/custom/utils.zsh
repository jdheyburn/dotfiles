function restart_bluetooth() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        blueutil --power 0 && blueutil --power 1
    else
        echo "restart_bluetooth not implemented for $OSTYPE"
        return 1
    fi
}

# HeadPhones
function hp() {
    local id="94-db-56-84-69-49"
    local action=$1

    if [[ "$OSTYPE" != "darwin"* ]]; then
        echo "hp not implemented for $OSTYPE"
        return 1        
    fi

    if [[ $action == "c" ]]; then
        blueutil --connect $id
    elif [[ $action == "d" ]]; then
        blueutil --disconnect $id
    else
        echo "hp - unknown action: $action"
        return 1
    fi
}
