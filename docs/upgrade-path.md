# CogniDoc — Beyond Tier 1

## What you have now (Tier 1: Foundation)

The open-source foundation includes: a bootloader (`COGNIDOC.md` template), memory file templates, four protocol specifications (SBS navigation, PSS state tracking, CPA operational pipeline, Mission Classification), working examples, and lightweight tooling. Free under Apache 2.0. Works with any LLM.

## The upgrade path

CogniDoc is a progressive system. Each tier adds capabilities while remaining backward-compatible with everything you already have.

### Tier 2: Starter — "The System + Manual"

What it adds:

- **Validated Python library (core)**: beacon parser, signal state machine, memory parser. Not grep scripts — tested, production-validated modules with proper error handling.
- **Auto-updating PDF manual generator**: professional documentation that rebuilds automatically when your project changes. Chapters, table of contents, headers/footers, enterprise formatting.
- **Customizable SBS domains**: full flexibility to define project-specific semantic domains with validation.

Who it's for: Individual developers or small teams who want programmatic validation and professional documentation output.

### Tier 3: Professional — "The Complete System"

What it adds:

- **Full Python library (7 modules)**: adds mission parser, propagation validator, mission classifier, and CPA planner. Complete programmatic toolkit for cognitive document management.
- **Assisted onboarding**: expert configuration of CogniDoc for your specific project and domain.
- **Cross-document audit**: programmatic verification that all documents are coherent with each other and with reality.
- **Configurable cognitive interface**: conversational widget adapted to your domain and workflow.

Who it's for: Teams that need verified coherence, professional setup, and support.

### Tier 4: Professional Plus — "The System + Local AI"

What it adds:

- **Fine-tuned LLM model**: a language model specifically trained on the CogniDoc protocol and your project domain. Runs locally on your hardware.
- **Native protocol execution**: the model doesn't follow CogniDoc instructions — it has internalized them. The difference between reading a map and knowing the territory.
- **No recurring API costs**: the model runs on your GPUs with no external dependencies.

Who it's for: Organizations with GPU infrastructure that want specialized AI without cloud dependency.

### Tier 5: Enterprise — "System + SaaS AI by Niche"

What it adds:

- **API access to specialized models**: hosted models fine-tuned per industry (legal, healthcare, finance, engineering).
- **Voice-enabled cognitive interface**: interact with your system using natural language (STT + TTS).
- **Per-niche specialization**: the model understands your industry's terminology, workflows, and constraints before you start.
- **Annual membership**: predictable costs, included support, regular model updates.

Who it's for: Organizations that want expert AI without managing GPU infrastructure.

### Tier 6: Enterprise Premium — "The Dedicated Suite"

What it adds:

- **Exclusive fine-tuned model**: trained on your data under strict NDA. Not shared with other clients.
- **Model that knows your company**: your terminology, your processes, your organizational structure.
- **Included updates**: the model evolves as your company evolves.
- **White-glove support**: dedicated team, fastest SLA.

Who it's for: Organizations where the cost of error is high and the value of specialized AI justifies premium investment.

## Comparison table

| Feature | T1 | T2 | T3 | T4 | T5 | T6 |
|---|---|---|---|---|---|---|
| Core system (bootloader + memory + protocols) | Yes | Yes | Yes | Yes | Yes | Yes |
| SBS navigation | Spec only | Validated parser | Full toolkit | Native in model | Native in model | Native in model |
| PDF manual generator | - | Yes | Yes | Yes | Yes | Yes |
| Python library | - | 3 core modules | 7 modules | 7 modules | 7 modules | 7 modules |
| Onboarding | Self-service | Self-service | Assisted | Assisted | Assisted | Dedicated |
| LLM included | - | - | - | Local fine-tuned | Hosted fine-tuned | Exclusive fine-tuned |
| Niche specialization | - | - | - | Your domain | Industry vertical | Your company |
| Exclusive model | - | - | - | - | - | Yes (NDA) |
| Voice interface | - | - | - | - | Yes | Yes |
| Support | Community | Community | Email | Email + priority | Included | White-glove |

## How to upgrade

- **T1** is always available in this repository (open source, Apache 2.0).
- **T2+**: visit the [CogniDoc repository](https://github.com/xuspitillo/CogniDoc) for updates on T2+ availability.
- All tiers are backward-compatible: your existing `COGNIDOC.md`, `MEMORY.md`, and mission files work unchanged.

## FAQ

### "Will my T1 setup break if I upgrade?"

No. Higher tiers add capabilities; they don't change the foundation. Your existing files, protocols, and workflows remain intact.

### "Can I skip tiers?"

Yes. You can go from T1 to T5 directly if that matches your needs. Each tier is self-contained.

### "Is the fine-tuned model based on a specific LLM?"

The base model selection depends on the tier and deployment context. Details are provided during consultation.
