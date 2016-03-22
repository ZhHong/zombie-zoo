for f in $(ls *.jpg); do
    sips -s format png --out "${f%.*}.png" "$f"
done
