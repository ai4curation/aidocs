#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "Starting corrections..."

# --- File: docs/how-tos/instruct-github-agent.md ---
echo "Processing docs/how-tos/instruct-github-agent.md"
# Check if file exists before processing
if [ ! -f "docs/how-tos/instruct-github-agent.md" ]; then
    echo "Error: docs/how-tos/instruct-github-agent.md not found!"
else
    content=$(cat "docs/how-tos/instruct-github-agent.md")
    original_content="$content"

    content=${content/"THe prompt"/"The prompt"}
    content=${content/"stil investigation"/"still investigating"}
    content=${content/"agent to use an Claude code"/"agent to use a Claude code"}
    content=${content/"AI to updates 100s"/"AI to update 100s"}

    if [ "$content" != "$original_content" ]; then
        echo "$content" > "docs/how-tos/instruct-github-agent.md"
        echo "Corrections applied to docs/how-tos/instruct-github-agent.md"
    else
        echo "No changes made to docs/how-tos/instruct-github-agent.md (possibly patterns not found or already correct)"
    fi
fi

# --- File: docs/how-tos/set-up-github-actions.md ---
echo "Processing docs/how-tos/set-up-github-actions.md"
if [ ! -f "docs/how-tos/set-up-github-actions.md" ]; then
    echo "Error: docs/how-tos/set-up-github-actions.md not found!"
else
    # Title correction
    correct_title="# How to create an AI agent for GitHub actions"
    current_title_line=$(head -n 1 "docs/how-tos/set-up-github-actions.md")
    title_corrected=false
    if [[ "$current_title_line" == "# How to create an AI agent create an AI agent for GitHub actions" ]]; then
        echo "Correcting title in docs/how-tos/set-up-github-actions.md..."
        { echo "$correct_title"; tail -n +2 "docs/how-tos/set-up-github-actions.md"; } > "docs/how-tos/set-up-github-actions.md.tmp"
        mv "docs/how-tos/set-up-github-actions.md.tmp" "docs/how-tos/set-up-github-actions.md"
        title_corrected=true
    else
        echo "Title in docs/how-tos/set-up-github-actions.md was not as expected: '$current_title_line'. Skipping title correction."
    fi

    content=$(cat "docs/how-tos/set-up-github-actions.md") # Re-read content
    original_content_after_title_fix="$content"

    content=${content/"The \`extensions\` section is the default MCP plugins."/"The \`extensions\` section defines the default MCP plugins."}
    content=${content/"Note if you find this complex"/"Note: if you find this complex"}
    content=${content/"But note this likely means you are using a person API key."/"But note that this likely means you are using a personal API key."}
    content=${content/"Do careful evals"/"Do careful evaluations"}

    if [ "$content" != "$original_content_after_title_fix" ] || [ "$title_corrected" = true ]; then
        echo "$content" > "docs/how-tos/set-up-github-actions.md"
        echo "Corrections applied to docs/how-tos/set-up-github-actions.md"
    else
        echo "No changes made to docs/how-tos/set-up-github-actions.md (patterns not found or already correct, and title was not changed)"
    fi
fi

# --- File: docs/tutorials/ontology-editing-with-ai.md ---
echo "Processing docs/tutorials/ontology-editing-with-ai.md"
if [ ! -f "docs/tutorials/ontology-editing-with-ai.md" ]; then
    echo "Error: docs/tutorials/ontology-editing-with-ai.md not found!"
else
    content=$(cat "docs/tutorials/ontology-editing-with-ai.md")
    original_content="$content"

    content=${content/"need to certain things installed locally"/"need to have certain things installed locally"}
    content=${content/"For macs"/"For Macs"}
    content=${content/"\`create a web page for many ontology\`"/"\`create a web page for an ontology\`"}
    content=${content/"file naviagtor"/"file navigator"}

    if [ "$content" != "$original_content" ]; then
        echo "$content" > "docs/tutorials/ontology-editing-with-ai.md"
        echo "Corrections applied to docs/tutorials/ontology-editing-with-ai.md"
    else
        echo "No changes made to docs/tutorials/ontology-editing-with-ai.md (possibly patterns not found or already correct)"
    fi
fi

# --- File: docs/glossary.md ---
echo "Processing docs/glossary.md"
if [ ! -f "docs/glossary.md" ]; then
    echo "Error: docs/glossary.md not found!"
else
    content=$(cat "docs/glossary.md")
    original_content="$content"

    content=${content/"maintaining, and quality-controlling ontologies"/"maintaining, and quality control for ontologies"}

    if [ "$content" != "$original_content" ]; then
        echo "$content" > "docs/glossary.md"
        echo "Corrections applied to docs/glossary.md"
    else
        echo "No changes made to docs/glossary.md (possibly patterns not found or already correct)"
    fi
fi

echo "All spelling and grammar corrections attempted."
