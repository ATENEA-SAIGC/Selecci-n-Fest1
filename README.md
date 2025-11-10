# 🎓 FEST1 — Cálculo y Validación de Resultados en R

Repositorio oficial del proceso **FEST1**, desarrollado en **R** y documentado en formato web tipo *Selección JE3*.  
Incluye el código, insumos, reglas de habilitación y lógica de asignación de cupos para análisis reproducible.

---

## 🧭 Descripción general

El proyecto FEST1 busca garantizar **transparencia, trazabilidad y reproducibilidad** en los cálculos de elegibilidad y asignación de beneficiarios.

Su flujo general es el siguiente:

1. **Lectura de insumos**  
   Integración de bases de inscritos y oferta educativa.

2. **Habilitación (Reglas A–I)**  
   Verificación secuencial de requisitos con evidencia administrativa.

3. **Puntuación global**  
   Suma ponderada de dimensiones: vulnerabilidad estructural, económica, mérito académico y trayectoria.

4. **Ordenamiento y desempates**  
   Aplicación de criterios sucesivos (Saber 11, SISBÉN, vulnerabilidad) y sorteo reproducible con `set.seed()`.

5. **Asignación de cupos y estados**  
   Recorrido persona → opción por prioridad y disponibilidad.

---

## ⚙️ Dependencias principales

```r
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(sqldf)
library(openxlsx)
library(eeptools)
```

> 💡 Se recomienda usar [`renv`](https://rstudio.github.io/renv/articles/renv.html) para congelar versiones y `here()` para rutas relativas.

---

## 🧩 Estructura del proyecto

```
.
├── config.yml               # Parámetros (fechas, semillas, rutas)
├── R/
│   ├── 01_load_insumos.R    # Lectura de insumos
│   ├── 02_clean_match.R     # Limpieza y emparejamientos
│   ├── 03_habilitacion.R    # Reglas A–I
│   ├── 04_puntuacion.R      # Puntajes
│   ├── 05_ordenamiento.R    # Desempates y semillas
│   ├── 06_asignacion.R      # Cupos y estados
│   └── utils.R              # Funciones auxiliares
├── Inscritos/               # Archivos de convocatoria
├── Insumos/                 # Fuentes externas (SIMAT, MEN, ICFES, SISBÉN)
├── output/                  # Resultados finales (CSV/XLSX/HTML)
├── Pagina/                  # Versión web (HTML tipo JE3)
└── renv/                    # Entorno reproducible
```

---

## 🔁 Reproducibilidad

- **Semillas fijas:** `set.seed(20250701)`
- **Versionamiento:** control mediante `renv::init()`
- **Orquestación:** `_targets.R` o `Makefile`
- **Parámetros:** definidos en `config.yml`

Ejemplo:

```r
install.packages("renv")
renv::init()
config <- yaml::read_yaml("config.yml")
set.seed(config$seed_asignacion)
```

---

## 🌐 Sitio web explicativo

El sitio web asociado está disponible en formato estático (HTML/Tailwind):  
👉 [Página explicativa de FEST1](#) *(pendiente de enlace de despliegue)*

Incluye:
- Navegación lateral con secciones numeradas.  
- Ejemplos de código en R y pseudo-código.  
- Explicación de reglas de habilitación, puntajes y asignaciones.  
- Sección de preguntas frecuentes.

---

## 📜 Licencia

Este proyecto se distribuye bajo licencia **CC BY 4.0**.  
Puedes reutilizar, citar o adaptar el código citando la fuente original.

---

## 📬 Contacto

Equipo de Datos — [Agencia Atenea](https://www.agenciaatenea.gov.co)  
📧 contacto: datos@agenciaatenea.gov.co
