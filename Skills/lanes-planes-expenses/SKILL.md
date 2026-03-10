---
name: lanes-planes-expenses
description: Automate travel expense drafts in Lanes & Planes (Blenzen & Blenzen expense system). Use when Robin-Manuel asks to file expenses, complete expense tickets, process trips, or search for receipts in Lanes & Planes. Supports both auto-scan (all open trips) and manual (specific trip) modes. Searches email for transport/hotel receipts and calculates per diem.
---

# Lanes & Planes Expense Automation

Automate drafting travel expenses in Lanes & Planes by:
1. Finding and grouping open trips (auto-scan or user-specified)
2. Calculating per diem (Mehrkostenpauschale)
3. Searching email for transport/hotel receipts
4. Adding additional expenses associated to the trips
5. Drafting expense report (never auto-submit)

## Access

- **URL:** https://app.lanes-planes.com/
- **Login:** Email + SSO (robin-manuel.thiel@jtl-software.com)
- **Expense location:** Under "Tickets" (not a separate expenses section)
- **Email receipts:** Personal mailbox (robin-manuel@thiel1.de) and Work inbox (robin-manuel.thiel@jtl-software.com)

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

### Step 1: Identify Travel Period and associated Trips

Single trips can consist of multipe bookings ("Buchungen"), as transport and accommodation can be booked individually.

- Read and identify trip start/end dates
- Check "Zweck der Reise" field
- **Deduplicate:** Multiple bookings with same dates + same purpose = one travel period

### Step 2: Search Email for Receipts

Use the Personal E-Mail Inbox (robin-manuel@thiel1.de) and the Work E-Mail Inbox (robin-manuel.thiel@jtl-software.com) to search for expenses that could be assiciated to the trips.

**Filter for:**

- Railway (Deutsche Bahn, SBB, train tickets)
- Taxi (Uber / Taxi / FreeNow rides)
- Car Sharing (Miles / Car2Go / ShareNow rides)
- Accommodation (Hotel, Airbnb)

**Ignore:**

- Meal receipts (never file meals)
- Personal purchases unrelated to travel

### Step 3: Draft Expense Ticket

**In Lanes & Planes:**

1. For each trip, identify one main booking to add expenses to
2. Create new expense ticket (or find existing draft) for each expense ("Auslagen") in this booking
3. Add line items:
   - **Per Diem (Verpflegungsmehraufwand):** One line for entire travel period, assume no meals provided
   - **Auslagenbeleg:** One line per receipt found (attach/upload receipts if possible)
4. Create an expense report (see below)
5. **DO NOT SUBMIT** - Leave as draft for Robin-Manuel to review

**Expense report:**

- Name of the trip
- List of associated Lanes & Planes Bookings with Links
- Link of the main Lanes & Planes booking to attach expenses to
- List of identified expenses for the trip (including Per Diem) with status
- List of missing expenses/legs (e.g., travel to the airport/train station, last mile to the office)

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
   Included Bookings:
   - [Booking A + Link] (main)
   - [Booking B + Link]
   Expenses found: Z
   - 🚧 [Receipt 1 details] - PDF could not be uloaded
   - ✅ [Receipt 2 details]
   - ❌ [Receipt 3 details]
   - ✅ [Per diem detials - €X (Y days)]
   Missing expenses:
   - Travel to the ZRH airport
   - Last mile from CGN airport to the destination
   Status: Draft created (not submitted)

🔍 Searched [Date Range] in email
   Found: [Count] transport/hotel receipts
```

If multiple trips, summarize each.

## Never Auto-Submit

**Critical:** Always leave expense tickets as drafts. Robin-Manuel reviews and submits ("einreichen") manually.
