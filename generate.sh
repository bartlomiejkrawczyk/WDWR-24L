#!/bin/zsh

pandoc -f markdown+tex_math_dollars+pipe_tables+yaml_metadata_block -F mermaid-filter -o report.pdf README.md

rm mermaid-filter.err
