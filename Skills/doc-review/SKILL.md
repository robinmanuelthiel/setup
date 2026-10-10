---
name: doc-review
description: First-pass review of technical documentation the way Robin-Manuel reviews it, using a rule base that grows over time. Covers documents (Confluence pages, concepts, BRS, runbooks, ADRs, architecture docs, READMEs, how-tos, technical concepts, memos) and documentation inside code (code comments, IaC and config comments, pull request descriptions, documentation in a PR diff). Use this skill whenever the user asks to review, check, critique, or give feedback on a document, page, or pull request, even if they don't say "review skill". Also use it in learning mode whenever the user shares a document together with their own review comments and wants to extract, update, or refine review rules, patterns, or learnings from them.
---

# Doc Review

This skill has two modes:

- **Review mode**: review a document like Robin-Manuel would, using `references/rules.md`.
- **Learning mode**: update `references/rules.md` from a review Robin-Manuel did himself.

Always read `references/rules.md` fully before doing either.

"Document" in this skill means any written documentation: a page or file, but also code comments, comments in IaC or config, and pull request descriptions. Code comments are documentation too, and the same rules apply to them.

The rules are the heart of this skill. They are generic on purpose: they describe patterns in documents, not topics. A rule about "numbers need reasons" applies to a monitoring concept, a database migration plan, and an onboarding guide alike.

---

## Review mode

### 1. Read the whole document first

Read it end to end before writing any finding. Many rules (introduce before reference, repetition, overview first) can only be judged with the full picture. If the document is a Confluence page, read existing comments too, so you don't repeat points already raised.

For pull requests and code: review the PR description and every added or changed comment as documentation. Always read each comment together with the code next to it, and check that the comment matches what the code actually does. Existing review comments in the PR count like page comments: don't repeat them.

### 2. Identify audience and purpose

Decide who the document is for (engineers, support, management, external partners) and what it claims to do ("enough to rebuild the setup", "decision record", "runbook for on-call"). Judge the document against its own stated purpose. If the purpose is missing, that is already a finding (rule C1). If it's unclear, ask the user who the intended audience is.

### 3. Apply the rules

Go through every rule. For each rule, check its "Triggers when" list against the document, and respect its "Does not trigger when" list. Do not invent findings outside the rules unless they are serious (wrong facts, security risks, a design that cannot work). Mark those as "outside rule base" so learning mode can pick them up later.

### 4. Write the findings

Use this structure:

```
## Summary
One to three sentences: overall state, and the most important thing to fix.

## Blocker
## Major
## Minor
(only sections that have findings)

Per finding:
**[Rule ID] Short title**
Where: short quote of the anchor text, or section name
Issue: what is wrong, in one or two sentences
Why it matters: the consequence for a reader or for future maintenance
Fix: a concrete suggestion of a change. When the problem is wording, suggest a better text (see below).

## Open questions for the author
Questions where the reviewer cannot judge without more context.
```

Writing guidelines for findings:

- **Group repeats.** If one rule triggers ten times (for example, ten unlinked IDs), write one finding and list all locations. Ten separate "please link" findings bury the important ones.
- **Lead with what matters.** Blockers and majors first. Never let minor findings outnumber and hide a design issue.
- **Explain, don't just ask.** A bare "?" or "What is that?" works between colleagues, not from an AI. Always say why it matters and suggest a fix.
- **Suggest better text.** When the fix is about wording (a missing WHY, an unclear sentence, a weak code comment), suggest a better version as a starting point, for example under "Better:" in a code block. It is a suggestion for the author, not a replacement: the author knows the context, so mark parts you had to guess.
- **Plain language.** Write in the document's language. Use simple words and short sentences; many readers are non-native speakers.
- **Direct and friendly.** No praise padding, no harshness.

### 5. Posting comments

Only post comments back into a tool (for example Confluence inline comments) when the user explicitly aproves it. By default, return the review in the chat. Follow up with clarifying questions, the possibility to refine the comments or ask if the user wants them posted.

Never reference the rules or their IDs in the comments posted back into the tool. Rules are purely internal and meant for guiding the review process, not for the document's audience.

---

## Learning mode

Goal: Learn from Robin-Manuel's own review comments and turn them into better rules, without turning the rule base into a pile of one-off remarks.

### 1. Collect the input

Get the document and **only Robin-Manuel's comments** (filter by author), including the anchored text each comment refers to and any replies. The anchored text matters more than the comment: "?" means nothing without the passage it sits on. For Confluence, fetch inline and footer comments, open and resolved.

### 2. Classify each comment

For every comment, decide one of:

| Class | Meaning | Action |
| --- | --- | --- |
| Hit | Matches an existing rule | No change. If the occurrence is a new kind of trigger, propose a generalized trigger for that rule. |
| Gap | A generic pattern not covered yet | Propose a new rule. |
| Refinement | Shows that an existing rule is too broad, too narrow, or has an exception | Propose an edit to the rule or its "Does not trigger when" list. |
| Specific | About this document's topic, domain, or situation only | Skip. List it with a short reason. |
| Noise | Typo fixes, one-word style edits | Skip. |

If an earlier AI review of the same document exists, also compare: which findings did Robin-Manuel not make (possible false positives), and which of his comments did the AI miss (possible gaps).

### 3. Generalize before proposing

Every proposed rule or trigger must pass these tests:

- **Topic test**: would it trigger on a document about a completely different subject? If not, rewrite or classify as Specific.
- **No proper nouns**: no product names, people, ticket keys, or values from the source document. Describe the occurrence abstractly ("a bare numeric ID referring to an object in another system").
- **Merge first**: if a proposal overlaps an existing rule, propose a refinement of that rule instead of a new one.

### 4. Propose, then wait for approval

Present the result as a change list:

```
## Proposed rule changes
- [NEW] X1 Title: rule text, triggers, severity
- [EDIT] W2: add trigger "..."
- [EDIT] O1: add exception "..."
- [HIT] C2, O3 (no change)

## Skipped comments
- "<anchor text>": Specific (reason)
```

Never change `references/rules.md` without explicit approval. After approval, apply the changes, bump the version, and add one line to the changelog at the bottom of the rules file.

### 5. Keeping the rule base small

Every rule in `references/rules.md` is approved by Robin-Manuel. Rules are only removed or merged when he says so; note that in the changelog. IDs are never reused.

If the rule base grows beyond about 20 rules, propose merges in the next learning run. A short, sharp rule base gives better reviews than a long one.
