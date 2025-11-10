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


## 📜 Licencia

Este material explica a alto nivel el proceso de selección en JE3 – Bogotá, con base en el script operativo en R.
Para consultas remitirse a https://www.agenciaatenea.gov.co/atencion-y-servicios-la-ciudadania

