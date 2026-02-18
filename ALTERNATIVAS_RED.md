# Alternativas de Red: Acceder a miapp.com sin internet en el router

Guía para acceder a `miapp.com` desde un Samsung A53 (u otro Android) conectado al Wi-Fi del router **sin internet**, mientras se usan datos móviles para navegar en internet (Facebook, YouTube, etc.).

---

## Alternativa 1: Usar la IP directamente (la más simple) ✅

En vez de `miapp.com`, accede por IP en el navegador:

```
http://192.168.1.64
```

- No necesitas servidor DNS
- El Wi-Fi sin internet se mantiene para la red local
- Los datos móviles manejan Facebook, YouTube, etc.
- No necesitas el contenedor Docker del DNS

---

## Alternativa 2: Opciones de Desarrollador en Samsung A53 ✅✅

Esta es la alternativa más práctica para mantener ambas conexiones activas.

### Configuración paso a paso:

1. **Activa opciones de desarrollador:**
   - Ajustes → Acerca del teléfono → Información de software
   - Toca **"Número de compilación" 7 veces**

2. **Activa datos móviles siempre activos:**
   - Ajustes → Opciones de desarrollador
   - Activa: **"Mantener datos móviles siempre activos"** 🔑

3. **Conéctate al Wi-Fi** del router (sin internet)

4. Cuando aparezca **"Esta red no tiene acceso a internet"** → Toca **"Mantener conexión"**

### Resultado:
- **Wi-Fi** → tráfico local (acceso a `http://192.168.1.64`)
- **Datos móviles** → tráfico de internet (Facebook, YouTube, etc.)

> ⚠️ **Limitación**: `miapp.com` como dominio probablemente no se resolverá porque el DNS activo será el del operador móvil. Se recomienda combinar con la **IP directa** o con la **Alternativa 3**.

---

## Alternativa 3: Usar dominio `.local` con mDNS ✅

Desde Android 10+, los dispositivos soportan resolución de dominios `.local` **sin necesidad de un servidor DNS** usando mDNS (multicast DNS).

### Cómo funciona:
Si configuras tu servidor con un nombre como `miapp.local`, el Samsung A53 lo resolvería automáticamente en la red Wi-Fi local **sin pasar por ningún DNS externo**.

### Requisitos:
1. Instalar **Avahi** (mDNS responder) en tu máquina Windows o en Docker
2. Configurar el nombre `miapp.local`
3. Acceder desde el celular a `http://miapp.local`

### Ventajas:
- Funciona solo por Wi-Fi, así que aunque los datos estén activos, el `.local` se resuelve por multicast en la red local

### Desventajas:
- Más complejo de configurar
- Algunos dispositivos pueden tener problemas intermitentes con la resolución `.local`

---

## Alternativa 4: Captive Portal (tipo aeropuerto/hotel) 🔧

Convertir tu servidor en un **portal cautivo** que intercepta todo el tráfico HTTP y redirige a tu app (como el Wi-Fi de hoteles/aeropuertos).

### Requisitos:
- Configurar `dnsmasq` para resolver **todos los dominios** a tu IP
- Agregar reglas de `iptables` para redirigir tráfico HTTP
- El celular detectaría el portal cautivo y abriría tu app automáticamente

### Desventajas:
- Más complejo de implementar
- Bloquea todo el tráfico web mientras estés en esa red Wi-Fi

---

## Resumen de alternativas

| Prioridad | Alternativa | Dificultad | Recomendación |
|-----------|------------|------------|---------------|
| 1️⃣ | **IP directa** (`http://192.168.1.64`) + Opciones de desarrollador | Fácil | ⭐ Recomendada |
| 2️⃣ | **mDNS** (`http://miapp.local`) | Media | Buena opción |
| 3️⃣ | **Captive portal** | Compleja | Solo si es necesario |

---

## 🏆 Combinación ganadora

1. Activa **"Mantener datos móviles siempre activos"** en opciones de desarrollador
2. Acepta **mantener la conexión Wi-Fi** cuando diga que no hay internet
3. Accede por **`http://192.168.1.64`**

Así tienes tu app por Wi-Fi y Facebook/YouTube por datos móviles.

---

## Mejor escenario: Router CON internet

Si tu router **sí tiene internet**, todo es más simple:

- Wi-Fi = única conexión activa
- DNS del router = `192.168.1.64` (tu dnsmasq)
- `miapp.com` → resuelve a tu app ✅
- Facebook/YouTube → forward a `8.8.8.8` → internet ✅
- **Todo pasa por Wi-Fi, sin conflictos** 🎉
