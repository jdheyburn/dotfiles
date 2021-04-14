function restart_bluetooth() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        blueutil --power 0 && blueutil --power 1
    else
        echo "restart_bluetooth not implemented for $OSTYPE"
        return 1
    fi
}

function conn_headphones() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        blueutil --connect 94-db-56-84-69-49
    else
        echo "conn_headphones not implemented for $OSTYPE"
        return 1
    fi
}
