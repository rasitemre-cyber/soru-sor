create table if not exists public.soru_sor_state (
  id text primary key,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.soru_sor_state enable row level security;

drop policy if exists "soru_sor_state_select" on public.soru_sor_state;
create policy "soru_sor_state_select"
on public.soru_sor_state
for select
to anon, authenticated
using (true);

drop policy if exists "soru_sor_state_insert" on public.soru_sor_state;
create policy "soru_sor_state_insert"
on public.soru_sor_state
for insert
to anon, authenticated
with check (true);

drop policy if exists "soru_sor_state_update" on public.soru_sor_state;
create policy "soru_sor_state_update"
on public.soru_sor_state
for update
to anon, authenticated
using (true)
with check (true);

insert into public.soru_sor_state (id, payload)
values (
  'main',
  '{
    "teachers": [],
    "students": [],
    "pending": [],
    "questions": [],
    "notifs": {},
    "config": {
      "school": "",
      "kurumKodu": "",
      "days": 3,
      "autoDel": false
    },
    "schoolData": {
      "schoolName": "",
      "classes": []
    }
  }'::jsonb
)
on conflict (id) do nothing;
