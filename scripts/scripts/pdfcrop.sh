# Runs pdfcrop on all pdfs in the current directory and replaces the
# old pdf with the cropped one
for file in ./*.pdf
do
    name=${file##*/}
    if [[ -f $name ]]; then
        pdfcrop $name $name
    fi
done
