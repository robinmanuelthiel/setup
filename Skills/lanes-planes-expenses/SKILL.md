---
name: lanes-planes-expenses
description: Automate travel expense drafts in Lanes & Planes (work travel booking and expensing system). Use when the user asks to file expenses, complete expense tickets, process trips, or search for receipts in Lanes & Planes. Supports both auto-scan (all open trips) and manual (specific trip) modes. Searches email for transport/hotel/accommodation receipts, files expense reposts and calculates per diem.
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
- **Expense location:** Under "Tickets" (not a separate expenses section). URL: https://api.lanes-planes.com/org_admin/travel/bookings?filter%5Btiming%5D=past
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
- Identify which bookings belong to the same trip based on the purpose or way of transport
- **Deduplicate:** Multiple bookings with same dates + same purpose = one travel period

### Step 2: Search Email for Receipts

Use the Personal E-Mail Inbox (robin-manuel@thiel1.de) and the Work E-Mail Inbox (robin-manuel.thiel@jtl-software.com) to search for expenses that could be assiciated to the trips, because they happend in the same time period. Search for receipts that could be associated with the trip, such as transport, accommodation, and other travel-related expenses.

**MUST search both inboxes for every trip.** Only write a "Missing expenses" entry after actually searching. Each missing entry must state what was searched and not found, e.g.: "Uber to ZRH (Dec 11) – searched both inboxes for Uber/taxi Dec 10-12, not found."

**Filter for:**

- Railway (Deutsche Bahn, SBB, train tickets)
- Taxi (Uber / Taxi / FreeNow rides)
- Car Sharing (Miles / Car2Go / ShareNow rides)
- Accommodation (Hotel, Airbnb)
- Flights (Lufthansa, Swiss, Eurowings, EasyJet, etc.)

**Ignore:**

- Meal receipts (never file meals)
- Personal purchases unrelated to travel

### Obtaining the real receipt PDF

For each expense found in email, you need the **actual receipt PDF** -- not a screenshot of the email. How to get it:

**Uber:**
- Uber emails contain a **"Download the receipt in a PDF format" / "Download PDF"** link in the email body.
- Open the email in Outlook web (use the email's WebLink URL from the Graph API search result), find this button, and click it to download the PDF.
- Outlook SafeLinks (eur02.safelinks.protection.outlook.com) do **not expire** -- these links are valid indefinitely.
- If a SafeLink fails or the Uber session requires login, fall back to the **Uber website**: https://riders.uber.com/trips -- find the trip by date and download the receipt PDF from there.
- Do NOT upload the HTML email body or a screenshot as the receipt. Only the PDF from the "Download PDF" button is valid.

**MILES / Car Sharing:**
- MILES sends a PDF invoice as an email attachment. Download the attachment directly from the email.

**Deutsche Bahn / SBB:**
- Train tickets are typically PDF attachments or can be downloaded from the DB/SBB booking confirmation email.

**Hotels:**
- If booked via Lanes & Planes, no separate receipt needed (the booking IS the record).
- If booked independently (Airbnb, booking.com), the confirmation email PDF or invoice attachment is the receipt.

### Step 3: Write an Trip and Expense Report

For each trip, write a summary report of the trip and the identified expenses, including:

- Name of the trip
- Start and end dates
- List of associated Lanes & Planes Bookings with Links
- Identification of the main Lanes & Planes booking to attach expenses to
- List of identified expenses for the trip (including Per Diem) with status
- List of missing expenses/legs that could not be identified (e.g., travel to the airport/train station, last mile to the office)

Think about all possible legs of the trip and identify those, that are not covered by a Lanes & Planes booking yet. Typical legs include:

- Travel from home to the airport/train station (typically Uber)
- Travel from the airport/train station to the destination (typically Miles, Uber, Taxi, Public Transport)
- Trips at the destination (from the office to the hotel, from the hotel to the restaurant, etc.) - If a rental car was booked (e.g., via Miles), these legs are typically covered by the rental car, so no additional expenses should be expected for these legs.
- Travel from the destination to the airport/train station (typically Miles, Uber, Taxi, Public Transport)
- Travel from the airport/train station to home (typically Uber)

### Step 3: Draft Expense Ticket

**In Lanes & Planes:**

1. For each trip, identify one main booking to add the additional expenses to
2. Open the main booking and add expenses ("Auslagen") line items of the following types to this booking:
   - **Auslagenbeleg:** One line per receipt found (attach/upload receipts if possible)
   - **Per Diem (Verpflegungsmehraufwand):** One line for entire travel period, assume no meals provided
   - **Kilometerpauschale:** Only use this, if there is a leg with my personal car involed. (unlikely)
4. Write an expense report (see below)
5. **DO NOT SUBMIT** - Leave as draft for Robin-Manuel to review

### Step 4: Write an Expense report

For each trip, write a summary report of the expenses, including:

- Name of the trip
- Start and end dates
- List of associated Lanes & Planes Bookings with Links
- Identification of the main Lanes & Planes booking to attach expenses to
- List of identified expenses for the trip (including Per Diem) with status
- List of missing expenses/legs that could not be identified (e.g., travel to the airport/train station, last mile to the office)

Report format:

```
✅ Processed [Trip Name + Dates]
   Included Bookings:
   - [Booking A + Link] (main)
   - [Booking B + Link]
   Expenses found: Z
   - 🚧 [Receipt 1 details] - Warning: PDF could not be uploaded
   - ✅ [Receipt 2 details]
   - ❌ [Receipt 3 details]
   - ✅ [Per diem details - €X (Y days)]
   Missing expenses:
   - Travel to the ZRH airport – searched both inboxes for Uber/taxi on [date], not found
   - Last mile from CGN airport to the destination – searched both inboxes for Uber/taxi/MILES on [date], not found
   Status: Draft created (not submitted)

🔍 Searched [Date Range] in email
   Found: [Count] transport/hotel receipts
```

If multiple trips, summarize each.

## Uploading Receipt PDFs to Lanes & Planes

The L&P expense form uses a **Dropzone.js** drag-and-drop widget that cannot be automated via standard browser file input methods. Use the following approach instead:

### Working Upload Method (Active Storage Direct Upload)

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
   Get `FILE_SIZE` and `BASE64_MD5` from the local PDF file via exec/shell.

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

### Notes
- The edit page URL for an expense is: `https://api.lanes-planes.com/org_admin/travel/bookings/[BOOKING_ID]/receipt_entity/profiles/[EXP_ID]/edit`
- The view page (to confirm upload success) is the same without `/edit`
- After save, a "Scan" section appears on the view page showing the uploaded PDF

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

## Important notes

- **Critical: Never Auto-Submit** - Always leave expense tickets as drafts. Robin-Manuel reviews and submits ("einreichen") manually.
- Hotels, Flights and Trains booked via Lanes and Planes and represented in an existing Lanes & Planes booking don't require an extra receipt to be uploaded or attached. If a receipt for a one of those bookings is found in the E-Mails, it can be ignored.
- My Home Address is "Wasserwerkstrasse 16, 8006 Zurich, Switzerland". If a trip location or leg location is this address, refer to it as "Home" in the expense reports
