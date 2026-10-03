# Ledgerly Budget Tracker

A personal daily budget tracker powered by Supabase.

## Expense Sheets setup

Expense Sheets let each user create custom named sheets (for example, a trip, renovation, or event), set an optional budget, and assign new expense transactions to a sheet. Income cannot be assigned to a sheet.

1. In your Supabase project, open the SQL Editor.
2. Run the SQL in `supabase/expense_sheets.sql`.
3. Deploy the updated `index.html`.

The migration creates private, user-owned expense sheets and adds an optional `expense_sheet_id` field to transactions. Existing transactions remain unchanged.
