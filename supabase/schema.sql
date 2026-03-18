-- ============================================================
--  SHAH PORTFOLIO — SUPABASE SCHEMA
--  Run this entire file once in your Supabase SQL Editor.
--  Dashboard → SQL Editor → New Query → Paste → Run
-- ============================================================


-- ── PROJECTS TABLE ─────────────────────────────────────────
create table if not exists projects (
  id           uuid primary key default gen_random_uuid(),
  number       text not null,           -- display order label e.g. '01', '02'
  category     text not null,           -- e.g. 'Industrial IoT'
  category_icon text not null default '🔧', -- emoji icon
  title        text not null,
  description  text not null,
  tags         text[] not null default '{}', -- array of tag strings
  github_link  text,                    -- null if no repo
  live_link    text,                    -- null if no live demo
  status       text not null default 'complete'
                 check (status in ('complete', 'in-progress', 'planned')),
  section      text not null
                 check (section in ('engineering', 'web', 'self')),
  visible      boolean not null default true,
  sort_order   integer not null default 0, -- controls display order within section
  created_at   timestamptz default now()
);

-- Index for fast section queries
create index if not exists projects_section_idx on projects (section, sort_order);


-- ── SKILLS TABLE ───────────────────────────────────────────
create table if not exists skill_groups (
  id         uuid primary key default gen_random_uuid(),
  title      text not null,
  skills     text[] not null default '{}',
  sort_order integer not null default 0
);


-- ── PERSONAL INFO TABLE ────────────────────────────────────
-- Single-row table for your bio, contact links, etc.
create table if not exists personal_info (
  id               uuid primary key default gen_random_uuid(),
  full_name        text not null,
  display_name     text not null,
  eyebrow          text not null,
  bio              text not null,
  location         text not null,
  university       text not null,
  graduation_year  text not null,
  status           text not null,
  email            text not null,
  github_url       text not null,
  linkedin_url     text not null,
  github_handle    text not null,
  linkedin_handle  text not null
);


-- ── ROW LEVEL SECURITY ─────────────────────────────────────
-- Public can READ everything (portfolio is public)
-- Only authenticated users (you) can write

alter table projects      enable row level security;
alter table skill_groups  enable row level security;
alter table personal_info enable row level security;

-- Public read policies
create policy "Public read projects"
  on projects for select using (true);

create policy "Public read skill_groups"
  on skill_groups for select using (true);

create policy "Public read personal_info"
  on personal_info for select using (true);

-- Authenticated write policies (you, logged into Supabase dashboard)
create policy "Auth write projects"
  on projects for all using (auth.role() = 'authenticated');

create policy "Auth write skill_groups"
  on skill_groups for all using (auth.role() = 'authenticated');

create policy "Auth write personal_info"
  on personal_info for all using (auth.role() = 'authenticated');


-- ── SEED DATA ──────────────────────────────────────────────
-- Personal info
insert into personal_info (
  full_name, display_name, eyebrow, bio,
  location, university, graduation_year, status,
  email, github_url, linkedin_url, github_handle, linkedin_handle
) values (
  'Shah Mohammed Tahmid',
  'Shah',
  'EE Student · Builder · Stony Brook University',
  'Electrical Engineering junior with a passion for building intelligent systems. From industrial IoT and embedded hardware to full-stack web apps — I build things end to end and document them here.',
  'Queens, NY',
  'Stony Brook University',
  'May 2027',
  'Open to internships — Summer 2025',
  'tahmidshahmd@gmail.com',
  'https://github.com/Shah-2024',
  'https://www.linkedin.com/in/shah-tahmid2026/',
  'github.com/Shah-2024',
  'linkedin.com/in/shah-tahmid2026'
);

