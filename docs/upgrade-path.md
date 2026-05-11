# MandelDoc — Beyond Tier 1

## What you have now (Tier 1: Foundation)

The open-source foundation of MandelDoc. Five protocol specifications (SBS navigation, PSS state tracking, CPA operational pipeline, Mission Classification, PHS handshakes), templates, three reference examples, and lightweight shell tooling. Apache 2.0. Bring-your-own-LLM.

**This is the only release that ships today.** Everything below is roadmap, not product.

---

## Future tiers — honest status

Higher tiers are in **private development**. They will turn the protocol from convention into machine-enforced infrastructure: a programmatic library that parses, validates, and propagates MandelDoc artifacts; a generator that compiles project documentation into other formats; and possibly hosted services for teams.

**There is currently:**

- No committed timeline
- No public roadmap with feature lists
- No beta program
- No signup form
- No commercial offering
- No paid plan

If you want to be notified when something becomes available, watch this repository on GitHub. Every release ships through this repo.

---

## Compatibility commitment

The Tier 1 templates, specifications, and tooling are designed to remain stable and backward-compatible as future tiers ship. A project that adopts Tier 1 today should remain valid under any future Tier 2+ release without rewriting `MEMORY.md`, mission files, signal entries, or handshakes. If a future release ever requires a migration, it will ship a migration script and a clear upgrade note in the changelog.

---

## FAQ

### "When will Tier 2 be available?"

No date. Watch the repository.

### "Is there a paid plan or enterprise tier I can buy?"

No. Not today. Whether one will exist in the future is undecided.

### "Can I contribute to Tier 2?"

Tier 2 is in private development. Tier 1 (this repository) accepts contributions per [`CONTRIBUTING.md`](../CONTRIBUTING.md): documentation improvements, new reference examples, template enhancements, tooling improvements, and specification clarifications.

### "What was here before?"

Earlier versions of this page (v0.1.x through v0.2.x) listed six tiers (T1 through T6) with detailed feature tables and category labels like "Enterprise Premium" and "Hosted SaaS". That content overstated what is currently in development and read more like a commercial pitch than an honest roadmap. It was removed in v0.3.0 in favor of this honest status. The detailed tier descriptions remain in private notes; if and when any of them become real product, they will be announced through this repository on their own merits.
