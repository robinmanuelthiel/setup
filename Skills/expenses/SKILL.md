---
name: expenses
description: Automate travel expense drafts in Lanes & Planes (work travel booking and expensing system). Use when the user asks to file expenses, complete expense tickets, process trips, or search for receipts in Lanes & Planes. Supports both auto-scan (all open trips) and manual (specific trip) modes. Searches email for transport/hotel/accommodation receipts, files expense reposts and calculates per diem.
---

# Lanes & Planes Expense Automation

Automate drafting travel expenses in Lanes & Planes by:

1. Finding and grouping open trips (auto-scan or user-specified)
2. Calculating per diem (Mehrkostenpauschale)
3. Searching email for transport/hotel receipts or invoices associated with the trips
4. Adding the additional expenses to the trips
5. Create a detailed expense report summarizing the process, identified expenses, and missing legs/expenses

## Access

- **URL:** https://app.lanes-planes.com/
- **Login:** Email + SSO
- **Expense filing location:** Under "Tickets" (not a separate expenses section). URL: https://api.lanes-planes.com/org_admin/travel/bookings?filter%5Btiming%5D=past

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

### Step 1: Identify Travel Period and associated bookings

Single trips can consist of multipe bookings ("Buchungen"), as transport and accommodation can be booked individually.

- Read and identify trip start/end dates
- Check the purpose of the trip ("Zweck der Reise") field
- Identify which bookings belong to the same trip based on the purpose or way of transport
- **Deduplicate:** Multiple bookings with same dates + same purpose = one travel period
- Identify one main booking per trip to attach expenses to (typically the one with the most comprehensive travel details, e.g., flight or hotel booking)

### Step 2: Draft an Expense Report for each trip

Create a new document to track the status for the session.

For each trip, the expense report includes:

- Name of the trip
- Start and end dates
- List of associated Lanes & Planes Bookings with Links
- Identification of the main Lanes & Planes booking to attach expenses to
- List of identified expenses for the trip (including Per Diem) with status
- List of potentially missing expenses/legs that could not be identified (e.g., travel to the airport/train station, last mile to the office)

### Step 3: Search Email for Receipts

Use access to my E-Mail to search for expenses that could be associated to the trips, because they happend in the same time period. Search for receipts that could be associated with the trip, such as transport, accommodation, and other travel-related expenses but include 30 days before and after the trip dates in your search to account for early bookings and late receipts.

**MUST search both inboxes for every trip.** Only write a "Missing expenses" entry after actually searching. Each missing entry must state what was searched and not found.

**Search for:**

- Railway (Deutsche Bahn, SBB, train tickets)
- Taxi (Uber / Taxi / FreeNow rides)
- Car Sharing (Miles / Car2Go / ShareNow rides)
- Accommodation (Hotel, Airbnb)
- Flights (Lufthansa, Swiss, Eurowings, EasyJet, etc.)

**Ignore:**

- Meal receipts (never file meals)
- Personal purchases unrelated to travel

#### Obtaining the real receipt PDF

If not already uploaded to a Lanes & Planes expense ticket, a receipt or invoice must be obtained for each identified expense. This is critical for compliance and audit purposes. In this step, the receipt should not be uploaded yet. This step comes later.

**Hard requirement:** Only upload a **real, provider-issued PDF receipt**. Never use:
- screenshots (browser or email)
- "Print to PDF" output of an email/webpage
- HTML-to-PDF conversions of email bodies

If you cannot obtain a real PDF, **do not upload a substitute**. Leave the expense as draft and document it under **Missing expenses** (including what you searched and where).

**Uber (preferred):**
- Use the Uber Riders portal: https://riders.uber.com/trips
- Open the correct trip by date/time, click **Download PDF** on the trip details page.
- If starting from an email: you may click the email's **"Download the receipt in a PDF format" / "Download PDF"** link, but still apply the validation checklist above.
- If the link fails or requires login, fall back to the Riders portal.

**MILES / Car Sharing:**
- Prefer the **PDF invoice attachment** in the email. Download the attachment directly.

**Deutsche Bahn / SBB:**
- Train tickets are typically **PDF attachments** or can be downloaded from the booking confirmation.

**Hotels:**
- If booked via Lanes & Planes: usually no extra receipt upload needed (the booking is the record).
- If booked independently (Airbnb, booking.com): use the **invoice/receipt PDF** (attachment or portal download), not a screenshot.

**Important:** When downloading a file, rename it to a descriptive name including the vendor, date and amount in this format: `<date>-<vendor>-<location>-<currency><amount>.pdf` (e.g., `2026-01-16-uber-zurich-chf20.25.pdf`).

