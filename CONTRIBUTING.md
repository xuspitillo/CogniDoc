# Contributing to CogniDoc

Thank you for your interest in CogniDoc.

This document describes how to contribute to the public Tier 1 (Foundation) repository.

---

## Scope of contributions

This repository is the **public, foundational tier** of CogniDoc. We welcome contributions in the following areas:

- **Documentation improvements:** clarifications, typo fixes, examples, translations.
- **New reference examples:** adoption patterns for new domains (legal, healthcare, finance, education, etc.).
- **Template improvements:** enhancements to the bootloader, memory, or mission templates that benefit a wide range of adopters.
- **Tooling:** improvements to `init.sh`, `validate-beacons.sh`, or new lightweight tools that fit the T1 scope.
- **Specification clarifications:** edge cases, ambiguities, or improvements to the four foundational protocols (SBS, PSS, CPA, CLASSIFICATION).

The validated programmatic library (parsers, state machines, validators), advanced orchestration protocols, and enterprise-tier features are intentionally **out of scope** for this repository.

---

## How to contribute

### Reporting issues

Please use the GitHub issue tracker. Helpful issues include:

- **Bug reports** for tooling or templates (with reproduction steps).
- **Specification questions** when something in `specs/` is ambiguous.
- **Adoption feedback** when something is unclear in `docs/getting-started.md` or examples.
- **Use-case proposals** for new reference examples.

### Submitting pull requests

1. Fork the repository and create a feature branch from `main`.
2. Make your changes. Keep PRs focused — one improvement per PR is much easier to review.
3. Run the validators locally before submitting:
   ```bash
   ./tools/validate-beacons.sh examples/
   ```
4. Update `CHANGELOG.md` under an `[Unreleased]` section if your change is user-visible.
5. Open a pull request with a clear description of what changed and why.

### Developer Certificate of Origin (DCO)

By contributing to this project, you certify that you have the right to submit your contribution under the Apache License 2.0 — meaning you wrote it yourself, or you have explicit permission from the original author.

You can express this certification by signing your commits:

```bash
git commit -s -m "Your commit message"
```

This adds a `Signed-off-by` line to the commit message.

---

## Code style

- **Markdown:** prefer simple, readable markdown. Avoid HTML inside markdown unless absolutely necessary.
- **Filenames:** kebab-case for documentation, snake_case for tooling, dot-prefix for templates (`MEMORY.md.template`).
- **Beacons:** when adding beacons to documentation, follow the SBS format exactly: `[*(DOM.W.ROL>DEST)*]`.
- **Examples:** every example must be self-contained and runnable with any LLM.

---

## Governance

CogniDoc Tier 1 is currently maintained by the project lead ([@xuspitillo](https://github.com/xuspitillo)) with assistance from contributors. Specification changes that affect the public protocol surface (SBS, PSS, CPA, CLASSIFICATION, PHS) require maintainer review to ensure backward compatibility with adopters and internal consistency. As the contributor base grows, governance will evolve toward a more distributed model documented in this section.

Templates, examples, documentation, and tooling are more flexible and benefit from community contributions without spec-level review.

---

## Questions

For general questions, please open a GitHub Discussion (preferred) or issue.

For commercial inquiries about Tier 2 and above, see `docs/upgrade-path.md`.

For security issues, please follow responsible disclosure: do not open a public issue. Contact the maintainers privately.

---

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0, the same license that covers this project.
