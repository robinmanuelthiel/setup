---
name: lanes-planes-expenses
description: Automate travel expense drafts in Lanes & Planes (Blenzen & Blenzen expense system). Use when Robin-Manuel asks to file expenses, complete expense tickets, process trips, or search for receipts in Lanes & Planes. Supports both auto-scan (all open trips) and manual (specific trip) modes. Searches email for transport/hotel receipts and calculates per diem.
---

# Lanes & Planes Expense Automation

Automate drafting travel expenses in Lanes & Planes by:
1. Finding open trips (auto-scan or user-specified)
2. Calculating per diem (Mehrkostenpauschale)
3. Searching email for transport/hotel receipts
4. Drafting expense ticket (never auto-submit)

## Access

- **URL:** https://app.lanes-planes.com/
- **Login:** Email + SSO
- **Expense location:** Under "Tickets" (not a separate expenses section)
- **Email receipts:** Personal mailbox (robin-manuel@thiel1.de)

## Two Modes

### Mode 1: Auto-Scan

User says: "Process my open expenses" or "Complete my travel expenses"

1. Open Lanes & Planes
2. Navigate to Tickets
3. Find all trips without completed expense tickets
4. Process each trip (see workflow below)

### Mode 2: Specific Trip

User says: "File expenses for my Berlin trip" or "Complete the January 15th trip"

1. Open Lanes & Planes
2. Find the matching trip(s) by date/destination
3. Process that trip (see workflow below)

## Workflow Per Trip

### Step 1: Identify Travel Period

- Read trip start/end dates
- Check "Zweck der Reise" field
- **Deduplicate:** Multiple bookings with same dates + same purpose = one travel period
- Calculate per diem using [per-diem-rates.md](references/per-diem-rates.md)

### Step 2: Search Email for Receipts

Use `office365-connector` with `--account=personal`:

```bash
# Search date range around trip
node ~/.openclaw/workspace/skills/office365-connector/list-emails.js \
  --account=personal \
  --folder=inbox \
  --from="YYYY-MM-DD" \
  --to="YYYY-MM-DD" \
  --search="Bahn OR Uber OR Miles OR Taxi OR Hotel"
```

**Filter for:**
- Bahn (Deutsche Bahn, train tickets)
- Uber / Taxi / Miles (rides)
- Hotel (accommodation)

**Ignore:**
- Meal receipts (never file meals)
- Personal purchases unrelated to travel

### Step 3: Draft Expense Ticket

In Lanes & Planes:

1. Open the trip booking
2. Create new expense ticket (or find existing draft)
3. Add line items:
   - **Per Diem (Mehrkostenpauschale):** One line for entire travel period
   - **Transport/Hotel:** One line per receipt found
4. Attach receipts if possible (email PDF attachments)
5. **DO NOT SUBMIT** - Leave as draft for Robin-Manuel to review

## Browser Automation Notes

**Expect timeouts.** Lanes & Planes can be slow. When timeouts occur:
- Retry the action
- Use direct URLs when possible
- Reduce actions per page
- Continue with workarounds rather than stopping

**Prefer:**
- Direct navigation to ticket/booking URLs
- Fewer clicks per page
- Waiting for explicit UI state changes

**Avoid:**
- Complex multi-step sequences without checkpoints
- Waiting for arbitrary timeouts
- Assuming instant page loads

## Output Format

Report back:
```
✅ Processed [Trip Name/Dates]
   Per Diem: €X (Y days)
   Receipts found: Z
   - [Receipt 1 details]
   - [Receipt 2 details]
   Status: Draft created (not submitted)

🔍 Searched [Date Range] in email
   Found: [Count] transport/hotel receipts
```

If multiple trips, summarize each.

## Never Auto-Submit

**Critical:** Always leave expense tickets as drafts. Robin-Manuel reviews and submits ("einreichen") manually.
