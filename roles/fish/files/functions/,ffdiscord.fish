function ,ffdiscord --description "Compress a video below Discord's upload limit"
    if test (count $argv) -lt 1
        echo "Usage: ,ffdiscord VIDEO [SIZE_MB]"
        return 1
    end

    set -l input $argv[1]
    set -l target_mb 9.5
    test (count $argv) -ge 2; and set target_mb $argv[2]

    if not test -f "$input"
        echo "File not found: $input"
        return 1
    end

    set -l duration (ffprobe -v error \
        -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 "$input")

    if test -z "$duration"
        echo "Could not determine video duration: $input"
        return 1
    end

    set -l audio_kbps 96

    # Reserve 3% for MP4 container overhead.
    set -l video_kbps (math -s0 \
        "($target_mb * 1000 * 1000 * 8 * 0.97 / $duration / 1000) - $audio_kbps")

    if test "$video_kbps" -lt 100
        echo "Video is too long for a useful encode at $target_mb MB."
        return 1
    end

    set -l stem (string replace -r '\.[^.]+$' '' "$input")
    set -l output "$stem-discord.mp4"
    set -l passlog (mktemp -u /tmp/ffdiscord.XXXXXX)

    echo "Target: $target_mb MB; video bitrate: $video_kbps kbps"

    ffmpeg -y -i "$input" \
        -c:v libx264 -b:v "$video_kbps"k -preset slow \
        -vf "scale='min(1920,iw)':-2" \
        -pass 1 -passlogfile "$passlog" -an -f mp4 /dev/null

    and ffmpeg -y -i "$input" \
        -c:v libx264 -b:v "$video_kbps"k -preset slow \
        -vf "scale='min(1920,iw)':-2" \
        -pass 2 -passlogfile "$passlog" \
        -c:a aac -b:a "$audio_kbps"k \
        -movflags +faststart "$output"

    set -l status_code $status
    rm -f "$passlog"-0.log "$passlog"-0.log.mbtree

    if test $status_code -eq 0
        echo "Created: $output"
        ls -lh "$output"
    end

    return $status_code
end
