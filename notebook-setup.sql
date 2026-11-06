-- Run this once in the Supabase SQL Editor.
-- Public notebook entries are separate from public.notes.
-- Private notebook entries are shared with the cat site through public.notes.
-- Run the cat site's supabase-setup.sql first to configure public.notes and site_admins.

create table if not exists public.notebook_notes (
    id uuid primary key,
    title text not null default 'Untitled',
    content text not null default '',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

alter table public.notebook_notes enable row level security;
revoke all on public.notebook_notes from public, anon, authenticated;
grant select, insert, update, delete on public.notebook_notes to anon;

drop policy if exists "Public notebook access" on public.notebook_notes;
create policy "Public notebook access"
on public.notebook_notes
for all
to anon
using (true)
with check (true);
