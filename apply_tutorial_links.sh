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
#   $4: (optional) specific line number to make the replacement
#   $5: (optional) occurrence number on that line
add_link_if_not_present() {
  local filepath="$1"
  local term="$2"
  local text_to_link="$3"
  local line_num="$4"
  local occurrence_num="$5"
  local anchor=$(generate_anchor "$term")
  local link="[$text_to_link](glossary.md#$anchor)"
  local temp_file="${filepath}.tmp.$RANDOM"

  # Check if the exact markdown link already exists for this text_to_link
  # Need to escape brackets for grep pattern
  local escaped_text_to_link=$(echo "$text_to_link" | sed 's/\[/\\\[/g; s/\]/\\\]/g; s/\./\\\./g; s/\*/\\\*/g')
  local escaped_anchor=$(echo "$anchor" | sed 's/[&/\]/\\&/g')
  if grep -q "\[$escaped_text_to_link\](glossary.md#$escaped_anchor)" "$filepath"; then
    echo "Exact link for '$text_to_link' to glossary.md#$anchor already present in $filepath."
    return
  fi

  # Check if the text_to_link is already part of *any* link
  # This checks if the text is enclosed in square brackets followed by parentheses.
  if grep -Eq "\[${escaped_text_to_link}\]\([^)]+\)" "$filepath"; then
    echo "'$text_to_link' is already part of a link in $filepath. Skipping."
    return
  fi

  # If line number and occurrence are specified
  if [[ -n "$line_num" && -n "$occurrence_num" ]]; then
    awk -v line="$line_num" -v occ="$occurrence_num" -v search_orig="$text_to_link" -v rep="$link" '
    function escape_regex(str) {
      gsub(/\[/, "\\[", str);
      gsub(/\]/, "\\]", str);
      gsub(/\./, "\\.", str);
      gsub(/\*/, "\\*", str);
      # Add more special characters if needed
      return str;
    }
    NR == line {
      search = escape_regex(search_orig);
      count = 0;
      current_pos = 1;
      new_line = "";
      while (match(substr($0, current_pos), search)) {
        count++;
        match_start = RSTART;
        match_length = RLENGTH;
        if (count == occ) {
          new_line = new_line substr($0, current_pos, match_start - 1) rep;
          current_pos += match_start + match_length -1;
          break;
        }
        new_line = new_line substr($0, current_pos, match_start + match_length - 1);
        current_pos += match_start + match_length -1;
      }
      if (current_pos <= length($0)) {
         new_line = new_line substr($0, current_pos);
      }
      $0 = new_line;
    }
    {print}' "$filepath" > "$temp_file" && mv "$temp_file" "$filepath"
    echo "Attempted to link '$text_to_link' to glossary.md#$anchor on line $line_num, occurrence $occurrence_num in $filepath"
  else
    # Replace first global occurrence. Use a unique delimiter for sed.
    local DELIM=$(echo -en '\001')
    local sed_text_to_link=$(echo "$text_to_link" | sed 's/[&/\\]/\\&/g') # Escape & and / for sed pattern and replacement
    local sed_link=$(echo "$link" | sed 's/[&/\\]/\\&/g')

    if grep -q "$sed_text_to_link" "$filepath"; then
      sed "1;s$DELIM$sed_text_to_link$DELIM$sed_link$DELIM" "$filepath" > "$temp_file" && mv "$temp_file" "$filepath"
      echo "Attempted to link first global occurrence of '$text_to_link' to glossary.md#$anchor in $filepath"
    else
      echo "Text '$text_to_link' not found in $filepath. Skipping."
    fi
  fi
}

# Function to add an external link if not already present
add_external_link_if_not_present() {
  local filepath="$1"
  local text_to_link="$2"
  local url="$3"
  local link="[$text_to_link]($url)"
  local temp_file="${filepath}.tmp.$RANDOM"

  # Escape for grep and sed
  local escaped_text_to_link_grep=$(echo "$text_to_link" | sed 's/\[/\\\[/g; s/\]/\\\]/g; s/\./\\\./g; s/\*/\\\*/g')
  local escaped_url_grep=$(echo "$url" | sed 's/[&/\\]/\\&/g; s/\./\\\./g') # Escape . for grep, & and / for sed in URL

  # Check if the exact link already exists
  if grep -q "\[$escaped_text_to_link_grep\]($(echo "$url" | sed 's/[&/\\]/\\&/g; s/\./\\\./g'))" "$filepath"; then
    echo "External link '$link' already present in $filepath."
    return
  fi

  # Check if the text_to_link is already part of *any* link
  if grep -Eq "\[${escaped_text_to_link_grep}\]\([^)]+\)" "$filepath"; then
    echo "'$text_to_link' is already part of a link in $filepath (external link check). Skipping."
    return
  fi

  local DELIM=$(echo -en '\001')
  local sed_text_to_link=$(echo "$text_to_link" | sed 's/[&/\\]/\\&/g')
  local sed_link=$(echo "$link" | sed 's/[&/\\]/\\&/g')

  if grep -q "$sed_text_to_link" "$filepath"; then
    sed "1;s$DELIM$sed_text_to_link$DELIM$sed_link$DELIM" "$filepath" > "$temp_file" && mv "$temp_file" "$filepath"
    echo "Linked '$text_to_link' to external site '$url' in $filepath"
  else
    echo "Text '$text_to_link' for external link not found in $filepath."
  fi
}


# --- File: docs/tutorials/ontology-editing-with-ai.md ---
# Terms: OBO, Ontology, GitHub (external), Protege (external), Agentic AI, Claude, Goose, LLM, API key, Xcode (external)

add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "OBO Format" "OBO" # "OBO ontologies"
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Ontology" "ontology" # "local copy of the ontology edit file" (careful with multiple "ontology" instances)
# Corrected GitHub link line from prompt
add_external_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "GitHub" "https://github.com" # "checked out from GitHub"
add_external_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Protege" "https://protege.stanford.edu/" # "- Protege"
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "AI Agent" "Agentic AI" # "Agentic AI is a paradigm"
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Claude" "Claude" # "Claude Desktop" (link "Claude" part)
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Goose" "Goose" # "focus here on Goose"
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Large Language Model (LLM)" "LLM" # "Set up your LLM"
add_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "API Key" "API key" # "You will need an API key."
# Xcode is intentionally skipped by comment in prompt, existing link is fine. Script checks should handle it.
add_external_link_if_not_present "docs/tutorials/ontology-editing-with-ai.md" "Xcode" "https://developer.apple.com/xcode/"


echo "Finished processing links for docs/tutorials/ontology-editing-with-ai.md"
