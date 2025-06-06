#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Helper function to create markdown anchor from a term
# E.g., "GitHub Actions" -> "github-actions"
# E.g., "PMID (PubMed ID)" -> "pmid-pubmed-id"
# E.g., "AI Agent" -> "ai-agent"
# E.g., "Knowledge Base (KB)" -> "knowledge-base-kb"
generate_anchor() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed -e 's/ /-/g' -e 's/[^a-z0-9-]//g'
}

# Function to add a link to the glossary if the term exists and is not already linked nearby
# Arguments:
#   $1: filepath
#   $2: term (exact case as in glossary heading)
#   $3: text to link (exact case as in document)
#   $4: (optional) context string to locate the linking position more precisely
add_link_if_not_present() {
  local filepath="$1"
  local term="$2"
  local text_to_link="$3"
  local context_str="${4:-$text_to_link}" # Default context is the text_to_link itself
  local anchor=$(generate_anchor "$term")
  local link="[$text_to_link](glossary.md#$anchor)"

  # Check if the specific link already exists or if the text is already part of any link
  if ! grep -q "\[$text_to_link\](glossary.md#$anchor)" "$filepath" && ! grep -q "\[$text_to_link\]([^)]*)" "$filepath"; then
    # Try to replace the first occurrence of the text_to_link, ideally within the context
    # This sed command is a bit complex:
    # It tries to find the context_str. If found, it operates on that line.
    # Within that line, it attempts to replace the first occurrence of text_to_link.
    # This is a simplified approach; more complex cases might need manual intervention or more robust parsing.
    # Using a temporary file for sed in-place editing for compatibility
    sed -i.bak "/$(echo "$context_str" | sed 's/[&/\]/\&/g')/s/$(echo "$text_to_link" | sed 's/[&/\]/\&/g')/$link/1" "$filepath" && rm "${filepath}.bak" || echo "Warning: Could not add link for '$text_to_link' in $filepath"
    echo "Attempted to link '$text_to_link' to glossary.md#$anchor in $filepath"
  else
    echo "Link for '$text_to_link' to glossary.md#$anchor already present or text is already linked in $filepath."
  fi
}


# --- File: docs/index.md ---
# Terms to link: Knowledge Base, AI, GitHub (external)

# Knowledge Base (KB) - link "knowledge bases"
add_link_if_not_present "docs/index.md" "Knowledge Base (KB)" "knowledge bases" "curators and maintainers of knowledge bases"

# AI - this is tricky as it's very generic. The glossary term is "AI Agent".
# Let's link "AI" to "AI Agent" if it makes sense in context.
# "integrate AI into their workflows" - here "AI" is general.
# "agents that plug into the existing GitHub repos" - this is closer to AI Agent.
# For now, let's skip linking generic "AI" to "AI Agent" to avoid confusion.
# We will link "AI agent" when it appears.

# GitHub - external link
if ! grep -q "\[GitHub\](https://github.com)" "docs/index.md"; then
  sed -i.bak "s/GitHub repos/\[GitHub\](https:\/\/github.com) repos/1" "docs/index.md" && rm "docs/index.md.bak"
  echo "Linked 'GitHub' to external site in docs/index.md"
fi

# --- File: docs/how-tos/instruct-github-agent.md ---
# Terms to link: AI agent, GitHub actions, PMID, OBO format, Ontology, Claude, Goose

add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "AI Agent" "AI agent" "guide for instructing the AI agent"
add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "GitHub Actions" "GitHub actions" "set up GitHub actions"
add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "PMID (PubMed ID)" "PMIDs" "Accessing PMIDs"
add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "OBO Format" "obo format" "source of the ontology is in obo format"
add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "Ontology" "ontology" "source of the ontology is in obo format"
# Claude is already linked via an external link, which is fine.
# Goose is mentioned as 'goose', part of '.goosehints'. The glossary term is "Goose".
add_link_if_not_present "docs/how-tos/instruct-github-agent.md" "Goose" "goose" "goose uses"

echo "Finished processing links for docs/index.md and docs/how-tos/instruct-github-agent.md"