### Step 4: Update the expense report with identified expenses and missing legs

Update the expense report created in the previous steps. List all expenses and their status for each booking.

Think about all possible legs of the trip and identify those, that are not covered by a Lanes & Planes booking yet. Typical legs include:

- Travel from home to the airport/train station (typically Uber)
- Travel from the airport/train station to the destination (typically Miles, Uber, Taxi, Public Transport)
- Trips at the destination (from the office to the hotel, from the hotel to the restaurant, etc.) - If a rental car was booked (e.g., via Miles), these legs are typically covered by the rental car, so no additional expenses should be expected for these legs.
- Travel from the destination to the airport/train station (typically Miles, Uber, Taxi, Public Transport)
- Travel from the airport/train station to home (typically Uber)

### Step 5: Draft Expense Line items

Now it's time to add the identified expenses to the main booking in Lanes & Planes as line items. Each line item should have the correct type (Auslagenbeleg, Per Diem, Kilometerpauschale) and be attached to the main booking for the trip. **Upload** the receipts for each expense line item where possible.

**In Lanes & Planes:**

1. For each trip, identify one main booking to add the additional expenses to
2. Open the main booking in Lanes & Planes and add expenses ("Auslagen") line items of the following types to this booking:
   - **Auslagenbeleg:** One line per receipt found (attach/upload receipts if possible)
   - **Per Diem (Verpflegungsmehraufwand):** One line for entire travel period, assume no meals provided
   - **Kilometerpauschale:** Only use this, if there is a leg with my personal car involed. (unlikely)
4. Write an expense report (see below)
5. **DO NOT SUBMIT** - Leave as draft for a human to review

### Step 6: Update the Expense report

Update the expense report created in the previous steps again. For each identified expense, update the status including the receipt upload status.

## Expense report format

```markdown
## Trip <NUMNER>: <NAME> <LOCATION> <DATES>

**Travel period:** <START_DATE> - <END_DATE>

### Associated Bookings

| ID | Type | Description | Date | Link |
|----|------|-------------|------|------|
| <ID> (main)| <TYPE> | <FROM> - <TO> | <DATE>> | [View](https://api.lanes-planes.com/org_admin/travel/bookings/<MAIN_ID>) |
| <ID> | <TYPE> | <FROM> - <TO> | <DATE>> | [View](https://api.lanes-planes.com/org_admin/travel/bookings/<ANOTHER_ID>) |

### Expenses

- [ ] <STATUS_EMOJI> [Per Diem - <CURRENCY> <AMOUNT>](https://api.lanes-planes.com/org_admin/travel/bookings/<MAIN_ID>/receipt_entity/profiles/<EXPENSE_ID>)
- [ ] <STATUS_EMOJI> [<TYPE> Reciept - <DATE> - <CURRENCY> <AMOUNT>](https://api.lanes-planes.com/org_admin/travel/bookings/<MAIN_ID>/receipt_entity/profiles/<EXPENSE_ID>) - _<COMMENT>_

### Missing expenses

- [ ] <EXPENSE_DESCRIPTION> - searched for <SEARCH_TERMS> on <DATE_RANGE> - _<Comment>_
```

Valid `<STATUS_EMOJI>` values are:

- 📋 Reciept found but not uploaded
- ❌ No reciept found or other error
- ✅ Reciept found and not uploaded

**Important:** Leave all check-boxes unchecked, even for completed expenses. This is a visual indicator that the expense still needs to be reviewed and submitted by a human. The checkboxes are only for tracking the status of the expense by a human.

**Example:**

```markdown
## Trip 1: Foo Conference Berlin Jan 15-17 2026

**Travel period:** Jan 15 - Jan 17 2026

### Associated Bookings

| ID | Type | Description | Date | Link |
|----|------|-------------|------|------|
| 1234567 (main)| Flight | ZRH - BER | Jan 15, 2026 | [View](https://api.lanes-planes.com/org_admin/travel/bookings/1234567) |
| 2345678 | Car Rental | Enterprise CGN -> DUS | Jan 15-17, 2026 | [View](https://api.lanes-planes.com/org_admin/travel/bookings/2345678) |
| 3456789 | Hotel + Flight | Enterprise CGN -> DUS | Jan 15-17, 2026 | [View](https://api.lanes-planes.com/org_admin/travel/bookings/2345678) |

### Expenses

- [ ] ✅ Per Diem - €28 (3 days) [View](https://api.lanes-planes.com/org_admin/travel/bookings/1234567/receipt_entity/profiles/9876543)
- [ ] 🚧 Taxi Reciept - Jan 15, 2026 - €35 [View](https://api.lanes-planes.com/org_admin/travel/bookings/1234567/receipt_entity/profiles/8765432) - _Receipt `2026-01-16-uber-zurich-chf20.25.pdf` could not be uploaded_
- [ ] ❌ Taxi Receipt - _Found in E-Mail but no receipt available_

### Missing expenses

- [ ] Transport from Home to the ZRH airport - searched for Uber/taxi/MILES receipts on Jan 1 - Jan 30 2026 - _nothing found_
- [ ] Transport from the BER airport to the destination - searched for Uber/taxi/MILES receipts on Jan 1 - Jan 30 2026 - _not found_
```

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

