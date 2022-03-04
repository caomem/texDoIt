#!/bin/sh

# Autor: Guilherme Philippi

if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$1" = "--h" ] || [ "$1" = "-help" ]; then
    echo "usage: $0 equation [output_file_name]"
    exit 1
fi

if [ $# -eq 1 ]; then
    FILE_NAME="forumla.pdf"
else
    FILE_NAME=$2
fi

if [ -f "${FILE_NAME}" ]; then
    read -p "${FILE_NAME} file already exists. Do you want to overwrite it? (y/N): " ANSWER
    if [ -z $ANSWER ] || [ $ANSWER != "y" ]; then
        echo "Aborted."
        exit 1
    fi
fi

if ! [ -d "/tmp/.tempTexFileExectionGP" ]; then
    mkdir /tmp/.tempTexFileExectionGP
fi

echo "\documentclass[border=2pt]{standalone}
\usepackage{amsmath}
\usepackage{varwidth}
\begin{document}
\begin{varwidth}{\linewidth}
\$\$$1\$\$
\end{varwidth}
\end{document}
" > /tmp/.tempTexFileExectionGP/_tempTexFile.tex

pdflatex -output-directory=/tmp/.tempTexFileExectionGP -interaction=batchmode _tempTexFile.tex

if [ -f "/tmp/.tempTexFileExectionGP/_tempTexFile.pdf" ]; then
    if [[ $FILE_NAME == *.png ]]; then
        convert -quiet -density 300 "/tmp/.tempTexFileExectionGP/_tempTexFile.pdf" -quality 90 "$FILE_NAME"
    fi
    if [[ $FILE_NAME == *.pdf ]]; then
        mv "/tmp/.tempTexFileExectionGP/_tempTexFile.pdf" "$FILE_NAME"
    fi

    if ! [ -f "$FILE_NAME" ]; then
        echo "Extension not supported. Making output in PDF."
        mv "/tmp/.tempTexFileExectionGP/_tempTexFile.pdf" "${FILE_NAME}.pdf"
    fi
    echo "Finished."

else 
    echo "Failed to compile latex file. Abort."
    exit 1
fi