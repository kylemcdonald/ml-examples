#!/usr/bin/env bash

LENGTH=${1:-10000}
ROOT="/root/shared/ml-examples"
CHARRNN="$ROOT/karpathy/char-rnn"
MODEL="$ROOT/models/char-rnn/emoji.t7"
OUTPUT="$ROOT/workshop/char_rnn_emoji"
RESULTS="$OUTPUT/raw.txt"
HTML="$OUTPUT/preview.html"
SEED=`date +%s`

echo "Generating $LENGTH characters to $OUTPUT with seed $SEED..."

cd $CHARRNN
th sample.lua $MODEL -length $LENGTH -seed $SEED -gpuid -1 -verbose 0 > $RESULTS
cd -

echo "Splitting and recombining..."

mkdir -p "$OUTPUT/out"
i=0
while read line; do
	name=`echo $line | cut -d'<' -f1 | tr -cs '[A-Z0-9 ]' ' ' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'`
	svg='<'`echo $line | cut -d'<' -f2-`
	filename="$i $name.svg"
	echo "$filename"

	file="$OUTPUT/out/$filename"
	cat > "$file" <<'EOF'
<?xml version="1.0" encoding="UTF-8" standalone="no"?><svg xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:cc="http://creativecommons.org/ns#" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 47.5 47.5" style="enable-background:new 0 0 47.5 47.5;" xml:space="preserve" version="1.1" id="svg2"><metadata id="metadata8"><rdf:RDF><cc:Work rdf:about=""><dc:format>image/svg+xml</dc:format><dc:type rdf:resource="http://purl.org/dc/dcmitype/StillImage"/></cc:Work></rdf:RDF></metadata>
EOF
	echo $svg >> "$file"
	echo "</svg>" >> "$file"

	((i++))
done < $RESULTS


cat > $HTML <<'EOF'
<html>
<head>
<title>char-rnn emoji preview</title>
<style>img { width: 20%; }</style>
</head>
EOF
for filename in out/*.svg; do
	echo "<a href='$filename'><img src='$filename' onerror='this.style.display=\"none\"'/></a>" >> "$HTML"
done

cat >> $HTML <<'EOF'
</body>
</html>
EOF