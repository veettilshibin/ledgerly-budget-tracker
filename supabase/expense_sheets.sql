-- Run this migration in the Supabase SQL Editor before deploying the Expense Sheets UI.

create table if not exists public.expense_sheets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (char_length(trim(name)) between 1 and 80),
  budget numeric(12,2) check (budget is null or budget >= 0),
  created_at timestamptz not null default now()
);

alter table public.transactions
  add column if not exists expense_sheet_id uuid references public.expense_sheets(id) on delete set null;

create index if not exists expense_sheets_user_id_idx on public.expense_sheets(user_id);
create index if not exists transactions_expense_sheet_id_idx on public.transactions(expense_sheet_id);

alter table public.expense_sheets enable row level security;

create policy "Users can view their own expense sheets"
  on public.expense_sheets for select
  using (auth.uid() = user_id);

create policy "Users can create their own expense sheets"
  on public.expense_sheets for insert
  with check (auth.uid() = user_id);

create policy "Users can update their own expense sheets"
  on public.expense_sheets for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users can delete their own expense sheets"
  on public.expense_sheets for delete
  using (auth.uid() = user_id);