**Uploading Receipt PDFs to Lanes & Planes:**

The Lanes & Planes expense form uses a **Dropzone.js** drag-and-drop widget that cannot be automated via standard browser file input methods. Use the following approach instead:

Working Upload Method (Active Storage Direct Upload):

1. **Create a direct upload blob** -- from within the browser page context (using `fetch` with session credentials):
   ```js
   const resp = await fetch('https://api.lanes-planes.com/rails/active_storage/direct_uploads', {
     method: 'POST',
     headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': CSRF_TOKEN },
     credentials: 'include',
     body: JSON.stringify({ blob: {
       filename: 'receipt.pdf',
       content_type: 'application/pdf',
       byte_size: FILE_SIZE,       // bytes
       checksum: BASE64_MD5        // openssl dgst -md5 -binary file | base64
     }})
   });
   const { signed_id, direct_upload } = await resp.json();
   ```
   Get `CSRF_TOKEN` from `document.querySelector('meta[name=csrf-token]').content`.

   Before uploading, **validate you have a real PDF receipt** (not a screenshot, not an email printout):
   ```sh
   file -b receipt.pdf          # should mention PDF
   head -c 5 receipt.pdf        # should print %PDF-
   ```

   Always use a **freshly obtained** receipt PDF for the specific expense (do not reuse old files from previous runs).

   Get `FILE_SIZE` and `BASE64_MD5` from the local PDF file via exec/shell:
   ```sh
   FILE_SIZE=$(stat -f%z receipt.pdf)
   BASE64_MD5=$(openssl dgst -md5 -binary receipt.pdf | base64)
   ```

2. **PUT the PDF bytes** to `direct_upload.url` -- from terminal (no auth required):
   ```sh
   curl -X PUT -H "Content-Type: application/pdf" --data-binary @receipt.pdf "<direct_upload.url>"
   # Expects HTTP 204
   ```

3. **Inject the `signed_id`** into the form and save -- from browser page context:
   ```js
   document.querySelector('input[name="receipt_entity_profile[uploads][]"]').value = signed_id;
   document.querySelector('button[type=submit]').click();
   ```

Notes:

- The edit page URL for an expense is: `https://api.lanes-planes.com/org_admin/travel/bookings/[BOOKING_ID]/receipt_entity/profiles/[EXP_ID]/edit`
- The view page (to confirm upload success) is the same without `/edit`
- After save, a "Scan" section appears on the view page showing the uploaded PDF

## Important notes

- **Critical: Never Auto-Submit** - Always leave expense tickets as drafts. A human reviews and submits ("einreichen") manually.
- Hotels, Flights and Trains booked via Lanes and Planes and represented in an existing Lanes & Planes booking don't require an extra receipt to be uploaded or attached. If a receipt for a one of those bookings is found in the E-Mails, it can be ignored.

## Personalization

- My Login to Lanes & Planes is via SSO with the email `robin-manuel.thiel@jtl-software.com`
- Reciepts can be found in the Personal mailbox (robin-manuel@thiel1.de) and Work inbox (robin-manuel.thiel@jtl-software.com)
- Expense reports should be created in **Obsidian** under `01 Projects/` with the name `Expenses <DATE_RANGE>` (e.g., `Expenses Jan 1 - Mar 5 2026`)
- When searching for receipts in my E-Mail filter for the `Expenses` category in both inboxes, as all expenses are categorized with this category in my E-Mail. If you don't find receipts or invoices for missing legs, ask the human to also search the entire inbox without the `Expenses` category filter, as sometimes receipts are not categorized correctly.
- My Home Address is "Wasserwerkstrasse 16, 8006 Zurich, Switzerland". If a trip location or leg location is this address, refer to it as "Home" in the expense reports
- If the currency is CHF, the country ("Land") is Switzerland ("Schweiz").
