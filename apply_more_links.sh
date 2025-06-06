#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Helper function to create markdown anchor from a term
generate_anchor() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g' -e 's/[^a-z0-9-]//g'
}

# Function to add a link to the glossary if the term exists and is not already linked nearby
# Arguments:
#   $1: filepath
#   $2: term (exact case as in glossary heading)
#   $3: text to link (exact case as in document)
#   $4: (optional) specific line number to make the replacement (if multiple occurrences)
#   $5: (optional) occurrence number on that line (if multiple occurrences on the same line)
add_link_if_not_present() {
  local filepath="$1"
  local term="$2"
  local text_to_link="$3"
  local line_num="$4"
  local occurrence_num="$5"
  local anchor=$(generate_anchor "$term")
  local link="[$text_to_link](glossary.md#$anchor)"
  local temp_file="${filepath}.tmp.$RANDOM" # Unique temp file

  # Check if the exact markdown link already exists for this text_to_link
  # Need to escape regex special characters in text_to_link for grep
  local escaped_text_to_link=$(echo "$text_to_link" | sed 's/\[/\\[/g; s/\]/\\]/g; s/\./\\./g; s/\*/\\*/g; s/\^/\\^/g; s/\$/\\$/g; s/\//\\\//g')
  if grep -q "\[$escaped_text_to_link\](glossary.md#$anchor)" "$filepath"; then
    echo "Exact link for '$text_to_link' to glossary.md#$anchor already present in $filepath."
    return
  fi

  # Check if the text_to_link is already part of *any* link
  if grep -q "\[$escaped_text_to_link\]([^)]*)" "$filepath"; then
    echo "'$text_to_link' is already part of a link in $filepath. Skipping."
    return
  fi

  # If line number and occurrence are specified
  if [[ -n "$line_num" && -n "$occurrence_num" ]]; then
    awk -v line="$line_num" -v occ="$occurrence_num" -v search="$(echo "$text_to_link" | sed 's/[[\.*^$/]/\\&/g')" -v rep="$link" '
    NR == line {
      count = 0;
      original_line = $0;
      temp_line = "";
      current_pos = 1;
      while (match(substr(original_line, current_pos), search)) {
        count++;
        match_start_in_substr = RSTART;
        match_end_in_substr = RSTART + RLENGTH -1;

        global_match_start = current_pos + match_start_in_substr - 1;
        global_match_end = current_pos + RLENGTH -1;

        if (count == occ) {
          temp_line = temp_line substr(original_line, current_pos, match_start_in_substr - 1) rep;
          current_pos = global_match_end + 1;
          # Append the rest of the line after the replacement
          $0 = temp_line substr(original_line, current_pos);
          print $0; # Print the modified line
          next; # Move to next line in awk script
        } else {
          # Append the part including the non-target match and continue search
          temp_line = temp_line substr(original_line, current_pos, match_end_in_substr);
          current_pos = global_match_end +1;
        }
      }
      # If occurrence not found or loop finishes, print original or partially modified line
      if (temp_line == "") print original_line; else if (current_pos <= length(original_line)) print temp_line substr(original_line, current_pos); else print temp_line;
      next;
    }
    {print}' "$filepath" > "$temp_file" && mv "$temp_file" "$filepath"
    echo "Attempted to link '$text_to_link' to glossary.md#$anchor on line $line_num, occurrence $occurrence_num in $filepath"
  else
    # Try to replace the first occurrence of the text_to_link in the file
    local DELIM=$(echo -en '\001') # Use a non-printable char as delimiter
    # Escape text_to_link and link for sed
    local sed_text_to_link=$(echo "$text_to_link" | sed 's/[&/\]/\\&/g')
    local sed_link=$(echo "$link" | sed 's/[&/\]/\\&/g')

    # Check if filepath exists and is not empty
    if [ -s "$filepath" ]; then
        # Check if the text_to_link exists in the file before attempting replacement
        if grep -q "$sed_text_to_link" "$filepath"; then
            sed "1;s${DELIM}${sed_text_to_link}${DELIM}${sed_link}${DELIM}" "$filepath" > "$temp_file" && mv "$temp_file" "$filepath"
            echo "Attempted to link first global occurrence of '$text_to_link' to glossary.md#$anchor in $filepath"
        else
            echo "Warning: Text '$text_to_link' not found in $filepath. No link added."
        fi
    else
        echo "Warning: File '$filepath' is empty or does not exist. No link added."
    fi
  fi
}


# --- File: docs/how-tos/integrate-ai-into-your-kb.md ---
# Terms: Knowledge Base (KB), MCPs, Goose, GitHub actions, O3 guidelines

add_link_if_not_present "docs/how-tos/integrate-ai-into-your-kb.md" "Knowledge Base (KB)" "Knowledge Base" # "integrate AI into your Knowledge Base"
add_link_if_not_present "docs/how-tos/integrate-ai-into-your-kb.md" "Model Context Protocol (MCP)" "MCPs" # "simple MCP servers"
add_link_if_not_present "docs/how-tos/integrate-ai-into-your-kb.md" "Goose" "Goose" # "recommend Goose as an AI app/host"
add_link_if_not_present "docs/how-tos/integrate-ai-into-your-kb.md" "GitHub Actions" "GitHub actions" # "Set up GitHub actions"
add_link_if_not_present "docs/how-tos/integrate-ai-into-your-kb.md" "O3 Guidelines" "O3 guidelines" # "follow O3 guidelines"

# --- File: docs/how-tos/set-up-github-actions.md ---
# Terms: GitHub actions, AI agent, Goose, MCP, LiteLLM, Claude, API key

# GitHub is already linked externally in many places, let's assume that's fine.
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "GitHub Actions" "GitHub actions" 1 1 # "create an AI agent for GitHub actions" (first line, first occ)
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "AI Agent" "AI agent" 1 1 # "create an AI agent for GitHub actions" (first line, first occ)
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "Goose" "Goose" # "`.config/goose`" (Context: "Create a folder .config/goose")
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "Model Context Protocol (MCP)" "MCP" # "default MCP plugins" (Context: "The `extensions` section is the default MCP plugins")
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "LiteLLM" "LiteLLM" # "LiteLLM proxy (CBORG)"
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "Claude" "Claude" # "Anthropic claude-sonnet" (There are multiple "Claude"s, link first one that refers to the model)
add_link_if_not_present "docs/how-tos/set-up-github-actions.md" "API Key" "API key" # "means you are using a person API key"

echo "Finished processing links for docs/how-tos/integrate-ai-into-your-kb.md and docs/how-tos/set-up-github-actions.md"
