#!/bin/bash
while IFS= read -r ext; do
  codium --install-extension "$ext"
done < extensions.txt
