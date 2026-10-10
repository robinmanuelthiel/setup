# Review rules

Version: 4
Last updated: 2026-10-08

## How this file works

Rules are grouped by principle. Every rule uses the same fields, so learning mode can edit them safely:

- **ID**: principle letter + number. IDs are never reused, even after a rule is removed.
- **Severity**: default severity. A rule may say when to raise it.
- **Rule**: the expectation, in one or two sentences.
- **Why**: the consequence when it is broken.
- **Triggers when**: abstract occurrences in a document that break the rule.
- **Does not trigger when**: known exceptions.

Severity levels:

- **Blocker**: the document leads readers to a wrong action, or hides a design flaw.
- **Major**: a reader cannot understand, trust, or maintain the content.
- **Minor**: friction for the reader, but the content is still usable.

## Principles

- **C: Context first.** Readers arrive cold. They know nothing that was said in meetings, chats, or other documents.
- **W: Why over what.** The WHAT is often visible in code or configuration. The WHY and the WHERE are not.
- **O: Once and only once.** Every fact lives in exactly one place. Copies drift.

---

## C: Context first

### C1 Overview and context before details
- **Severity**: major
- **Rule**: Before any details, the document states what it covers, why it exists, who it is for, and the setup it builds on (systems, tools, teams, earlier decisions). It assumes no knowledge from verbal agreements or other sources.
- **Why**: Authors forget what they know. Readers without that context misread everything that follows.
- **Triggers when**:
  - The document opens with configuration, steps, tables, or code without saying what the thing is and why it exists.
  - A system, tool, or team plays a central role but its role in the overall setup is never explained.
  - A decision is presented as given ("we use X", "as agreed", "as discussed") without stating the decision, its reason, or a link to where it was made.
  - Phrases that assume shared history: "as usual", "the known issue", "the old approach".
  - The document's stated purpose ("enough to rebuild", "runbook") is not actually met by its content.
- **Does not trigger when**: the concept is common knowledge for the stated audience (for example "Git" or "DNS" for engineers).

### C2 Introduce before you reference
- **Severity**: minor
- **Rule**: Every term, object, or concept gets a short introduction at its first mention. Definite references ("the X") are only used after that.
- **Why**: "The X" signals "you already know this". If the reader doesn't, they search the page or guess.
- **Triggers when**:
  - "The X" appears before X is described anywhere earlier in the document.
  - A term is explained later in the document than its first use.
  - An abbreviation is used without its long form on first use.
  - A specific-sounding name ("the sync job", "the gateway rule") is used as if known, with no description.
- **Does not trigger when**: the term is introduced in a linked prerequisite document that the document explicitly says to read first.

### C3 Use the established vocabulary
- **Severity**: minor. Raise to major when readers could think two different things are meant.
- **Rule**: Use the names the organization already uses for systems, components, teams, and roles. Use one name per thing in the whole document.
- **Why**: A new or generic name makes readers believe it is a different, unknown thing.
- **Triggers when**:
  - A component is described with a generic phrase ("the deployment software", "the backend service") where an established name likely exists.
  - The same thing is called by two or more names within the document.
  - A new name is invented for something that already has one.
- **Does not trigger when**: no established name exists. If unsure, ask the author: "Is there an existing name for this?"

---

## W: Why over what

### W1 Explain the WHY and the WHERE
- **Severity**: major
- **Rule**: The document may describe the WHAT, but it must never miss the WHY and the WHERE. The WHY is the reasoning behind decisions and the constraints that led to them. The WHERE is the exact place a thing is defined or configured.
- **Why**: Without the WHY, nobody can judge later if a decision still holds. Without the WHERE, nobody can find or change it.
- **Triggers when**:
  - A decision is stated without a reason ("X is disabled", "we chose Y").
  - The document describes the WHAT in detail (code, config, behavior) but never explains why it is built that way.
  - A setting or behavior is mentioned without the exact place it is configured: which system, which file, project, or menu, ideally with a link.
  - Alternatives that were obviously possible are not mentioned, and nothing says why they were rejected.
  - A text describes what something does, allows, or risks, but not why it was added or changed. Length is no indicator: a long explanation can still miss the WHY.
  - Something is added on top of a standard (built-in role, default setting, template, library), and the text doesn't say why the standard is not enough.
  - Configuration was done by hand in a UI (admin portal, SaaS tool) and exists nowhere in versioned code. Here the document is the only record of the WHAT. Check two things: (1) the WHAT is described completely enough to rebuild it (all relevant settings, not only some), and (2) the finding asks whether this configuration should move into code (infrastructure as code, API-driven provisioning).
