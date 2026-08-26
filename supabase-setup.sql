-- Tabla única para guardar toda la data de la app (config + servicios)
create table if not exists app_data (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz default now()
);

-- Fila inicial vacía (la app la completa sola la primera vez que la abras)
insert into app_data (id, data)
values ('taller-data', '{}'::jsonb)
on conflict (id) do nothing;

-- Habilitar RLS
alter table app_data enable row level security;

-- Política abierta: cualquiera con la anon key puede leer y escribir.
-- Es lo mismo que ya tenías (datos compartidos), pensado para una app interna chica.
-- Si en el futuro querés más seguridad, esto es lo primero que hay que endurecer.
drop policy if exists "allow all for anon" on app_data;
create policy "allow all for anon"
  on app_data
  for all
  using (true)
  with check (true);