-- Engineering projects
insert into projects (number, category, category_icon, title, description, tags, github_link, live_link, status, section, sort_order) values
(
  '01', 'Industrial IoT', '⚡',
  'Industrial IoT OPC UA Monitoring System',
  'Production-ready OPC UA server on Raspberry Pi that exposes real-time data from DHT11, INA219, and HC-SR04 sensors to any SCADA system, PLC, or HMI. Implements Industry 4.0 edge-to-cloud architecture using the same protocol stack used by Siemens and Rockwell Automation.',
  array['Python', 'OPC UA', 'Raspberry Pi', 'I2C', 'asyncua', 'SCADA'],
  'https://github.com/Shah-2024/industrial-iot-opcua-monitor',
  null, 'complete', 'engineering', 1
),
(
  '02', 'C++ / Algorithms', '🚁',
  'SkyRoute-II: Drone Fleet Management System',
  'Intelligent drone control simulation managing autonomous delivery fleets over a 2D spatial grid. Implements custom data structures from scratch — linked lists, queues, stacks, and a BST spatial index — with battery-aware route optimization and polymorphic drone variants.',
  array['C++17', 'Data Structures', 'OOP', 'BST', 'Templates', 'Visual Studio'],
  'https://github.com/Shah-2024/Skyroute-II-Drone-Fleet-Management-System-',
  null, 'complete', 'engineering', 2
),
(
  '03', 'Embedded Hardware', '🔧',
  'DIY CNC Plotter Machine',
  'Designed and built a functional CNC plotter from scratch using recycled DVD drive stepper motors for XY axis control. Programmed an Arduino with GRBL firmware for G-code interpretation and servo/stepper control.',
  array['Arduino', 'GRBL', 'G-code', 'Stepper Motors', 'PCB'],
  null, null, 'complete', 'engineering', 3
);

-- Web projects
insert into projects (number, category, category_icon, title, description, tags, github_link, live_link, status, section, sort_order) values
(
  '01', 'Landing Page', '🌐',
  'Forge Gym — Business Landing Page',
  'Dark, minimal landing page for a local gym client. Features a hero section, program listings, a three-tier pricing table, and a CTA — all built with a strong design system using CSS custom properties.',
  array['HTML', 'CSS', 'JavaScript', 'Responsive'],
  null, null, 'in-progress', 'web', 1
),
(
  '02', 'Full-Stack App', '📋',
  'Mini CRM — Contact Manager',
  'Full-stack contact manager with Supabase backend. Features user authentication, a contacts database with full CRUD operations, and a clean dashboard UI.',
  array['React', 'Vite', 'Supabase', 'Auth', 'PostgreSQL'],
  null, null, 'in-progress', 'web', 2
);

-- Self projects
insert into projects (number, category, category_icon, title, description, tags, github_link, live_link, status, section, sort_order) values
(
  '01', 'System Setup', '🖥️',
  'WSL2 Migration — C Drive to D Drive',
  'Solved a critical storage bottleneck by migrating a full WSL2 environment from C to D drive. Documented the export/import process, reconfigured tooling paths, and validated the environment.',
  array['WSL2', 'Windows', 'Linux', 'DevOps'],
  null, null, 'complete', 'self', 1
),
(
  '02', 'Linux Migration', '🐧',
  'Fedora Workstation Build — In Progress',
  'Planning and executing a migration from Windows to a native Fedora Linux workstation. Evaluating ROCm support for AMD RX 580 to enable local AI model inference.',
  array['Fedora', 'ROCm', 'AMD RX 580', 'Local AI'],
  null, null, 'in-progress', 'self', 2
);

-- Skills
insert into skill_groups (title, skills, sort_order) values
('Languages',          array['Python', 'C / C++', 'Rust', 'Verilog / VHDL', 'Assembly', 'JavaScript / TypeScript'], 1),
('EE & Simulation',    array['MATLAB / Simulink', 'LTSpice', 'PSpice', 'AutoCAD Electrical', 'ActiveHDL', 'PLC (Allen-Bradley, Siemens)'], 2),
('Hardware & Embedded',array['Arduino / Raspberry Pi', 'STM32 / ESP32', 'FPGA Design', 'PCB Design (Altium, KiCad)', 'SMD / Through-hole Soldering', 'Oscilloscope / DMM / Gen'], 3),
('Web & Dev',          array['React / Vite / Vue', 'Supabase / PostgreSQL', 'HTML / CSS', 'VS Code / Visual Studio 2022', 'Docker', 'Git / GitHub'], 4),
('Domains',            array['Industrial IoT / IIoT', 'Digital Signal Processing', 'Control Systems', 'Power Electronics', 'Cloud (AWS Certified)', 'SCADA / OPC UA'], 5);
