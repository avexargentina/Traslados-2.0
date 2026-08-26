# Traslados 2.0 — Registro de servicios

App para anotar servicios de traslado de motos y mecánica ligera (arranque de batería,
cambio de rueda, venta de batería, etc.), compartida entre el dueño y el chofer.

## Qué incluye

- `index.html` — la app completa (una sola página, sin build, sin dependencias que instalar).
- `supabase-setup.sql` — el script para crear la tabla en Supabase.

## Cómo publicarlo

### 1. Subir a GitHub
Si no usás git localmente, la forma más simple es entrar al repo en github.com,
tocar **Add file → Upload files**, y arrastrar `index.html` (y el resto de los archivos).

Con git:
```
git add .
git commit -m "primera version"
git push
```

### 2. Base de datos (Supabase)
1. Entrá a tu proyecto en supabase.com → **SQL Editor**.
2. Pegá el contenido de `supabase-setup.sql` y ejecutalo. Esto crea la tabla `app_data`
   donde se guarda todo (configuración + servicios).
3. Las credenciales (URL del proyecto y "anon key") ya están cargadas dentro de `index.html`,
   en las primeras líneas del `<script>` de Supabase. Si alguna vez rotás la anon key,
   hay que actualizarla ahí.

> ⚠️ Importante: la política de la tabla (`RLS`) está abierta — cualquiera que tenga la
> anon key (que queda visible en el código del sitio publicado) puede leer y escribir en
> la tabla. Está pensado así a propósito para que el dueño y el chofer compartan los datos
> sin necesidad de login. Si en algún momento esto te preocupa, avisale a quien te ayude
> a agregar autenticación y políticas más estrictas.

### 3. Desplegar en Vercel
1. Entrá a vercel.com → **Add New → Project** → importá el repo `Traslados-2.0`.
2. Como es un sitio estático (solo `index.html`), no hace falta configurar ningún
   framework ni comando de build — Vercel lo detecta solo.
3. Deploy. Listo, ya te da una URL pública.

## Cómo se comparte el link de un servicio con el chofer
Desde la pestaña **Registro**, cada fila tiene un botón **Link**. Al copiarlo, se genera
una URL con `#servicio=<id>` al final. Quien la abre ve solo el resumen de ese servicio,
y puede marcar si está Finalizado y cómo pagó el cliente (Efectivo/Transferencia).
