# Getting Started with MandelDoc

## Prerequisites

- A project (any language, any domain)
- An LLM that reads markdown (ChatGPT, Claude, Gemini, local models, etc.)
- Basic familiarity with markdown

## Step 1 --- Initialize your project (2 minutes)

### Option A: Using the init script

```bash
git clone https://github.com/xuspitillo/MandelDoc.git /tmp/mandeldoc
/tmp/mandeldoc/tools/init.sh ~/my-project "My Project"
```

The script **creates the target directory if it does not exist**. You do not need to
`mkdir` or `cd` into it beforehand — pass any path you want as the first argument and
the script handles the rest. After the script finishes, you can `cd` into that
directory to continue. The script copies templates, generates `MANDELDOC.md`,
`MEMORY.md`, `SIGNAL_REGISTRY.md`, `HANDSHAKES.md`, and the `missions/` and
`handshakes/` skeletons, and replaces common placeholders automatically.

### Option B: Manual setup

1. Copy `bootloader/MANDELDOC.md.template` to your project root as `MANDELDOC.md`
2. Copy `templates/MEMORY.md.template` as `MEMORY.md`
3. Copy `templates/SIGNAL_REGISTRY.md.template` as `SIGNAL_REGISTRY.md`
4. Copy `templates/HANDSHAKES.md.template` as `HANDSHAKES.md`
5. Create empty `missions/` and `handshakes/` directories
6. Replace all `{{PLACEHOLDERS}}` with your project's values

## Step 2 --- Customize the bootloader (2 minutes)

Open `MANDELDOC.md`. Replace:

- `{{PROJECT_NAME}}` with your project name
- `{{ORG}}` with your GitHub org or username
- Review the 10 default domains in the Semantic Beacon System (SBS) --- add, remove, or rename domains to match your project's vocabulary
- Review the session commands --- adjust language or wording if needed

The bootloader is the contract between your project and any LLM that works on it. Spend a minute reading through it; the defaults are sensible for most software projects.

## Step 3 --- Set up your first memory (1 minute)

Open `MEMORY.md`. Fill in:

- **Section 1:** What is your project? One paragraph is enough.
- **Section 2:** Your tech stack (even if partial or evolving).
- **Section 4:** Current state --- version, phase, even if it is just "v0.1, just starting".
- **Sections 3, 5--10:** Leave the placeholder instructions in place. These sections fill naturally as you work.

## Step 4 --- Start a session with your LLM

How you load MandelDoc depends on your LLM type:

### Code-integrated LLMs (Claude Code, Cursor, Windsurf, Cline, Aider)

These tools auto-read a markdown file from your project root at session start. Make sure MandelDoc's bootloader has the name your tool expects:

| Tool | Expected filename | What to do |
|------|-------------------|------------|
| Claude Code | `CLAUDE.md` | Create a symlink: `ln -s MANDELDOC.md CLAUDE.md` — Claude Code auto-reads files named `CLAUDE.md` |
| Cursor | `.cursorrules` or project docs | Copy `MANDELDOC.md` content into your Cursor rules, or add it via Cursor's project docs feature |
| Windsurf | `.windsurfrules` | Copy `MANDELDOC.md` content into `.windsurfrules` |
| Cline | Auto-reads project files | Ensure `MANDELDOC.md` is in the project root; Cline will find it when prompted |
| Aider | Convention files or `--read` flag | Run: `aider --read MANDELDOC.md` |

Once loaded, the LLM reads your project files directly and follows the protocol automatically. No extra steps needed.

### Chat-based LLMs (ChatGPT, Gemini, Claude web)

Use the context bundler to generate a single block you can paste or upload:

```bash
# Copy to clipboard:
./tools/context.sh ~/my-project | pbcopy       # macOS
./tools/context.sh ~/my-project | xclip -sel c # Linux

# Or save to a file for upload:
./tools/context.sh ~/my-project -o context.txt
```

Paste or upload the output as the **first message** in your conversation. The block includes a header instruction that tells the LLM to read and follow the protocol.

