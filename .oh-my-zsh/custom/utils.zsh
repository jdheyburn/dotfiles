
# Used on personal laptop to set the audio device
# WIP
function set-output-device() {
    pactl list short sinks
    read -p "Enter the output device" newSink
    pacmd set-default-sink $newSink
    pactl list short sink-inputs|while read stream; do
        streamId=$(echo $stream|cut '-d ' -f1)
        echo "moving stream $streamId"
        pactl move-sink-input "$streamId" "$newSink"
    done
}

