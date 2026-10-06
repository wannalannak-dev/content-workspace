-- =========================================================
-- Content Workspace — ตั้งค่าฐานข้อมูล Supabase
-- วิธีใช้: Supabase > SQL Editor > New query > วางทั้งไฟล์ > Run
-- (แก้อีเมลทีมในส่วนท้ายไฟล์ก่อนกด Run)
-- =========================================================

-- 1) รายชื่ออีเมลที่มีสิทธิ์เข้าใช้งาน (เก็บเป็นตัวพิมพ์เล็ก)
create table if not exists public.team_members (
  email      text primary key check (email = lower(email)),
  name       text,
  created_at timestamptz not null default now()
);

-- 2) คอนเทนต์
create table if not exists public.contents (
  id           text primary key,
  title        text not null default '',
  channel      text not null default 'instagram',
  status       text not null default 'idea'
               check (status in ('idea','draft','review','scheduled','published')),
  publish_date date,
  publish_time time,
  owner        text,
  tag          text not null default '',
  note         text not null default '',
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  updated_by   text
);
create index if not exists contents_publish_date_idx on public.contents (publish_date);

-- 3) ค่าตั้งของทีม (เช่น เกณฑ์จำนวนชิ้นต่อวัน)
create table if not exists public.settings (
  key        text primary key,
  value      jsonb,
  updated_at timestamptz not null default now()
);

-- อัปเดตเวลาแก้ไขล่าสุดอัตโนมัติ
create or replace function public.touch_updated_at() returns trigger
language plpgsql as $$
begin new.updated_at = now(); return new; end $$;

drop trigger if exists contents_touch on public.contents;
create trigger contents_touch before update on public.contents
  for each row execute function public.touch_updated_at();
drop trigger if exists settings_touch on public.settings;
create trigger settings_touch before update on public.settings
  for each row execute function public.touch_updated_at();

-- เช็กว่าผู้ที่ล็อกอินอยู่เป็นสมาชิกทีมไหม
create or replace function public.is_team_member() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.team_members
    where email = lower(coalesce(auth.jwt() ->> 'email', ''))
  );
$$;

-- 4) สิทธิ์การเข้าถึง (Row Level Security)
alter table public.team_members enable row level security;
alter table public.contents     enable row level security;
alter table public.settings     enable row level security;

drop policy if exists "read own membership" on public.team_members;
create policy "read own membership" on public.team_members
  for select to authenticated
  using (email = lower(coalesce(auth.jwt() ->> 'email', '')));

drop policy if exists "team full access" on public.contents;
create policy "team full access" on public.contents
  for all to authenticated
  using (public.is_team_member()) with check (public.is_team_member());

drop policy if exists "team full access" on public.settings;
create policy "team full access" on public.settings
  for all to authenticated
  using (public.is_team_member()) with check (public.is_team_member());

-- 5) เปิด realtime ให้หน้าเว็บอัปเดตทันทีเมื่อเพื่อนในทีมแก้
alter table public.contents replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.contents;
exception when duplicate_object then null; end $$;
do $$ begin
  alter publication supabase_realtime add table public.settings;
exception when duplicate_object then null; end $$;

-- ค่าเริ่มต้น
insert into public.settings (key, value) values ('cap', '3')
on conflict (key) do nothing;

-- 6) ใส่อีเมลทีม — แก้ตรงนี้ก่อนกด Run (เพิ่ม/ลบภายหลังได้ด้วยคำสั่งเดียวกัน)
insert into public.team_members (email, name) values
  ('you@example.com',      'ชื่อคุณ'),
  ('teammate@example.com', 'เพื่อนในทีม')
on conflict (email) do nothing;