- **Does not trigger when**: the reasoning is documented in a linked decision record.

### W2 Every chosen value needs a reason
- **Severity**: major
- **Rule**: Every chosen value (threshold, timeout, interval, limit, retry count, retention, size, percentage, schedule) states why this value. Deviations from vendor defaults, vendor recommendations, or common practice are explicitly called out and justified.
- **Why**: Unexplained values get copied, never questioned, and nobody dares to change them.
- **Triggers when**:
  - A value is stated without any reasoning ("timeout 30 s", "3 retries", "keep 90 days").
  - A value differs from the tool's documented default or recommendation and the document doesn't say so.
  - A value looks like an untouched default.
  - Two related values are set, but their combined effect is not explained.
- **Does not trigger when**: the value is set by an external source (contract, SLA, regulation, vendor limit) and that source is linked.

### W3 Every component justifies its existence
- **Severity**: major
- **Rule**: Every listed component, resource, secret, integration, role, or process step says what it is for.
- **Why**: Things without a stated purpose can neither be removed safely nor rebuilt correctly.
- **Triggers when**:
  - A secret, key, token, or service account is listed with its location but not its purpose.
  - A resource appears in a table or diagram but its role is never explained.
  - A process step produces something that is never used later.
- **Does not trigger when**: the purpose is obvious from a name and context that the audience fully understands.

### W4 No task without an owner
- **Severity**: major. Raise to blocker for incident, security, or data-loss paths.
- **Rule**: Everything that demands action (ticket, alert, task, approval, recurring job, runbook step) has a named owner: a person or team, linked.
- **Why**: Work without an owner is done by nobody.
- **Triggers when**:
  - "A ticket is created" or "an alert is sent" without assignee or responsible team.
  - "The team takes care of it" without saying which team or how it is reached.
  - Shared ownership ("A / B") without saying who decides.
- **Does not trigger when**: ownership is defined in a linked source (for example an on-call schedule).

---

## O: Once and only once

### O1 No repetition within the document
- **Severity**: minor. If the copies already differ, report it under O6 instead.
- **Rule**: Every fact, especially concrete values, appears once in the document. Other places refer to it.
- **Why**: When the fact changes, one copy gets updated and the other doesn't. The document then contradicts itself.
- **Triggers when**:
  - The same number or value appears in two or more places.
  - The same explanation appears in two sections in different words.
- **Does not trigger when**:
  - Values repeat inside a data table, where each row holds its own record. Rows in data tables are expected to repeat values.
  - Table cells repeat short labels so each row stays readable alone (see O4).
- **Related**: values in overviews and summaries are covered by O5.

### O2 Single source of truth across documents
- **Severity**: major
- **Rule**: Facts owned by another document, system, or repository are linked or embedded, never copied. Definitions (teams, groups, members, policies, rules, schedules) are referenced at their source.
- **Why**: Copies across documents drift silently, and nobody knows which one is right.
- **Triggers when**:
  - Values, lists, or procedures appear that are also maintained elsewhere (config file, other page, tool).
  - Team members, on-call rotations, or contact lists are written out.
  - Text is copied from vendor documentation instead of linked.
  - A team, group, or role is referenced without pointing to where it is defined.
- **Does not trigger when**: content is embedded with a mechanism that stays in sync (page include, excerpt, live link to a versioned file).
- **Extra check**: if the source of truth is a system the audience probably cannot access (admin portal, secret store, licensed tool), flag it so the author adds a short pointer readers can follow.