For long conversations, you may need to re-paste the context if the LLM loses track. Use `--no-missions` to reduce size if context window limits are tight:

```bash
./tools/context.sh ~/my-project --no-missions | pbcopy
```

### Local LLMs (Ollama, LM Studio, text-generation-webui, Qwen, Mistral)

Pipe the context directly or use it as system prompt:

```bash
# Pipe to Ollama:
./tools/context.sh ~/my-project | ollama run qwen2.5

# Pipe to any CLI-based local model:
./tools/context.sh ~/my-project | your-model-cli

# Or generate a file and load it as system prompt in your interface:
./tools/context.sh ~/my-project -o context.txt
```

If your local model interface supports a system prompt file, point it at `MANDELDOC.md` directly or at the generated `context.txt` for the full bundle.

Note: MandelDoc works best with models that have large context windows (32k tokens or more). Smaller context models may need the `--no-missions` flag to fit.

### API usage (OpenAI API, Anthropic API, Google AI, local APIs)

Include the output of `context.sh` as the system message or first user message in your API call:

```python
# Example: OpenAI-compatible API
import subprocess

context = subprocess.run(
    ["./tools/context.sh", "/path/to/my-project"],
    capture_output=True, text=True
).stdout

response = client.chat.completions.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": context},
        {"role": "user", "content": "access memory"},
    ]
)
```

For APIs that support file attachments, you can also upload the generated `context.txt` file.

### Verify it works

Once your LLM has the context, try these commands:

- `"access memory"` --- the LLM reads MEMORY.md and confirms context
- `"[new mission: my-first-feature]"` --- creates your first tracked mission
- `"roadmap"` --- shows your active P1/P2 missions

## Step 5 --- Work with your LLM

How file management works depends on your LLM type:

- **File-capable LLMs** (Claude Code, Cursor, Windsurf, Cline, Aider): The LLM reads and writes mission files, MEMORY.md, and signal registry directly. It maintains the memory system automatically as you work.
- **Chat-only LLMs** (ChatGPT, Gemini, Claude web, most local models): The LLM will tell you what to update, but it cannot edit files itself. **You** maintain the files manually based on the LLM's suggestions. When it says "update MEMORY.md section 9 with...", you make the edit. When it proposes a new mission file, you create it. The protocol is the same; the hands on the keyboard are yours.
- **API integrations**: You control the workflow programmatically. Parse the LLM's output and apply changes to files as part of your pipeline.

In all cases, the LLM:

- Tracks mission progress as you advance tasks
- Maintains project state when milestones are reached
- Emits signals when process states change
- Places semantic beacons at important decision points

## What's next?

- Read [docs/concepts.md](concepts.md) to understand the cognitive documentation model
- Explore [examples/](../examples/) to see MandelDoc applied to different project types
- Check [docs/upgrade-path.md](upgrade-path.md) to learn about advanced features in higher tiers

## Troubleshooting

### "My LLM doesn't seem to follow the protocol"

- Ensure the full `MANDELDOC.md` content is in the LLM's context window (not truncated).
- Some LLMs need an explicit nudge: "Read and follow the protocol in MANDELDOC.md."
- Longer context windows produce better adherence. GPT-4, Claude, and Gemini Pro work well.

### "The memory files are getting large"

- This is expected. Mission files grow as work progresses.
- SBS beacons allow the LLM to navigate by domain and weight without reading everything.
- Consider archiving completed missions in a separate directory.

### "My LLM says it can't access files"

- Chat-based LLMs (ChatGPT, Gemini) cannot read your filesystem directly.
- Use `tools/context.sh` to bundle all MandelDoc files into a single block you can paste or upload.
- When the LLM suggests file updates, apply them manually. The cognitive protocol still works --- you handle the writes.

### "I want to use this with a team"

- MandelDoc works with git. Multiple team members and LLMs can contribute to the same memory.
- Merge conflicts in MEMORY.md are resolved by keeping the more recent state.
- Each team member's LLM reads the same bootloader and follows the same protocol.
