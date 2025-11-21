# GitHub Copilot

GitHub Copilot is GitHub's AI pair programmer that can assist with ontology curation and knowledge base maintenance tasks directly within your GitHub repositories.

## Overview

GitHub Copilot includes a coding agent that can help with:
- Downloading and processing ontology files
- Executing repository workflows and scripts
- Making automated commits and pull requests
- Performing code reviews and quality checks

## Setting Up GitHub Copilot for Ontology Workflows

### Prerequisites

- GitHub Copilot subscription (individual, business, or enterprise)
- Repository access with Copilot enabled
- Administrator permissions to configure firewall settings (for custom domain access)

## Firewall Configuration

By default, GitHub Copilot's coding agent includes a firewall that restricts internet access to prevent data exfiltration risks. This can block access to ontology-specific resources like OBO PURLs.

### Understanding the Default Allowlist

The agent's firewall allows access to:
- GitHub-related hosts (github.com, githubusercontent.com, etc.)
- OS package repositories (Debian, Ubuntu, Red Hat)
- Container registries (Docker Hub, Azure, AWS ECR)
- Programming language package registries (npm, PyPI, Maven, etc.)
- Certificate authorities for SSL validation

### Configuring Access to OBO Library and Other Ontology Resources

To enable access to `purl.obolibrary.org` and other ontology-related domains:

1. Navigate to your repository's **Settings** tab
2. In the sidebar, select **Copilot** under the Code & automation section
3. Click on **coding agent**
4. Select **Custom allowlist**
5. Add the domain or URL:
   - For broad access: `purl.obolibrary.org`
   - For specific paths: `https://purl.obolibrary.org/obo/`
6. Click **Add Rule**
7. Click **Save changes**

### Allowlist Entry Formats

**Domain allowlisting:**
```
purl.obolibrary.org
```
This allows access to the domain and all subdomains (e.g., `beta.purl.obolibrary.org`).

**URL allowlisting:**
```
https://purl.obolibrary.org/obo/
```
This restricts access to:
- Specific scheme (`https` only)
- Specific host (`purl.obolibrary.org`)
- Specific path prefix (`/obo/`)

### Common Domains for Ontology Work

Consider allowlisting these domains for ontology curation workflows:

- `purl.obolibrary.org` - OBO Library PURLs
- `www.ebi.ac.uk` - EBI Ontology Lookup Service
- `ontobee.org` - Ontobee ontology browser
- `bioportal.bioontology.org` - BioPortal ontology repository

## Workarounds

### Using Direct GitHub URLs

If firewall configuration is pending or unavailable, you can use direct GitHub raw URLs instead of PURLs:

**Instead of:**
```
http://purl.obolibrary.org/obo/ro/ro-base.owl
```

**Use:**
```
https://raw.githubusercontent.com/oborel/obo-relations/refs/heads/master/ro-base.owl
```

This works because GitHub hosts are already in the default allowlist.

### Mapping PURLs to GitHub URLs

For OBO Library ontologies, the PURL pattern:
```
http://purl.obolibrary.org/obo/{ontology}/{file}
```

Often maps to:
```
https://raw.githubusercontent.com/{org}/{ontology}/refs/heads/master/{file}
```

You can find the exact repository location by visiting the PURL in a browser and checking where it redirects.

## Security Considerations

### Why the Firewall Exists

The firewall prevents potential data exfiltration where malicious code could attempt to send repository data to unauthorized external servers. This is especially important for:
- Private repositories
- Repositories with sensitive data
- Enterprise environments

### Best Practices

1. **Principle of least privilege**: Only allowlist domains you actively need
2. **Use URL-based rules** when possible to restrict access to specific paths
3. **Regular audits**: Periodically review your allowlist entries
4. **Document decisions**: Keep a record of why specific domains were allowlisted
5. **Consider alternatives**: Use direct GitHub URLs when appropriate

### Disabling the Firewall

While it's possible to disable the firewall entirely, **this is not recommended** as it significantly increases security risks. Only disable the firewall if:
- You're in a controlled development environment
- You understand and accept the security implications
- You have alternative security measures in place

## Troubleshooting

### Issue: "Unable to resolve host address" or 404 errors

**Symptoms:** Copilot reports it cannot download files from ontology PURLs or specific domains.

**Solution:** Check if the domain is allowlisted in the firewall configuration. See [Configuring Access](#configuring-access-to-obo-library-and-other-ontology-resources) above.

### Issue: Some ontology files download, others don't

**Symptoms:** Direct GitHub URLs work, but PURLs fail.

**Explanation:** Direct GitHub URLs are in the default allowlist, but PURL domains require custom allowlist entries.

**Solution:** Add the PURL domain to the custom allowlist or use direct GitHub URLs.

### Issue: Changes to allowlist don't take effect

**Solution:**
- Ensure you clicked "Save changes" after adding rules
- Wait a few minutes for settings to propagate
- Try restarting the Copilot agent if available

## Related Resources

- [GitHub Copilot documentation](https://docs.github.com/en/copilot)
- [Customizing the agent firewall](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/customize-the-agent-firewall)
- [Set up GitHub actions](../../how-tos/set-up-github-actions.md)
- [Instruct the GitHub agent](../../how-tos/instruct-github-agent.md)

## Example: Configuring Copilot for OBO Workflows

Here's a complete example of setting up Copilot for ontology curation:

1. **Enable Copilot** on your ontology repository
2. **Configure firewall** to allow `purl.obolibrary.org`
3. **Test access** by asking Copilot to download a test ontology file:
   ```
   Download http://purl.obolibrary.org/obo/ro/ro-base.owl
   ```
4. **Set up workflows** using the standard OBO tools (ODK, ROBOT, etc.)
5. **Document your configuration** in your repository's README or contributor guidelines

With proper configuration, Copilot can seamlessly assist with ontology curation tasks while maintaining security through controlled firewall rules.