### O3 Every external identifier is linked, named, or explained
- **Severity**: minor
- **Rule**: Every identifier that points to something existing elsewhere (ticket key, rule or policy ID, resource ID, group ID, connection or integration name, version number, person) is linked, or at least named and explained. The reader must know what it is and how to reach it.
- **Why**: A bare ID only helps the person who already knows what it is.
- **Triggers when**:
  - Bare numbers in parentheses or after a name ("(4711)", "#123").
  - Ticket keys or pull request numbers without a link.
  - Quoted names of objects in a tool, without saying what kind of object it is.
  - Resource paths or GUIDs without saying what resource they identify.
  - People mentioned by name without a mention or profile link.
- **Does not trigger when**: the identifier is purely illustrative (example values in a how-to).

### O4 Table rows stand on their own
- **Severity**: minor
- **Rule**: Every table row is understandable without reading other rows. No references based on position.
- **Why**: Tables get sorted, filtered, and read row by row. Position-based references then point to the wrong thing.
- **Triggers when**:
  - Cells like "same as above", "see previous row", "same place", "ditto".
  - Empty cells meaning "same as the row above".
  - Wording that depends on order ("the former", "next one").
- **Does not trigger when**: rows are grouped by a merged cell that clearly spans them.

### O5 Overviews contain no changeable values
- **Severity**: minor. Raise to major if the overview is the part most readers will rely on (executive summary, TL;DR).
- **Rule**: Overviews, summaries, and introductions say THAT something happens, not HOW MUCH. Concrete values that can change over time (intervals, thresholds, timeouts, limits, versions, counts) live only in the detail section, usually a table or config reference. Overviews describe, details quantify.
- **Why**: People update the value in the detail table and forget the summary. The summary is what most readers read, so they get the outdated value.
- **Triggers when**:
  - An overview, summary, or timeline states configuration values that also appear (or should appear) in a detail section.
  - A summary uses a value in words ("once per minute", "after five minutes") that is configured somewhere else.
- **Does not trigger when**: the value is a stable target or commitment that defines the subject (SLA, RTO, RPO, contractual limit), not a configuration setting. Those may appear in the overview, with a link to their source.

### O6 Facts stay consistent
- **Severity**: major. Raise to blocker if the contradiction could lead a reader to a wrong action.
- **Rule**: Every fact has the same value and meaning wherever the document touches it, including values written in words, derived values, and names.
- **Why**: A contradiction means at least one statement is wrong, and the reader can't tell which. Trust in the whole document drops.
- **Triggers when**:
  - The same value is stated differently in two places ("once per minute" in the summary, "30 s" in the config table).
  - A derived value doesn't match its inputs (a sum, a total time, a percentage that doesn't add up).
  - Units or time zones differ for the same value without conversion.
  - The same object has different names, versions, or owners in different sections.
  - A statement contradicts a linked source the reviewer can check.
- **Does not trigger when**: the difference is intentional and explained (for example different values per environment).
- **Note**: O1 and O5 prevent most O6 violations. O6 is the safety net when they were not followed.

---

## Changelog

- v1 (2026-10-07): initial rule base from the first manual review and principles stated by Robin-Manuel. Rules: C1, C2, C3, W1, W2, W3, W4, O1, O2, O3, O4.
- v2 (2026-10-07): W1 now allows the WHAT but requires WHY and WHERE, with detailed checks for UI-only configuration. W4 simplified to "No task without an owner". O1 exempts data tables and hands overview cases to O5 and drift cases to O6. New rules: O5 (overviews contain no changeable values), O6 (facts stay consistent).
- v3 (2026-10-07): removed Status and Evidence fields. Every rule in this file is approved by Robin-Manuel.
- v4 (2026-10-08): learning run on a PR review (infrastructure code comment). W1 gets two triggers: text that explains WHAT or risk but not WHY, and additions on top of a standard without saying why the standard is not enough. Skill scope extended to code comments and pull requests.
