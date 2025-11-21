# Frequently Asked Questions

## General Questions

### What is AI4Curators?

AI4Curators is a project focused on providing practical guides for curators and maintainers of knowledge bases to integrate AI into their workflows. Rather than theoretical discussions, we emphasize immediate, actionable integration strategies that work with existing GitHub-based workflows.

Our core mission includes:
- Helping curators integrate AI agents into existing GitHub-based workflows
- Providing plugins and tools for existing chat UIs  
- Supporting ontology editing and curation workflows with AI assistance

The project serves both as documentation and a practical example of AI agent integration, where GitHub agents can directly contribute to documentation and examples demonstrate real-world AI-assisted curation workflows.

## GitHub Copilot Integration

### Why can't GitHub Copilot access OBO PURLs like purl.obolibrary.org?

GitHub Copilot's coding agent includes a firewall that restricts internet access by default to prevent data exfiltration risks. While the agent can access GitHub-related hosts and a recommended allowlist of common package repositories, it blocks access to custom domains like `purl.obolibrary.org` that are commonly used in ontology workflows.

**The Solution:** Repository administrators can allowlist additional hosts in the Copilot firewall settings:

1. Navigate to your repository's **Settings** tab
2. Select **Copilot**, then **coding agent** from the Code & automation sidebar
3. Click **Custom allowlist**
4. Add `purl.obolibrary.org` (or specific URL paths) to the allowlist
5. Click **Add Rule**, then **Save changes**

**Allowlist formats:**
- **Domain**: `purl.obolibrary.org` - allows the domain and all subdomains
- **URL**: `https://purl.obolibrary.org/obo/` - restricts to specific scheme, host, and path

**Workaround:** Until the firewall is configured, use direct GitHub URLs instead of PURLs:
- ✅ Works: `https://raw.githubusercontent.com/oborel/obo-relations/refs/heads/master/ro-base.owl`
- ❌ Blocked: `http://purl.obolibrary.org/obo/ro/ro-base.owl`

For more details, see the [GitHub Copilot](reference/clients/github-copilot.md) documentation and GitHub's guide on [customizing the agent firewall](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/customize-the-agent-firewall).