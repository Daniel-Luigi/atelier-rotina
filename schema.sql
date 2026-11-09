-- ATELIER: execute este SQL no Supabase > SQL Editor > New query.
create table if not exists public.atelier_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.atelier_data enable row level security;
revoke all on table public.atelier_data from anon, authenticated;
grant select, insert, update, delete on table public.atelier_data to authenticated;

drop policy if exists "Users can read their own ATELIER data" on public.atelier_data;
create policy "Users can read their own ATELIER data"
  on public.atelier_data for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own ATELIER data" on public.atelier_data;
create policy "Users can create their own ATELIER data"
  on public.atelier_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own ATELIER data" on public.atelier_data;
create policy "Users can update their own ATELIER data"
  on public.atelier_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own ATELIER data" on public.atelier_data;
create policy "Users can delete their own ATELIER data"
  on public.atelier_data for delete to authenticated
  using ((select auth.uid()) = user_id);
