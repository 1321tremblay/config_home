#!/bin/bash
while IFS= read -r ext; do
  code --install-extension "$ext"
done < extensions.txt
