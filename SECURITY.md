# Security Policy

## Supported versions

`studio-concept-film` follows semantic versioning. Security fixes are backported to the latest minor release of the current major version.

| Version | Supported |
|---|---|
| 1.x     | ✅ |
| < 1.0   | ❌ |

## Reporting a vulnerability

If you find a security issue in this repo — for example, a script that mishandles user input in a way that could lead to command injection, or a workflow that leaks credentials — please **do not open a public issue**.

Instead, report it privately by email to **[security@transformative.studio](mailto:security@transformative.studio)** with the following details:

- A short description of the issue
- Steps to reproduce
- The affected file(s) and line(s)
- Your assessment of the severity and impact

We aim to acknowledge reports within 72 hours and to issue a fix or mitigation within 14 days for confirmed vulnerabilities. Critical issues will be expedited.

## What counts as a security issue

- Command injection or path traversal in any of the bundled `scripts/`
- Workflow misconfigurations that expose `GITHUB_TOKEN`, `ELEVENLABS_API_KEY`, or other secrets
- Dependency vulnerabilities with confirmed exploitability in this project's usage
- Anything that would compromise a user's local environment when running the skill in good faith

## What does not count

- Misuse of the skill to produce content the maintainers disapprove of — this is a [Code of Conduct](CODE_OF_CONDUCT.md) matter, not a security matter
- Bugs that don't have security implications — please open a normal [bug report](.github/ISSUE_TEMPLATE/bug_report.yml)
- Vulnerabilities in upstream dependencies that don't affect this project's usage

## Recognition

We're grateful for responsible disclosure. With your permission, we'll credit reporters in the release notes of the version that contains the fix.
