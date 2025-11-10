#===============================================================================
#===============================================================================
# FEST ATENEA 1
# CORTE 2025-07-01
# @ANDRES.SILVA
#===============================================================================
#===============================================================================

#==============================================================================================
# GUARDAR AREA DE TRABAJO
#==============================================================================================
#save.image(file = "D:/FUENTES_INFORMACION/FEST/FEST_Atenea1/FEST1_HABILITADOS.RData")
load("D:/FUENTES_INFORMACION/FEST/FEST_Atenea1/FEST1_HABILITADOS.RData")

setwd("D:/FUENTES_INFORMACION/FEST/FEST_Atenea1")
getwd()


library(sqldf)
library(expss)
library(readr)
library(readxl)
library(dplyr)
library(tidyr)
library(eeptools)
library(openxlsx)
options(scipen=999)

#D:/FUENTES_INFORMACION/FEST/FEST_Atenea1\Inscritos\FEST1\Inscritos
FEST1 <- read_excel("Inscritos/20250626_FEST_PersonasUnicasCierreConvocatoria.xlsx")
FEST1$FECHA_NACIMIENTO <- as.character(FEST1$FECHA_NACIMIENTO)
FEST1$FECHA_EXPEDICION <- as.character(FEST1$FECHA_EXPEDICION)
sqldf("select NUMERO_DOCUMENTO from FEST1 group by NUMERO_DOCUMENTO having count(1)>1")
str(FEST1)

#SOLO DEJAR CARACTERES DE LETRAS
cro(FEST1$INFO_HIJOS)
FEST1$INFO_HIJOS <- gsub("\\W", "", FEST1$INFO_HIJOS)


# CONSTRUCCION VARIABLES NOMBRES+APELLIDOS PARA DEPURACION Y CRUCES
FEST1$NOMBRES_DEPURA <- paste(FEST1$PRIMER_NOMBRE,FEST1$SEGUNDO_NOMBRE,FEST1$PRIMER_APELLIDO,FEST1$SEGUNDO_APELLIDO, sep = "")
FEST1$NOMBRES_DEPURA<- chartr("Á","A", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA<- chartr("É","E", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA<- chartr("Í","I", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA<- chartr("Ó","O", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA<- chartr("Ú","U", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA<- chartr("Ñ","N", FEST1$NOMBRES_DEPURA)
FEST1$NOMBRES_DEPURA <- gsub("\\s", "", FEST1$NOMBRES_DEPURA)
TMP <- FEST1[strapply(!is.na(FEST1$NOMBRES_DEPURA,"\\W")),] 

# CONSTRUCCION VARIABLES NOMBRES+APELLIDOS PARA DEPURACION Y CRUCES
FEST1$NOMBRES_DEPURA2 <- paste(FEST1$PRIMER_NOMBRE,FEST1$PRIMER_APELLIDO,FEST1$NUMERO_DOC_ICFES, sep = "")
FEST1$NOMBRES_DEPURA2<- chartr("Á","A", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2<- chartr("É","E", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2<- chartr("Í","I", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2<- chartr("Ó","O", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2<- chartr("Ú","U", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2<- chartr("Ñ","N", FEST1$NOMBRES_DEPURA2)
FEST1$NOMBRES_DEPURA2 <- gsub("\\s", "", FEST1$NOMBRES_DEPURA2)




# CARGUE PERSONA - OFERTA
FEST1_PER_OFERTA <- read_excel("Inscritos/20250626_FEST_PersonaOfertaCierreConvocatoria_V2.xlsx")
#FEST1<- merge(x=unique(FEST1_PER_OFERTA[,c("ID_PERSONA","UBI_COLEGIO_GRADUACION")]), y=FEST1, by="ID_PERSONA", all = FALSE )


#===============================================================================
# CARGUE FUENTES DE INFORMACION PARA CRUCES
#===============================================================================

# SIMAT BOGOTA (ACTUALIZACION 2025-07-01)
X2011 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2011-proc8731427_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2012 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2012-proc8731426_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2013 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2013-proc8731425_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2014 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2014-proc8731424_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2015 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2015-proc8731422_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2016 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2016-proc8731421_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2017 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2017-proc8731420_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2018 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2018-proc8731418_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2019 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2019-proc8731415_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2020 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2020-proc8731414-20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2021 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2021-proc8731412_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2022 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2022-proc8731411_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2023 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2023-proc8731410_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2024 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2024-proc8731409_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
X2025 <- read_delim("Insumos/Consolidado/23-Simat_DescargasUsuario/2025-proc8731408_20250701.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)

X2011$GRADO_COD <- as.double(X2011$GRADO_COD)

INS_Graduados_MEDIA_SED <- X2025
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2024)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2023)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2022)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2021)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2020)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2019)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2018)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2017)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2016)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2015)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2014)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2013)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2012)
INS_Graduados_MEDIA_SED <- union_all(INS_Graduados_MEDIA_SED,X2011)

cro(INS_Graduados_MEDIA_SED$ANO, INS_Graduados_MEDIA_SED$GRADO_COD)

rm(X2025, X2024,X2023,X2022,X2021,X2020,X2019,X2018,X2017,X2016,X2015,X2014,X2013,X2012,X2011)

INS_Graduados_MEDIA_SED$ORIGEN_GRADUADO_MEDIA_SED<- "SED"
INS_Graduados_MEDIA_SED$Divipola_MUNICIPIO_SED<- 11001
INS_Graduados_MEDIA_SED$FECHA_NACIMIENTO <- as.Date(INS_Graduados_MEDIA_SED$FECHA_NACIMIENTO, "%d/%m/%Y")
INS_Graduados_MEDIA_SED$FECHA_NACIMIENTO <- as.character(INS_Graduados_MEDIA_SED$FECHA_NACIMIENTO)

# CONSTRUCCION VARIABLES NOMBRES+APELLIDOS PARA DEPURACION Y CRUCES
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA <- paste(INS_Graduados_MEDIA_SED$NOMBRE1,INS_Graduados_MEDIA_SED$NOMBRE2,INS_Graduados_MEDIA_SED$APELLIDO1,INS_Graduados_MEDIA_SED$APELLIDO2, sep = "")
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("Á","A", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("É","E", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("Í","I", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("Ó","O", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("Ú","U", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA<- chartr("Ñ","N", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA <- gsub("\\s", "", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA)

INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2 <- paste(INS_Graduados_MEDIA_SED$NOMBRE1,INS_Graduados_MEDIA_SED$APELLIDO1,INS_Graduados_MEDIA_SED$DOC, sep = "")
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("Á","A", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("É","E", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("Í","I", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("Ó","O", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("Ú","U", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2<- chartr("Ñ","N", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)
INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2 <- gsub("\\s", "", INS_Graduados_MEDIA_SED$NOMBRES_DEPURA2)


#TMP <- INS_Graduados_MEDIA_SED[strapply(INS_Graduados_MEDIA_SED$NOMBRES_DEPURA,"\\W"),] 


#Graduado MEDIA MEN
INS_MEN_Graduados_Media <- read_excel("Insumos/Consolidado/09-MinEducacion - Media/ANX-RESULTADO_GRADUADO_F.xlsx")
INS_MEN_Graduados_Media$FECHA_NACIMIENTO <- as.character(INS_MEN_Graduados_Media$FECHA_NACIMIENTO)

#MATRICULA MEDIA MEN
INS_MEN_Matricula_Media <- read_excel("Insumos/Consolidado/09-MinEducacion - Media/ANX-RESULTADO_MATRICULA_F.xlsx")
INS_MEN_Matricula_Media$FECHA_NACIMIENTO <- as.character(INS_MEN_Matricula_Media$FECHA_NACIMIENTO)


#Graduado SUperior MEN
INS_MEN_Graduados_Superior <- read_excel("Insumos/Consolidado/09-MinEducacion - Media/Superior/Graduados-2016_2025.xlsx")

#Saber11
#INS_ICFES_SABER11 <- read_excel("Insumos/Consolidado/06-Icfes/2025_07_03 - JOVENES A LA E - ATENEA_V2.xlsx")
INS_ICFES_SABER11 <- read_delim("Insumos/Consolidado/06-Icfes/2025_06_27_Cruce_final_Atenea_Saber11.csv", 
                                delim = "|", escape_double = FALSE, locale = locale(), 
                                trim_ws = TRUE)

# ATENEA
INS_JU_MAESTRA <- read_excel("D:/Atenea/Maestra_JU4/MAESTRA_8.0_v01_20250630.xlsx", sheet = "MAESTRA")
INS_JU_MAESTRA <- INS_JU_MAESTRA[!is.na(INS_JU_MAESTRA$E_BENEFICIARIO_CORTE),]

INS_DNP_SISBEN <- read_excel("Insumos/Consolidado/DNP_Sisben/Cruce_SISBEN_FEST1.xlsx")
INS_DNP_SISBEN <- INS_DNP_SISBEN[,c(1,33:39)]


INS_ATENEA_ESTRATO <- read_excel("Insumos/Consolidado/Verificacion_Estrato/RESULTADOS-ESTRATO-FEST1-11-07-2025.xlsx")

INS_ATENEA_ADMITIDO <- read_excel("Insumos/Consolidado/CartaAdmision_CertifEstudios/ADMITIDOS- HABILITADOS_20250716.xlsx")

INS_RENEC<- read_excel("Insumos/Consolidado/RNEC/Analisis_RNEC_FEST.xlsx", sheet = "Sheet 1")

#===============================================================================
# PENDIENTES
#===============================================================================


INS_MEN_Matriculados_Superior <- read_excel("Insumos/Consolidado/09-MinEducacion/01-Superior/Matricula/CruceMasivo (1).xlsx")
INS_SENA_APRENDICES <- read_excel("Insumos/Consolidado/21-Sena/Información ATENEA-250516.xlsx")

INS_ATENEA_UTC <- read_excel("Insumos/Consolidado/26-Atenea/03-UTC/BENEFICIARIOS UTC INHABILITADOS HABILITADOS PARA FEST1.xlsx", sheet = "Base de Datos UTC")

INS_JU_MAESTRA <- read_excel("Insumos/Consolidado/26-Atenea/01-JovenesE/BENEFICIARIOS UTC INHABILITADOS HABILITADOS PARA FEST1.xlsx")

# SED:
# OK- Fondo Educación Superior para Todos (FEST), 
# OK- Becas Universidad Libre y América
# OK- Fondo Ciudad Bolívar

INS_SED_FONDOS <- read_excel("Insumos/Consolidado/19-SecEducacion/ANX-2025-8310_2.xlsx")


# ATENEA:
# OK- Fondo Alianza Ciudad Educadora, 
# OK- Fondo para la Reparación de las Víctimas del Conflicto Armado, 
# OK- Fondo Universidades Públicas (Universidad Nacional de Colombia, 
#                               Universidad Nacional Abierta y a Distancia- UNAD, 
#                               Universidad Distrital Francisco José de Caldas, 
#                               Universidad Pedagógica Nacional y Escuela Tecnológica Instituto Técnico Central)
# OK- Fondo Técnica y Tecnológica
INS_ATENEA_FONDO_ALIANZA <- read_excel("Insumos/Consolidado/26-Atenea/02-FondoAlianza_Victimas_TyT_UPcas/Beneficiarios FONDO ALIANZA BOGOTA CIUDAD EDUCADROA a corte 2024-2.xls",sheet = "BASE ESTANDARIZADA")
INS_ATENEA_FONDO_VICTIMAS <- read_excel("Insumos/Consolidado/26-Atenea/02-FondoAlianza_Victimas_TyT_UPcas/Beneficiarios FONDO DE VICTIMAS DEL CONFLICTO ARMADO a corte 2024-1.xls",sheet = "Base Estandarizada")
INS_ATENEA_FONDO_UPUBLICA <- read_excel("Insumos/Consolidado/26-Atenea/02-FondoAlianza_Victimas_TyT_UPcas/1. Base Beneficiarios CONVENIO DE UNIVERSIDADES PUBLICAS_TOTAL_UD.xlsx")
INS_ATENEA_FONDO_TYT <- read_excel("Insumos/Consolidado/26-Atenea/02-FondoAlianza_Victimas_TyT_UPcas/2. Beneficiarios FONDO ATENEA TyT a corte 2025-1.xlsx",sheet = "BENEFICIARIOS TYT")



INS_IDECA_GEO_SICORE <- read_excel("Insumos/Consolidado/25-Uaesp-IDECA/FEST1_gdf_marks.xlsx", 
                                   col_types = c("numeric", "text", "text", 
                                                 "numeric", "text", "text", "text", 
                                                 "text", "numeric", "text", "text", 
                                                 "text", "numeric", "text", "numeric", 
                                                 "numeric", "numeric", "numeric", 
                                                 "numeric", "text", "numeric", "numeric"))

# MARCACION DE INSCRITOS EN LA ZONA UAESP
INS_UAESP <- read_excel("Insumos/Consolidado/25-Uaesp-IDECA/120253000116081_00002_mariasantos_1748375193.xlsx", sheet = "VERIFIC UAESP 27_05_2025")
INS_UAESP$UAESP <- NA
INS_UAESP[INS_UAESP$OBSERVACIONES=="APROBADO", "UAESP"] <-"APROBADO"

INS_IDECA_GEO_RECIBO <- read_excel("Insumos/Consolidado/26-Atenea/07-VerificacionReciboPublico/FEST1_UPZ_AllV.xlsx")

#----------------------------
# CARGUE PARA PUNTUACION
#----------------------------

X110408_ATENEA_ARCHIVOBASE1 <- read_excel("Insumos/Consolidado/01-Ocdpvr/110408_ATENEA_ARCHIVOBASE1.xlsx")
X110409_ATENEA_ARCHIVOBASE2 <- read_excel("Insumos/Consolidado/01-Ocdpvr/110409_ATENEA_ARCHIVOBASE2.xlsx")
INS_VICTIMA_ALTA_CONSEJERIA <- union_all(X110408_ATENEA_ARCHIVOBASE1,X110409_ATENEA_ARCHIVOBASE2)
rm(X110408_ATENEA_ARCHIVOBASE1,X110409_ATENEA_ARCHIVOBASE2)

INS_VIOLENCIA_GENERO_SDMUJER <- read_excel("Insumos/Consolidado/17-SecMujer/20250515 ANX-2025-8309_2 SDMujer.xlsx")

INS_ARN <- read_excel("Insumos/Consolidado/02-Arn/Copia de ANX-2025-8301_2 - CRUCE ARN BOGOTÁ.xlsx")

INS_MINSALUD_DISCAPACIDAD <- read_excel("Insumos/Consolidado/12-MinSalud/ANX-2025-8314_3.xlsx")



INS_CONSEJEROS <- read_excel("Insumos/Consolidado/16-SecGobierno-Consejeros/Consejeros activos mayo .xlsx", skip = 1)

INS_IDRD_DEPORTISTAS <- read_excel("Insumos/Consolidado/08-Idrd/Deportistas del Registro de Bogotá de Mayo 2025 - Respuesta ATENEA.xlsx", sheet = "Consolidado")

INS_MINDEFENSA_LEY1699 <- read_excel("Insumos/Consolidado/31-MinDefensa/ANX-2025-8313_2.xlsx",sheet = "GENERICO")

INS_PARCEROS <- read_excel("Insumos/Consolidado/14-SecIntegracion/ANX-2025-8307_2.xlsx",sheet = "GENERICO")
INS_PARCEROS<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= INS_PARCEROS[!is.na(INS_PARCEROS$`OBSERVACIONES DE RUTA DE INCLUSIÓN`),], by.x="NUMERO_DOCUMENTO",by.y="NUMERO_DOCUMENTO", all = FALSE )

#INS_RETO_SDIS <- INS_PARCEROS[INS_PARCEROS$RUTA=="RETO",]
INS_JOVENES_OPORTU <- INS_PARCEROS[INS_PARCEROS$`OBSERVACIONES DE RUTA DE INCLUSIÓN`=="HACEN PARTE DE RUTA JOVENES CON OPORTUNIDADES",]
INS_PARCEROS <-INS_PARCEROS[INS_PARCEROS$`OBSERVACIONES DE RUTA DE INCLUSIÓN`=="HACEN PARTE DE RUTA PARCEROS POR BOGOTA",]


#----------------------------
# CARGUE PARA PUNTUACION
#----------------------------

INS_RC <- read_excel("Insumos/Consolidado/26-Atenea/05-Verificacion_RC/FEST1_RC_FINAL.xlsx")

INS_ATENEA_ETNIA <- read_excel("Insumos/Consolidado/26-Atenea/06-Verificacion_Etnia/REPORTE_1_RESID_ETNIA.xlsx")


#MATRICULA MEDIA MEN
INS_MEN_Matricula_Media <- read_excel("Insumos/Consolidado/09-Men_MatriculasMedia.xlsx")
INS_MEN_Matricula_Media$FECHA_NACIMIENTO <- as.character(INS_MEN_Matricula_Media$FECHA_NACIMIENTO)

# DUE
INS_DUE_MEN <- read_delim("Insumos/Consolidado/DUE MEN 05122024.csv", 
                               delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"), 
                               trim_ws = TRUE)
INS_DUE_SEDES_MEN <- read_delim("Insumos/Consolidado/DUE SEDES MEN 05122024.csv", 
                          delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"), 
                          trim_ws = TRUE)


# MATRICULA SIMAT - SED
INS_Matricula_MEDIA_SED <- read_delim("Insumos/Consolidado/2024_proc8412058-20241203.txt",delim = ";", escape_double = FALSE, locale = locale(encoding = "WINDOWS-1252"),trim_ws = TRUE)
INS_Matricula_MEDIA_SED$FECHA_NACIMIENTO <- as.Date(INS_Matricula_MEDIA_SED$FECHA_NACIMIENTO, "%d/%m/%Y")
INS_Matricula_MEDIA_SED$FECHA_NACIMIENTO <- as.character(INS_Matricula_MEDIA_SED$FECHA_NACIMIENTO)
INS_Matricula_MEDIA_SED$Divipola_MUNICIPIO_SED<- 11001


#===============================================================================
#===============================================================================
# CRUCES PARA DEFINIR HABILITADOS
#===============================================================================
#===============================================================================

#------------------------
# MEN_Graduados_Superior
#------------------------
names(INS_MEN_Graduados_Superior)
INS_MEN_Graduados_Superior$ANIO_SEMESTRE <- paste("GRADUADO",INS_MEN_Graduados_Superior$AÑO_GRADO, INS_MEN_Graduados_Superior$SEMESTRE_GRADO, sep = "_")

SNIES_GRADUADOS2<- INS_MEN_Graduados_Superior[!is.na(INS_MEN_Graduados_Superior$NUM_DOCUMENTO) & !is.na(INS_MEN_Graduados_Superior$ID_PROGRAMA),] 
SNIES_GRADUADOS2<- SNIES_GRADUADOS2[,c("NUM_DOCUMENTO","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO", "NIVEL_FORMACION","ID_PROGRAMA")]
SNIES_GRADUADOS2$NIVEL_FORMACION <- paste("GRADUADO",SNIES_GRADUADOS2$NIVEL_FORMACION,sep = "_")
SNIES_GRADUADOS2 <- pivot_wider(SNIES_GRADUADOS2, names_from = NIVEL_FORMACION, values_from = ID_PROGRAMA)
names(SNIES_GRADUADOS2)
colnames(SNIES_GRADUADOS2)<-c("NUMERO_DOCUMENTO","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO", "SEGUNDO_APELLIDO",
                              "GRADUADO_Tecnologico","GRADUADO_FormacionTecnicaProfesional",
                              "GRADUADO_Universitario")

str(SNIES_GRADUADOS2)
SNIES_GRADUADOS2$GRADUADO_Universitario <- as.character(SNIES_GRADUADOS2$GRADUADO_Universitario)
SNIES_GRADUADOS2$GRADUADO_Tecnologico <- as.character(SNIES_GRADUADOS2$GRADUADO_Tecnologico)
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional <- as.character(SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)

SNIES_GRADUADOS2[SNIES_GRADUADOS2$GRADUADO_Universitario=='NULL','GRADUADO_Universitario'] <- NA
SNIES_GRADUADOS2$GRADUADO_Universitario <- gsub('"', "", SNIES_GRADUADOS2$GRADUADO_Universitario)
SNIES_GRADUADOS2$GRADUADO_Universitario <- gsub('c', "", SNIES_GRADUADOS2$GRADUADO_Universitario)
SNIES_GRADUADOS2$GRADUADO_Universitario<- chartr("("," ", SNIES_GRADUADOS2$GRADUADO_Universitario)
SNIES_GRADUADOS2$GRADUADO_Universitario<- chartr(")"," ", SNIES_GRADUADOS2$GRADUADO_Universitario)
SNIES_GRADUADOS2$GRADUADO_Universitario <- gsub("\\s", "", SNIES_GRADUADOS2$GRADUADO_Universitario)

SNIES_GRADUADOS2[SNIES_GRADUADOS2$GRADUADO_Tecnologico=='NULL','GRADUADO_Tecnologico'] <- NA
SNIES_GRADUADOS2$GRADUADO_Tecnologico <- gsub('"', "", SNIES_GRADUADOS2$GRADUADO_Tecnologico)
SNIES_GRADUADOS2$GRADUADO_Tecnologico <- gsub('c', "", SNIES_GRADUADOS2$GRADUADO_Tecnologico)
SNIES_GRADUADOS2$GRADUADO_Tecnologico<- chartr("("," ", SNIES_GRADUADOS2$GRADUADO_Tecnologico)
SNIES_GRADUADOS2$GRADUADO_Tecnologico<- chartr(")"," ", SNIES_GRADUADOS2$GRADUADO_Tecnologico)
SNIES_GRADUADOS2$GRADUADO_Tecnologico <- gsub("\\s", "", SNIES_GRADUADOS2$GRADUADO_Tecnologico)

SNIES_GRADUADOS2[SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional=='NULL','GRADUADO_FormacionTecnicaProfesional'] <- NA
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional <- gsub('"', "", SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional <- gsub('c', "", SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional<- chartr("("," ", SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional<- chartr(")"," ", SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)
SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional <- gsub("\\s", "", SNIES_GRADUADOS2$GRADUADO_FormacionTecnicaProfesional)


# CRUCE PARA IDENTIFICAR ID_PERSONA
SNIES_GRADUADOS2 <- merge(x=SNIES_GRADUADOS2, y= FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], by="NUMERO_DOCUMENTO", all.x = TRUE)
SNIES_GRADUADOS2 <- merge(x=SNIES_GRADUADOS2, y= FEST1[,c("ID_PERSONA","NUMERO_DOC_ICFES")], by.x=c("NUMERO_DOCUMENTO"),by.y=c("NUMERO_DOC_ICFES"),  all.x = TRUE)
colnames(SNIES_GRADUADOS2)[colnames(SNIES_GRADUADOS2)=="ID_PERSONA.x"] <-"ID_PERSONA"
colnames(SNIES_GRADUADOS2)[colnames(SNIES_GRADUADOS2)=="ID_PERSONA.y"] <-"ID_PERSONA2"
SNIES_GRADUADOS2[is.na(SNIES_GRADUADOS2$ID_PERSONA) & !is.na(SNIES_GRADUADOS2$ID_PERSONA2),"ID_PERSONA"] <- SNIES_GRADUADOS2[is.na(SNIES_GRADUADOS2$ID_PERSONA) & !is.na(SNIES_GRADUADOS2$ID_PERSONA2),"ID_PERSONA2"]
SNIES_GRADUADOS2<- SNIES_GRADUADOS2[,c(-12)]

SNIES_GRADUADOS2_REVISAR <- SNIES_GRADUADOS2[is.na(SNIES_GRADUADOS2$ID_PERSONA),]

sqldf("select ID_PERSONA from SNIES_GRADUADOS2 group by ID_PERSONA having count(1)>1")

TMP <- unique(SNIES_GRADUADOS2[!is.na(SNIES_GRADUADOS2$ID_PERSONA),c("ID_PERSONA","GRADUADO_Universitario","GRADUADO_Tecnologico","GRADUADO_FormacionTecnicaProfesional")])
sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP, by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

#-------------------------
# GRADUADOS MEDIA SIMAT HISTORICO
#-------------------------
names(INS_Graduados_MEDIA_SED)

#SOLO DOCUMENTO
TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y=INS_Graduados_MEDIA_SED[INS_Graduados_MEDIA_SED$GRADO_COD %in% c("11","26") & INS_Graduados_MEDIA_SED$ESTADO=="GRADUADO", ], by.x = "NUMERO_DOCUMENTO", by.y = "DOC", all.x = TRUE)

TMP1 <- TMP[is.na(TMP$DANE),c(1,2)]
TMP<-TMP[!is.na(TMP$DANE),]

# NOMBRES + APELLIDOS + FECHA NACIMIENTO
TMP1<- merge(x=TMP1, y=FEST1[,c("ID_PERSONA","NOMBRES_DEPURA","FECHA_NACIMIENTO")], by="ID_PERSONA", all = FALSE )
TMP1<- merge(x=TMP1, y=INS_Graduados_MEDIA_SED[INS_Graduados_MEDIA_SED$GRADO_COD %in% c("11","26") & INS_Graduados_MEDIA_SED$ESTADO=="GRADUADO",],by.x =c("NOMBRES_DEPURA","FECHA_NACIMIENTO"), by.y = c("NOMBRES_DEPURA","FECHA_NACIMIENTO"), all.x = TRUE)

# DOCUMENTO ICFES + FECHA NACIMIENTO
TMP2 <- TMP1[is.na(TMP1$DANE),c("ID_PERSONA","NUMERO_DOCUMENTO")]
TMP1<-TMP1[!is.na(TMP1$DANE),]

TMP2<- merge(x=TMP2, y=FEST1[,c("ID_PERSONA","NUMERO_DOC_ICFES","FECHA_NACIMIENTO")], by="ID_PERSONA", all = FALSE )

TMP2<- merge(x=TMP2, y=INS_Graduados_MEDIA_SED[INS_Graduados_MEDIA_SED$GRADO_COD %in% c("11","26") & INS_Graduados_MEDIA_SED$ESTADO=="GRADUADO",],by.x =c("NUMERO_DOC_ICFES","FECHA_NACIMIENTO"), by.y = c("DOC","FECHA_NACIMIENTO"), all.x = TRUE)
# NOMBRE1+APELLIDO1 +DOCUMENTO ICFES
TMP3 <- TMP2[is.na(TMP2$DANE),c("ID_PERSONA","NUMERO_DOCUMENTO")]
TMP2<-TMP2[!is.na(TMP2$DANE),]

TMP3<- merge(x=TMP3, y=FEST1[,c("ID_PERSONA","NOMBRES_DEPURA2")], by="ID_PERSONA", all = FALSE )
TMP3<- merge(x=TMP3, y=INS_Graduados_MEDIA_SED[INS_Graduados_MEDIA_SED$GRADO_COD %in% c("11","26") & INS_Graduados_MEDIA_SED$ESTADO=="GRADUADO",],by.x =c("NOMBRES_DEPURA2"), by.y = c("NOMBRES_DEPURA2"), all = FALSE)

# UNION DE CALCULOS
TMP4<- union(TMP[,c("ID_PERSONA","PER_ID", "DANE","CODIGO_DANE_SEDE","ANO","INSTITUCION","SEDE","Divipola_MUNICIPIO_SED","CALENDARIO","SECTOR","ZONA_SEDE", "GRADO_COD", "ESTADO")], 
             TMP1[,c("ID_PERSONA","PER_ID", "DANE","CODIGO_DANE_SEDE","ANO","INSTITUCION","SEDE","Divipola_MUNICIPIO_SED","CALENDARIO","SECTOR","ZONA_SEDE", "GRADO_COD", "ESTADO")])

TMP4<- union(TMP4, 
             TMP2[,c("ID_PERSONA","PER_ID","DANE","CODIGO_DANE_SEDE","ANO","INSTITUCION","SEDE","Divipola_MUNICIPIO_SED","CALENDARIO","SECTOR","ZONA_SEDE", "GRADO_COD", "ESTADO")])

TMP4<- union(TMP4, 
             TMP3[,c("ID_PERSONA","PER_ID","DANE","CODIGO_DANE_SEDE","ANO","INSTITUCION","SEDE","Divipola_MUNICIPIO_SED","CALENDARIO","SECTOR","ZONA_SEDE", "GRADO_COD", "ESTADO")])

sqldf("select ID_PERSONA from TMP4 group by ID_PERSONA having count(1)>1")

TMP4 <- sqldf("select *,  
             ROW_NUMBER() OVER(PARTITION BY ID_PERSONA ORDER BY ANO DESC, GRADO_COD) AS ID
             from TMP4")
TMP4<- TMP4[TMP4$ID==1,c(-14)]

sqldf("select ID_PERSONA from TMP4 group by ID_PERSONA having count(1)>1")

names(TMP4)
colnames(TMP4) <- c("ID_PERSONA","SIMAT_GM_PER_ID", "SIMAT_GM_CODIGO_DANE","SIMAT_GM_CODIGO_DANE_SEDE","SIMAT_GM_ANNO_INF","SIMAT_GM_NOMBRE_ESTABLECIMIENTO","SIMAT_GM_NOMBRE_SEDE","SIMAT_GM_Divipola_MUNICIPIO","SIMAT_GM_CALENDARIO",
                    "SIMAT_GM_SECTOR","SIMAT_GM_ZONA","SIMAT_GM_GRADO", "SIMAT_GM_ESTADO_GRADO")

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP4,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

#-------------------------
# GRADUADOS MEDIA MEN
#-------------------------
names(INS_MEN_Graduados_Media)

TMP<- INS_MEN_Graduados_Media[!is.na(INS_MEN_Graduados_Media$CODIGO_DANE),
                              c("NRO_DOCUMENTO", "NOMBRE1","NOMBRE2","APELLIDO1","APELLIDO2","FECHA_NACIMIENTO","CODIGO_DANE","CODIGO_DANE_SEDE","ANNO_INF","NOMBRE_ESTABLECIMIENTO","NOMBRE_SEDE","Divipola_MUNICIPIO","SECTOR","ZONA","GRADO","ESTADO_DEFINITIVO")]
TMP <- TMP[!is.na(TMP$GRADO) & TMP$GRADO %in% c("11","26") & TMP$ESTADO_DEFINITIVO==1,]

TMP <- merge(x=FEST1[, c("ID_PERSONA","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","FECHA_NACIMIENTO")], y=TMP, 
             by.x = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","FECHA_NACIMIENTO"), 
             by.y = c("NOMBRE1","NOMBRE2","APELLIDO1","APELLIDO2","FECHA_NACIMIENTO"), all.y = TRUE  )

# TMP <- merge(x=FEST1[, c("ID_PERSONA","NUMERO_DOCUMENTO","FECHA_NACIMIENTO_SICORE")], y=TMP, 
#              by.x = c("NUMERO_DOCUMENTO","FECHA_NACIMIENTO_SICORE"), 
#              by.y = c("NRO_DOCUMENTO","FECHA_NACIMIENTO_SICORE"), all.y = TRUE  )
# 
# colnames(TMP)[colnames(TMP)=="ID_PERSONA.x"] <- "ID_PERSONA"
# 
# TMP[is.na(TMP$ID_PERSONA) & !is.na(TMP$ID_PERSONA.y), "ID_PERSONA"] <- TMP[is.na(TMP$ID_PERSONA) & !is.na(TMP$ID_PERSONA.y), "ID_PERSONA.y"]
names(TMP)

TMP <- TMP[,c(-1,-2,-3,-4,-5,-7)]

#PRIORIZAR BOGOTA
TMP$ORDEN <-2
TMP[TMP$Divipola_MUNICIPIO==11001, "ORDEN"]<-1

TMP<- sqldf("select *,  
                        ROW_NUMBER() OVER(PARTITION BY ID_PERSONA ORDER BY ORDEN, ANNO_INF DESC, GRADO ) AS ID
                        from TMP")

TMP<- TMP[TMP$ID==1,c(1:11)]
sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")


# PEGAR UNICAMENTE EN REGISTROS QUE NO TIENEN GRADO MEDIA DE SIMAT -SED
TMP <- merge(x=FEST1[is.na(FEST1$SIMAT_GM_CODIGO_DANE), c("ID_PERSONA","SIMAT_GM_CODIGO_DANE")], y=TMP, by = "ID_PERSONA", all = FALSE)
TMP<-TMP[,(-2)]


A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- paste("MEN_GM",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x ="ID_PERSONA", by.y = "MEN_GM_ID_PERSONA", all.x = TRUE)
dim(FEST1)


#-------------------------
# MATRICULA MEDIA SIMAT 2024 - MEN
#-------------------------
names(INS_MEN_Matricula_Media)

TMP<- INS_MEN_Matricula_Media[!is.na(INS_MEN_Matricula_Media$CODIGO_DANE),
                              c("NOMBRE1","NOMBRE2","APELLIDO1","APELLIDO2","FECHA_NACIMIENTO","CODIGO_DANE","CODIGO_DANE_SEDE","ANNO_INF","NOMBRE_ESTABLECIMIENTO","NOMBRE_SEDE","Divipola_MUNICIPIO","SECTOR","ZONA","GRADO","ESTADO_DEFINITIVO")]
TMP <- TMP[!is.na(TMP$GRADO) & TMP$GRADO %in% c("11","26"),]


TMP <- merge(x=FEST1[, c("ID_PERSONA","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","FECHA_NACIMIENTO")], y=TMP, 
             by.x = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","FECHA_NACIMIENTO"), 
             by.y = c("NOMBRE1","NOMBRE2","APELLIDO1","APELLIDO2","FECHA_NACIMIENTO"), all.y = TRUE  )

TMP <- TMP[TMP$ANNO_INF==2024 & TMP$ESTADO_DEFINITIVO==1,c(-1,-2,-3,-4,-5)]


# PEGAR UNICAMENTE EN REGISTROS QUE NO TIENEN GRADO MEDIA DE SIMAT -SED
TMP <- merge(x=FEST1[is.na(FEST1$SIMAT_GM_CODIGO_DANE) & is.na(FEST1$MEN_GM_CODIGO_DANE) , c("ID_PERSONA","SIMAT_GM_CODIGO_DANE")], y=TMP, by = "ID_PERSONA", all = FALSE)

names(TMP)

TMP<-TMP[,c(-2,-3,-4,-5,-6,-7)]

#PRIORIZAR BOGOTA
TMP$ORDEN <-2
TMP[TMP$Divipola_MUNICIPIO==11001, "ORDEN"]<-1

TMP<- sqldf("select *,  
                        ROW_NUMBER() OVER(PARTITION BY ID_PERSONA ORDER BY ORDEN, ANNO_INF DESC, GRADO ) AS ID
                        from TMP")

TMP<- TMP[TMP$ID==1,c(-12,-13)]
sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")


A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- paste("MEN_MTR",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x ="ID_PERSONA", by.y = "MEN_MTR_ID_PERSONA", all.x = TRUE)
dim(FEST1)


#-------------------------
# ICFES - SABER 11
#-------------------------

names(INS_ICFES_SABER11)
INS_ICFES_SABER11 <- INS_ICFES_SABER11[INS_ICFES_SABER11$CRUCE=="S",]
#INS_ICFES_SABER11 <- INS_ICFES_SABER11[INS_ICFES_SABER11$cruzo == 1,]
dim(INS_ICFES_SABER11)

ICFES_SABER11 <- pivot_wider(INS_ICFES_SABER11[INS_ICFES_SABER11$ESTADO_PUBLICACION=="PUBLICADO", ], names_from=NOMBRE_PRUEBA, values_from=c(PUNTAJE_PRUEBA,NIVEL_PRUEBA,PERCENTIL_PRUEBA))
ICFES_SABER11$FECHA_NACIMIENTO <- as.Date(ICFES_SABER11$FECHA_NACIMIENTO, "%d/%m/%y")
ICFES_SABER11$FECHA_NACIMIENTO <- as.character(ICFES_SABER11$FECHA_NACIMIENTO)

ICFES_SABER11[ICFES_SABER11$NUMERO_DOCUMENTO=="99122708221", "NUMERO_DOCUMENTO"] <-"991227-08221"

ICFES_SABER11 <- merge(x=FEST1[, c("ID_PERSONA","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOCUMENTO")], y=ICFES_SABER11, 
             by.x = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOCUMENTO"), 
             by.y = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOCUMENTO"), all.y = TRUE  )

ICFES_SABER11 <- merge(x=FEST1[, c("ID_PERSONA","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOC_ICFES")], y=ICFES_SABER11, 
                       by.x = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOC_ICFES"), 
                       by.y = c("PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","NUMERO_DOCUMENTO"), all.y = TRUE  )


colnames(ICFES_SABER11)[colnames(ICFES_SABER11)=="ID_PERSONA.x"] <-"ID_PERSONA"
ICFES_SABER11[is.na(ICFES_SABER11$ID_PERSONA), "ID_PERSONA"] <- ICFES_SABER11[is.na(ICFES_SABER11$ID_PERSONA), "ID_PERSONA.y"] 

names(ICFES_SABER11)

ICFES_SABER11_V2<- unique(ICFES_SABER11[,c(6,10:87)])


sqldf("select ID_PERSONA from ICFES_SABER11_V2 group by ID_PERSONA having count(1)>1")


ICFES_SABER11_V2$ORDEN <- 2
ICFES_SABER11_V2[ICFES_SABER11_V2$MUNICIPIO_CITACION %in% 'BOGOTÁ D.C.', "ORDEN"]<-1
cro(ICFES_SABER11_V2$ORDEN)

ICFES_SABER11_V2<- sqldf("select *,  
                        ROW_NUMBER() OVER(PARTITION BY ID_PERSONA ORDER BY ORDEN asc,  PERCENTIL_NACIONAL_GLOBAL DESC, PUESTO ASC ) AS ID
                        from ICFES_SABER11_V2")

ICFES_SABER11_V2<- ICFES_SABER11_V2[ICFES_SABER11_V2$ID==1,c(-80,-81)]
sqldf("select ID_PERSONA from ICFES_SABER11_V2 group by ID_PERSONA having count(1)>1")


View(ICFES_SABER11_V2[is.na(ICFES_SABER11_V2$PERCENTIL_NACIONAL_GLOBAL) & is.na(ICFES_SABER11_V2$PUESTO),c("ID_PERSONA","ESTUDIANTE","PUNTAJE_GLOBAL","PERIODO","PERCENTIL_NACIONAL_GLOBAL","PUESTO")])
#write.xlsx(SIN_ICFES, 'ESPEJO/FEST1_SIN_ICFES.xlsx', sheetName ="SIN_ICFES")

write.xlsx(TMP, 'ESPEJO/FEST1_SIN_PERCENTIL_Y_PRUESTO.xlsx', sheetName ="SIN_PERCENTIL_Y_PUESTO")

#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# ANALISIS ICFES SIN PERCENTIL Y PUESTO
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------

View(ICFES_SABER11_V2[is.na(ICFES_SABER11_V2$PERCENTIL_NACIONAL_GLOBAL) & is.na(ICFES_SABER11_V2$PUESTO),c("ID_PERSONA","REGISTRO_SNP","MUNICIPIO_CITACION",
                                                                                                           "PUNTAJE_GLOBAL","PERIODO","PERCENTIL_NACIONAL_GLOBAL","PUESTO")])

# INCLUIR PERCENTIL DISCAPACIDAD 
TMP1 <- read_excel("Insumos/Consolidado/06-Icfes/FEST1_SB11_PERCENTIL_DISCAPACIDAD.xlsx")
ICFES_SABER11_V2 <- merge(x=ICFES_SABER11_V2, y=TMP1[,c("ID_PERSONA","PERCENTIL_DISCAPACIDAD")], by="ID_PERSONA", all.x = TRUE )
View(ICFES_SABER11_V2[is.na(ICFES_SABER11_V2$PUESTO) & is.na(ICFES_SABER11_V2$PERCENTIL_NACIONAL_GLOBAL), c("ID_PERSONA","PUESTO","PERCENTIL_NACIONAL_GLOBAL","PERCENTIL_DISCAPACIDAD")])

names(ICFES_SABER11_V2)
cro(ICFES_SABER11_V2$PERCENTIL_DISCAPACIDAD)
str(ICFES_SABER11_V2$PERCENTIL_DISCAPACIDAD)
ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$PERCENTIL_DISCAPACIDAD),"PERCENTIL_NACIONAL_GLOBAL"] <-ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$PERCENTIL_DISCAPACIDAD),"PERCENTIL_DISCAPACIDAD"] 

View(ICFES_SABER11_V2[,c("ID_PERSONA","PERCENTIL_NACIONAL_GLOBAL","PERCENTIL_DISCAPACIDAD")])


# CALCULAR PERCENTIL PARA REGISTROS UNICAMENTE CON PUESTO
TMP <- read_excel("Insumos/Consolidado/06-Icfes/Equivalencia_Percentiles_Mililes.xlsx")
TMP1 <- ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$PUESTO) & is.na(ICFES_SABER11_V2$PERCENTIL_NACIONAL_GLOBAL),c("ID_PERSONA","PUESTO")]
TMP1$EQUIVALENCIA_PERCENTIL <-NA
# SE RECORREN LAS PERSONAS CON PUESTO Y SIN PERCENTIL
for (per in TMP1$ID_PERSONA ){
  REGISTRO <- TMP1[TMP1$ID_PERSONA==per,]
  PERCENTIL <- TMP[TMP$minPuesto <= REGISTRO$PUESTO & TMP$maxPuesto >= REGISTRO$PUESTO, ]
  # SE LLENA EL PERCENTIL EQUIVALENCIA
  TMP1[TMP1$ID_PERSONA==per,"EQUIVALENCIA_PERCENTIL"] <- PERCENTIL$EQUIVALENCIA_PERCENTIL
}
rm(per,A,REGISTRO, PERCENTIL)


ICFES_SABER11_V2 <- merge(x=ICFES_SABER11_V2, y=TMP1[,c("ID_PERSONA","EQUIVALENCIA_PERCENTIL")], by="ID_PERSONA", all.x = TRUE )
View(ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$PUESTO) & is.na(ICFES_SABER11_V2$PERCENTIL_NACIONAL_GLOBAL), c("ID_PERSONA","PUESTO","PERCENTIL_NACIONAL_GLOBAL","EQUIVALENCIA_PERCENTIL")])

names(ICFES_SABER11_V2)
cro(ICFES_SABER11_V2$EQUIVALENCIA_PERCENTIL)
str(ICFES_SABER11_V2$EQUIVALENCIA_PERCENTIL)
ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$EQUIVALENCIA_PERCENTIL),"PERCENTIL_NACIONAL_GLOBAL"] <-ICFES_SABER11_V2[!is.na(ICFES_SABER11_V2$EQUIVALENCIA_PERCENTIL),"EQUIVALENCIA_PERCENTIL"] 

View(ICFES_SABER11_V2[,c("ID_PERSONA","PERCENTIL_NACIONAL_GLOBAL","PERCENTIL_DISCAPACIDAD","EQUIVALENCIA_PERCENTIL")])



#write.xlsx(FEST1[!is.na(FEST1$SABER11_PROMEDIO_PERCENTIL_NACIONAL_GLOBAL),c("ID_PERSONA","SABER11_REGISTRO_SNP","SABER11_PERIODO","SABER11_PERCENTIL_NACIONAL_GLOBAL")], 'Insumos/Consolidado/06-ICFES_CompletarPercentil2.xlsx', sheetName ="ReconstruccionPercentil")

### PEGAR ICFES
#------------------
names(ICFES_SABER11_V2)
TMP <- ICFES_SABER11_V2[,c(-4,-6,-8,-9,-10,-11)]
names(TMP)

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("SABER11",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A


dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x = "ID_PERSONA",by.y ="SABER11_ID_PERSONA",  all.x = TRUE)
dim(FEST1)



#-------------------------
# ATENEA - ESTRATO
#-------------------------
names(INS_ATENEA_ESTRATO)
colnames(INS_ATENEA_ESTRATO)[colnames(INS_ATENEA_ESTRATO)=="FUENTE"]<-"ESTRATO_FUENTE"
colnames(INS_ATENEA_ESTRATO)[colnames(INS_ATENEA_ESTRATO)=="COMENTARIO"]<-"ESTRATO_ANALISIS"
colnames(INS_ATENEA_ESTRATO)[colnames(INS_ATENEA_ESTRATO)=="RESULTADO"]<-"ESTRATO_RESULTADO"

TMP <- INS_ATENEA_ESTRATO[,c("ID_PERSONA","ESTRATO_FUENTE","ESTRATO_ANALISIS","ESTRATO","ESTRATO_RESULTADO")]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")


dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)




#-------------------------
# ATENEA - ADMISION
#-------------------------
names(INS_ATENEA_ADMITIDO)
colnames(INS_ATENEA_ADMITIDO)[colnames(INS_ATENEA_ADMITIDO)=="ESTADO (Admitido / Estudiante Activo)"]<-"ESTADO"
colnames(INS_ATENEA_ADMITIDO)[colnames(INS_ATENEA_ADMITIDO)=="NÚMERO_PERÍODOS_PROGRAMA"]<-"NUMERO_PERIODOS_PROGRAMA"
colnames(INS_ATENEA_ADMITIDO)[colnames(INS_ATENEA_ADMITIDO)=="HABILITADO_NO HABILITADO"]<-"RESULTADO"
colnames(INS_ATENEA_ADMITIDO)[colnames(INS_ATENEA_ADMITIDO)=="SEMESTRE AL QUE INGRESA EN 2025-2"]<-"SEMESTRE_INGRESO_20252"
colnames(INS_ATENEA_ADMITIDO)[colnames(INS_ATENEA_ADMITIDO)=="Observaciones"]<-"OBSERVACIONES"

TMP <- INS_ATENEA_ADMITIDO[,c(-2)]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("ADMISION",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A


dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP, by.x="ID_PERSONA",by.y = "ADMISION_ID_PERSONA",  all.x = TRUE)
dim(FEST1)



#-------------------------
# BENEFICIARIOS JU
#-------------------------
names(INS_JU_MAESTRA)

TMP<-INS_JU_MAESTRA[,c("ID_MAESTRA","NUMERO_DOCUMENTO","E_BENEFICIARIO_CORTE","CONVOCATORIA_CORTE","ULTIMO_ESTADO_CORTE", "N_REG_CORTE","CODIGO_SNIES_PROGRAMA_CORTE","NOMBRE_DEL_PROGRAMA_CORTE","NIVEL_DE_FORMACIÓN_CORTE", "NOMBRE_INSTITUCIÓN_CORTE")]

TMP<-INS_JU_MAESTRA[,c(1,47,105,107,108,111,112,114:116)]
TMP<- merge(x=TMP, y=FEST1[,c("ID_PERSONA","PRIMER_NOMBRE","PRIMER_APELLIDO", "NUMERO_DOCUMENTO")], by="NUMERO_DOCUMENTO", all = FALSE)

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP$RESTRICCION_JU <- "S"

colnames(TMP)[colnames(TMP)=="CONVOCATORIA_CORTE"]<-"JE_CONVOCATORIA"
colnames(TMP)[colnames(TMP)=="E_BENEFICIARIO_CORTE"]<-"JE_BENEFICIARIO_JUN2025"
colnames(TMP)[colnames(TMP)=="ID_MAESTRA"]<-"JE_ID_MAESTRA"


# CRUCE CON GRADUACION SUPERIOR
TMP <- merge(x=TMP, y=unique(INS_MEN_Graduados_Superior[,c("NUM_DOCUMENTO","PRIMER_NOMBRE","PRIMER_APELLIDO","ID_PROGRAMA","AÑO_GRADO","SEMESTRE_GRADO","FECHA_GRADO")]),
             by.x = c("NUMERO_DOCUMENTO","PRIMER_NOMBRE","PRIMER_APELLIDO","CODIGO_SNIES_PROGRAMA_CORTE"),                   
             by.y = c("NUM_DOCUMENTO","PRIMER_NOMBRE","PRIMER_APELLIDO","ID_PROGRAMA"), all.x = TRUE)

# QUITAR MARCA DE RESTRICCION
TMP[!is.na(TMP$AÑO_GRADO),"RESTRICCION_JU"] <-"NA"
TMP[TMP$ULTIMO_ESTADO_CORTE=="GRADUADO","RESTRICCION_JU"] <-"NA"

cro(TMP$RESTRICCION_JU)


#write.xlsx(TMP, 'ESPEJO/FEST1_BenefJE_GradoSup.xlsx', sheetName ="Grado_Superior")

colnames(TMP)[colnames(TMP)=="CODIGO_SNIES_PROGRAMA_CORTE"]<-"JE_CODIGO_SNIES_PROGRAMA_CORTE"
colnames(TMP)[colnames(TMP)=="ULTIMO_ESTADO_CORTE"]<-"JE_ULTIMO_ESTADO_CORTE"
colnames(TMP)[colnames(TMP)=="FECHA_GRADO"]<-"JE_FECHA_GRADO"
colnames(TMP)[colnames(TMP)=="NIVEL_DE_FORMACIÓN_CORTE"]<-"JE_NIVEL_DE_FORMACIÓN_CORTE"


dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","JE_BENEFICIARIO_ABR2025","JE_CONVOCATORIA","JE_CODIGO_SNIES_PROGRAMA_CORTE","JE_NIVEL_DE_FORMACIÓN_CORTE", "JE_ULTIMO_ESTADO_CORTE","JE_FECHA_GRADO","RESTRICCION_JU")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)
FEST1[is.na(FEST1$RESTRICCION_JU),"RESTRICCION_JU"]<-"N"
cro(FEST1$RESTRICCION_JU)


#-------------------------
# FONDOS ATENEA
#-------------------------
names(INS_ATENEA_FONDO_ALIANZA)
names(INS_ATENEA_FONDO_VICTIMAS)
names(INS_ATENEA_FONDO_UPUBLICA)
names(INS_ATENEA_FONDO_TYT)

colnames(INS_ATENEA_FONDO_ALIANZA)[colnames(INS_ATENEA_FONDO_ALIANZA)=="Numero documento"]<-"NUMERO_DOCUMENTO"
colnames(INS_ATENEA_FONDO_VICTIMAS)[colnames(INS_ATENEA_FONDO_VICTIMAS)=="Numero documento"]<-"NUMERO_DOCUMENTO"
colnames(INS_ATENEA_FONDO_UPUBLICA)[colnames(INS_ATENEA_FONDO_UPUBLICA)=="ID DOCUMENTO"]<-"NUMERO_DOCUMENTO"
colnames(INS_ATENEA_FONDO_TYT)[colnames(INS_ATENEA_FONDO_TYT)=="CC"]<-"NUMERO_DOCUMENTO"
INS_ATENEA_FONDO_TYT$NUMERO_DOCUMENTO <- as.double(INS_ATENEA_FONDO_TYT$NUMERO_DOCUMENTO)

INS_ATENEA_FONDO_ALIANZA$TIPO_FONDO_ATENEA <- "FONDO_ALIANZA"
INS_ATENEA_FONDO_VICTIMAS$TIPO_FONDO_ATENEA <- "FONDO_VICTIMAS"
INS_ATENEA_FONDO_UPUBLICA$TIPO_FONDO_ATENEA <- "FONDO_UPUBLICAS"
INS_ATENEA_FONDO_TYT$TIPO_FONDO_ATENEA <- "FONDO_TYT"

TMP <- INS_ATENEA_FONDO_ALIANZA[,c("NUMERO_DOCUMENTO","TIPO_FONDO_ATENEA")]
TMP <- union_all(TMP, INS_ATENEA_FONDO_VICTIMAS[,c("NUMERO_DOCUMENTO","TIPO_FONDO_ATENEA")])  
TMP <- union_all(TMP, INS_ATENEA_FONDO_UPUBLICA[,c("NUMERO_DOCUMENTO","TIPO_FONDO_ATENEA")])  
TMP <- union_all(TMP, INS_ATENEA_FONDO_TYT[,c("NUMERO_DOCUMENTO","TIPO_FONDO_ATENEA")])  

TMP<- merge(x=TMP, y=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], by.x = "NUMERO_DOCUMENTO", by.y = "NUMERO_DOCUMENTO", all.x = TRUE)
TMP<- merge(x=TMP, y=FEST1[,c("ID_PERSONA","NUMERO_DOC_ICFES")], by.x = "NUMERO_DOCUMENTO", by.y = "NUMERO_DOC_ICFES", all.x = TRUE)

colnames(TMP)[colnames(TMP) =="ID_PERSONA.x"] <- "ID_PERSONA"
TMP[is.na(TMP$ID_PERSONA) & !is.na(TMP$ID_PERSONA.y), "ID_PERSONA" ] <- TMP[is.na(TMP$ID_PERSONA) & !is.na(TMP$ID_PERSONA.y), "ID_PERSONA.y" ]
TMP<- TMP[!is.na(TMP$ID_PERSONA),]


TMP$RA_FONDOS_ATENEA <- "S"
sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","TIPO_FONDO_ATENEA","RA_FONDOS_ATENEA")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)
FEST1[is.na(FEST1$RA_FONDOS_ATENEA),"RA_FONDOS_ATENEA"]<-"N"

cro(FEST1$RA_FONDOS_ATENEA)

cro(FEST1$TIPO_FONDO_ATENEA, FEST1$RA_FONDOS_ATENEA)

#-------------------------
# FONDOS SED
#-------------------------
names(INS_SED_FONDOS)

TMP <- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= INS_SED_FONDOS[!is.na(INS_SED_FONDOS$ESTRATEGIA),], by.x = "NUMERO_DOCUMENTO", by.y = "NUMERO_DOCUMENTO", all = FALSE)

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

colnames(TMP)[colnames(TMP)=="ESTRATEGIA"]<-"TIPO_FONDO_SED_DRESET"

TMP<- TMP[!is.na(TMP$TIPO_FONDO_SED_DRESET),]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP$RA_FONDOS_SED <- "S"

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","TIPO_FONDO_SED_DRESET","RA_FONDOS_SED")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)
FEST1[is.na(FEST1$RA_FONDOS_SED),"RA_FONDOS_SED"]<-"N"

cro(FEST1$RA_FONDOS_SED)


#-------------------------
# INHABILITADOS RENEC
#-------------------------
names(INS_RENEC)
colnames(INS_RENEC)[colnames(INS_RENEC)=="INHABILITADO"] <- "RA_INHABILITADO_RENEC"
cro(INS_RENEC$SEXO_RNEC)
INS_RENEC[!is.na(INS_RENEC$SEXO_RNEC) & INS_RENEC$SEXO_RNEC =="M","SEXO_RNEC"]<-"HOMBRE"
INS_RENEC[!is.na(INS_RENEC$SEXO_RNEC) & INS_RENEC$SEXO_RNEC =="F","SEXO_RNEC"]<-"MUJER"
INS_RENEC[!is.na(INS_RENEC$SEXO_RNEC) & INS_RENEC$SEXO_RNEC =="NB","SEXO_RNEC"]<-"NO_BINARIO"
INS_RENEC[!is.na(INS_RENEC$SEXO_RNEC) & INS_RENEC$SEXO_RNEC =="MASCULINO","SEXO_RNEC"]<-"HOMBRE"
INS_RENEC[!is.na(INS_RENEC$SEXO_RNEC) & INS_RENEC$SEXO_RNEC =="FEMENINO","SEXO_RNEC"]<-"MUJER"
cro(INS_RENEC$SEXO_RNEC)

sqldf("select ID_PERSONA from INS_RENEC group by ID_PERSONA having count(1)>1")
TMP <- INS_RENEC[,c("ID_PERSONA", "SEXO_RNEC","FECHA_NACIMIENTO_RNEC","RA_INHABILITADO_RENEC" )]
str(TMP$FECHA_NACIMIENTO_RNEC)
TMP$FECHA_NACIMIENTO_RNEC <- as.character(TMP$FECHA_NACIMIENTO_RNEC)

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

colnames(FEST1)[colnames(FEST1)=="SEXO"]<-"SEXO_SICORE"
colnames(FEST1)[colnames(FEST1)=="FECHA_NACIMIENTO"]<-"FECHA_NACIMIENTO_SICORE"

FEST1 <- sqldf("SELECT *,
                   CASE WHEN SEXO_RNEC IS NOT NULL THEN SEXO_RNEC
                   ELSE SEXO_SICORE END SEXO,
                   
                   CASE WHEN FECHA_NACIMIENTO_RNEC IS NOT NULL THEN FECHA_NACIMIENTO_RNEC
                   ELSE FECHA_NACIMIENTO_SICORE END FECHA_NACIMIENTO
                   
                   FROM FEST1")


cro(FEST1$SEXO)
cro(FEST1$SEXO, FEST1$SEXO_SICORE)
cro(FEST1$SEXO, FEST1$SEXO_RNEC)

#-------------------------
# UAESP
#-------------------------
names(INS_UAESP)

TMP <- INS_UAESP[!is.na(INS_UAESP$UAESP),c("ID_PERSONA","UAESP")]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

cro(FEST1$UAESP)

#-------------------------
# ANALISIS IDECA - GEO DIRECCION SICORE
#-------------------------

names(INS_IDECA_GEO_SICORE)

GEO <- FEST1[,c("ID_PERSONA","LOCALIDAD", "MUNICIPIO_RESIDENCIA")]
TMP <- unique(INS_IDECA_GEO_SICORE[!is.na(INS_IDECA_GEO_SICORE$localidad),c("localidad","codloc")])
TMP[TMP$localidad=="CANDELARIA", "localidad"] <-"LA CANDELARIA"

GEO <- merge(x=GEO, y=TMP, by.x = "LOCALIDAD", by.y = "localidad", all.x = TRUE )
names(GEO)
colnames(GEO) <- c("LOCALIDAD_SICORE","ID_PERSONA", "MUNICIPIO_RESIDENCIA", "codloc_SICORE")

# GEO 1 - SICORE
TMP<- unique(INS_IDECA_GEO_SICORE[!is.na(INS_IDECA_GEO_SICORE$localidad),])
A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("GEO_SICORE",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A


GEO <- merge(x=GEO, y= TMP[,c(-2,-3)], by.x = "ID_PERSONA", by.y = "GEO_SICORE_IDENTIFICADOR", all.x = TRUE )


#GEO 2 - RECIBO
names(INS_IDECA_GEO_RECIBO)
TMP<- unique(INS_IDECA_GEO_RECIBO[,c(1,10:13,16,28:49)])
colnames(TMP)[colnames(TMP)=="DEPARTAMENTO"] <-"DEPARTAMENTO_RECIBO"
colnames(TMP)[colnames(TMP)=="LOCALIDAD"] <-"LOCALIDAD_RECIBO"
colnames(TMP)[colnames(TMP)=="MUNICIPIO"] <-"MUNICIPIO_RECIBO"
colnames(TMP)[colnames(TMP)=="DIRECCION_x"] <-"DIRECCION_RECIBO"

A<- as.data.frame(names(TMP))
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("GEO_GEPM",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

names(TMP)
colnames(TMP)[colnames(TMP)=="GEO_GEPM_VALIDACION_DIRECCIÓN"] <-"GEO_GEPM_VALIDACION_DIRECCION_RECIBO"

GEO <- merge(x=GEO, y= TMP, by.x = "ID_PERSONA", by.y = "GEO_GEPM_ID_PERSONA", all.x = TRUE )

names(GEO)

#-------------------------------------------------------------------------------
# ANALISIS DE LOCALIDAD A UTILIZAR
#-------------------------------------------------------------------------------
GEO <- sqldf("select *,
             
             case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then '1.GEO_RECIBO'
                  when GEO_SICORE_codloc is not null then '2.GEO_SICORE'
                  when codloc_SICORE is not null then '3.SICORE'
                  else 'SIN_DATO' end GEO_ANALISIS,
                  
            case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_codloc
                  when GEO_SICORE_codloc is not null then GEO_SICORE_codloc
                  when codloc_SICORE is not null then codloc_SICORE
                  else null end codloc,  
                  
            case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_localidad
                  when GEO_SICORE_codloc is not null then GEO_SICORE_localidad
                  when codloc_SICORE is not null then LOCALIDAD_SICORE
                  else 'SIN_DATO' end LOCALIDAD,        
             
            -- UPZ
            case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_codupz
                  when GEO_SICORE_codloc is not null then GEO_SICORE_codupz
                  when codloc_SICORE is not null then null
                  else null end codupz,   
             
             -- nom UPZ
            case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_nomupz
                  when GEO_SICORE_codloc is not null then GEO_SICORE_nomupz
                  when codloc_SICORE is not null then null
                  else null end nomupz, 
             
             -- SECTOR_CATASTRAL
             case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_codseccat
                  when GEO_SICORE_codloc is not null then GEO_SICORE_codseccat
                  when codloc_SICORE is not null then null
                  else null end codseccat, 
                  
             -- SECTOR_CATASTRAL
             case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_nomseccat
                  when GEO_SICORE_codloc is not null then GEO_SICORE_nomseccat
                  when codloc_SICORE is not null then null
                  else null end nomseccat,     
             
             --LONG
             case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_longitude
                  when GEO_SICORE_codloc is not null then GEO_SICORE_longitude
                  when codloc_SICORE is not null then null
                  else null end longitude, 
             
             --LATIT
             case when GEO_GEPM_VALIDACION_DIRECCION_RECIBO == 'VALIDADO' AND GEO_GEPM_codloc is not null then GEO_GEPM_latitude
                  when GEO_SICORE_codloc is not null then GEO_SICORE_latitude
                  when codloc_SICORE is not null then null
                  else null end latitude 
             
             from GEO")



GEO$IGUAL_DIRECCION <- GEO$codloc_SICORE == GEO$codloc

cro(GEO$GEO_ANALISIS)
cro(GEO$GEO_ANALISIS, GEO$IGUAL_DIRECCION)
cro(GEO$GEO_GEPM_VALIDACION_DIRECCION_RECIBO, GEO$GEO_ANALISIS)


cro(GEO$MUNICIPIO_RESIDENCIA, GEO$GEO_ANALISIS)


# PEGAR EL CALCULO
names(GEO)
names(FEST1)
colnames(FEST1)[colnames(FEST1)=="LOCALIDAD"] <-"LOCALIDAD_SICORE"


dim(FEST1)
FEST1 <- merge(x=FEST1,y=GEO[,c(-2,-3)],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)



#---------------------------------------------------------------------
#-------   INFO PARA CALCULO DE PUNTAJES
#---------------------------------------------------------------------

#-------------------------
# VICTIMAS
#-------------------------
names(INS_VICTIMA_ALTA_CONSEJERIA)


TMP <- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], 
             y= unique(INS_VICTIMA_ALTA_CONSEJERIA[INS_VICTIMA_ALTA_CONSEJERIA$RUV_H_ESTADO != "NO COINCIDE O NO ENCONTRADO EN LA BASE DE DATOS",c("EXCEL_DOCUMENTO","RUV_H_ESTADO","RUV_H_HECHO","RUV_H_FUENTE"  ) ]), 
             by.x = "NUMERO_DOCUMENTO", by.y = "EXCEL_DOCUMENTO", all = FALSE )  

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP <- sqldf("select *,  
             ROW_NUMBER() OVER(PARTITION BY ID_PERSONA) AS ID
             from TMP")

TMP<- TMP[TMP$ID==1,c(-1,-6)]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP$RA_VICTIMAS <- "S"

#PEGUE
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_VICTIMAS),"RA_VICTIMAS"]<-"N"
cro(FEST1$RA_VICTIMAS)


#-------------------------
# VIOLENCIA_MUJER
#-------------------------
names(INS_VIOLENCIA_GENERO_SDMUJER)

TMP<-INS_VIOLENCIA_GENERO_SDMUJER[!is.na(INS_VIOLENCIA_GENERO_SDMUJER$`Situaciones Violencia`),]
TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= TMP, by="NUMERO_DOCUMENTO", all = FALSE )

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP<- TMP[,c("ID_PERSONA","Situaciones Violencia")]

colnames(TMP)<- c("ID_PERSONA","SDMUJER_Violencia_Genero")

TMP$RA_VIOLENCIA_GENERO <- "S"

cro(TMP$RA_VIOLENCIA_GENERO)

#PEGUE
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_VIOLENCIA_GENERO),"RA_VIOLENCIA_GENERO"]<-"N"
cro(FEST1$RA_VIOLENCIA_GENERO)

#-------------------------
# REINCORPORADO o REINSERTADO
#-------------------------
names(INS_ARN)

TMP<-INS_ARN[!is.na(INS_ARN$`BENEFICIARIOS DIRECTOS ARN`) | !is.na(INS_ARN$`FAMILIARES ARN`),]
colnames(TMP)[colnames(TMP)=="NUM_DOCUMENTO"]<-"NUMERO_DOCUMENTO"
TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= TMP, by="NUMERO_DOCUMENTO", all = FALSE )

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP<- TMP[,c("ID_PERSONA","Tipo de Proceso","Parentesco", "Persona en Proceso Principal","Número de Identificación del Grupo familiar","Código Individuo","Profesional / Facilitador")]
colnames(TMP) <- c("ID_PERSONA","Tipo de Proceso","Parentesco", "Persona en Proceso Principal","ID Grupo familiar","Codigo Individuo","Profesional Facilitador")


A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("ARN",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

TMP$RA_REINCORPORADOS_REINSERTADOS <- "S"

#PEGUE
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "ARN_ID_PERSONA",  all.x = TRUE)
dim(FEST1)


FEST1[is.na(FEST1$RA_REINCORPORADOS_REINSERTADOS),"RA_REINCORPORADOS_REINSERTADOS"]<-"N"
cro(FEST1$RA_REINCORPORADOS_REINSERTADOS)

# COMO TODOS LOS REGISTROS DE ARN SON DE HIJOS ESTO NO PUNTUA.
FEST1$RA_REINCORPORADOS_REINSERTADOS <-"N"

#-------------------------
# DISCAPACIDAD
#-------------------------
names(INS_MINSALUD_DISCAPACIDAD)

TMP <-merge(x=INS_MINSALUD_DISCAPACIDAD[INS_MINSALUD_DISCAPACIDAD$CondicionDiscapacidad!="-",], y=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")],by.x = "NUMERO_DOCUMENTO", by.y = "NUMERO_DOCUMENTO" , all = FALSE)
names(TMP)
TMP <- unique(TMP[,c(8:17)])
sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")
colnames(TMP)[colnames(TMP)=="Usuario se encuentra en el RLCPD"]<-"RLCPD_REGISTRADO"

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("MINSALUD",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

TMP$RA_DISCAPACIDAD_MINSALUD <- "N"
TMP[!is.na(TMP$MINSALUD_CondicionDiscapacidad) & TMP$MINSALUD_CondicionDiscapacidad=="SI","RA_DISCAPACIDAD_MINSALUD"] <-"S"
cro(TMP$RA_DISCAPACIDAD_MINSALUD)
cro(TMP$RA_DISCAPACIDAD_MINSALUD, TMP$MINSALUD_CondicionDiscapacidad)

#PEGUE
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "MINSALUD_ID_PERSONA",  all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_DISCAPACIDAD_MINSALUD),"RA_DISCAPACIDAD_MINSALUD"] <-"N"
cro(FEST1$RA_DISCAPACIDAD_MINSALUD)


#-------------------------
# MINDEFENSA LEY 1699
#-------------------------
names(INS_MINDEFENSA_LEY1699)

TMP<-INS_MINDEFENSA_LEY1699[!is.na(INS_MINDEFENSA_LEY1699$COINCIDENCIA),]
colnames(TMP)[colnames(TMP)=="COINCIDENCIA"]<-"CARNE_BENEFICIO"
TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= TMP, by="NUMERO_DOCUMENTO", all = FALSE )

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP<- TMP[,c("ID_PERSONA","CARNE_BENEFICIO")]

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("MINDEFENSA_LEY1699",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

TMP$RA_MINDEFENSA_LEY1699 <- "S"

#PEGUE
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "MINDEFENSA_LEY1699_ID_PERSONA",  all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_MINDEFENSA_LEY1699),"RA_MINDEFENSA_LEY1699"]<-"N"
cro(FEST1$RA_MINDEFENSA_LEY1699)

# EN COMITE (30 de MAYO 2025) SE TOMA LA DECISION QUE NO SON BENEFIARIOS PARA JE LOS HUERFANOS
FEST1$RA_MINDEFENSA_LEY1699 <-"N"

#-------------------------
# SISBEN
#-------------------------
names(INS_DNP_SISBEN)

TMP <- INS_DNP_SISBEN[,c("ID_PERSONA","Cod_mpio", "Grupo","Nivel","Clasificacion","Marca","Fec_digitacion")]
cro(TMP$Grupo)
TMP[is.na(TMP$Grupo),"Grupo"]<-"NA"
cro(TMP$Clasificacion)
TMP[is.na(TMP$Clasificacion),"Clasificacion"]<-"NA"
TMP$Fec_digitacion <- as.character(TMP$Fec_digitacion)

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("SISBEN4",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x = "ID_PERSONA",by.y = "SISBEN4_ID_PERSONA",  all.x = TRUE)
dim(FEST1)


#------------------------
#UTC -  FINALIZACION PROGRAMA
#------------------------
cro(FEST1$UTC_ESTADO_JE)
FEST1$RA_UTC <- "N"
FEST1[!is.na(FEST1$UTC_ESTADO_JE) & FEST1$UTC_ESTADO_JE=="Habilitado con puntaje adicional","RA_UTC"]<-"S"

cro(FEST1$RA_UTC, FEST1$UTC_ESTADO_JE)


#------------------------
#CONSEJERO JUVENTUDES
#------------------------
names(INS_CONSEJEROS)

TMP<- INS_CONSEJEROS

TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= TMP, by.x="NUMERO_DOCUMENTO",by.y = "No. DE DOCUMENTO",  all = FALSE )
colnames(TMP)[colnames(TMP)=="LOCALIDAD"] <-"SECGOBIERNO_CONSEJEROS"

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP$RA_CONSEJERO_JUVENTUD_ELECTO <- "S"

# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","SECGOBIERNO_CONSEJEROS", "RA_CONSEJERO_JUVENTUD_ELECTO")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_CONSEJERO_JUVENTUD_ELECTO),"RA_CONSEJERO_JUVENTUD_ELECTO"]<-"N"
cro(FEST1$RA_CONSEJERO_JUVENTUD_ELECTO)


#-------------------------
# IDRD DEPORTISTAS
#-------------------------
names(INS_IDRD_DEPORTISTAS)

TMP<- INS_IDRD_DEPORTISTAS

TMP<- merge(x=FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO")], y= TMP, by.x="NUMERO_DOCUMENTO",by.y="NUMERO_DOCUMENTO", all = FALSE )

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")

TMP <- TMP[,c("ID_PERSONA", "SECTOR","ETAPA","DEPORTE-GENERAL","DEPORTE_MODALIDAD")]

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("IDRD",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

TMP$RA_DEPORTISTA_IDRD<-"S"
cro(TMP$RA_DEPORTISTA_IDRD)

# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "IDRD_ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_DEPORTISTA_IDRD),"RA_DEPORTISTA_IDRD"]<-"N"
cro(FEST1$RA_DEPORTISTA_IDRD)


#------------------------
#RETO SDIS
# DEJO DE EXISTIR
#------------------------
# names(INS_RETO_SDIS)
# 
# TMP <- INS_RETO_SDIS[,c("ID_PERSONA","RUTA")]
# TMP$RA_RETO_SDIS <- "S"
# 
# sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")
# 
# # PEGUE AL ORIGINAL
# dim(FEST1)
# FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","RA_RETO_SDIS")],by="ID_PERSONA", all.x = TRUE)
# dim(FEST1)
# 
# FEST1[is.na(FEST1$RA_RETO_SDIS),"RA_RETO_SDIS"]<-"N"
# cro(FEST1$RA_RETO_SDIS)

FEST1$RA_RETO_SDIS <- "N"

#------------------------
#PARCEROS
#------------------------
names(INS_PARCEROS)

TMP <- INS_PARCEROS[,c("ID_PERSONA","OBSERVACIONES DE RUTA DE INCLUSIÓN")]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")
TMP$RA_PARCEROS<-"S"

# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","RA_PARCEROS")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_PARCEROS),"RA_PARCEROS"]<-"N"
cro(FEST1$RA_PARCEROS)


#------------------------
#JOVENES CON OPORTUNIDADES
#------------------------
names(INS_JOVENES_OPORTU)

TMP <- INS_JOVENES_OPORTU[,c("ID_PERSONA","OBSERVACIONES DE RUTA DE INCLUSIÓN")]

sqldf("select ID_PERSONA from TMP group by ID_PERSONA having count(1)>1")
TMP$RA_JOVENES_OPORTUNIDADES<-"S"

# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP[,c("ID_PERSONA","RA_JOVENES_OPORTUNIDADES")],by="ID_PERSONA", all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$RA_JOVENES_OPORTUNIDADES),"RA_JOVENES_OPORTUNIDADES"]<-"N"
cro(FEST1$RA_JOVENES_OPORTUNIDADES)


#------------------------
# ETNIA - VALIDACION ATENEA
#------------------------
names(INS_ATENEA_ETNIA)

TMP <- INS_ATENEA_ETNIA[!is.na(INS_ATENEA_ETNIA$`VALIDACION ETNIA`),c("ID_PERSONA","VALIDACION ETNIA")]

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("ATENEA_VERIFICA_ETNIA",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

names(TMP)
colnames(TMP)[colnames(TMP)=="ATENEA_VERIFICA_ETNIA_VALIDACION_ETNIA"]<-"ATENEA_VERIFICA_ETNIA_ESTADO"

cro(TMP$ATENEA_VERIFICA_ETNIA_ESTADO)
TMP$ATENEA_PUNTUA_ETNIA <- "N"
TMP[TMP$ATENEA_VERIFICA_ETNIA_ESTADO=="VALIDADO", "ATENEA_PUNTUA_ETNIA"] <- "S"

sqldf("select ATENEA_VERIFICA_ETNIA_ID_PERSONA from TMP group by ATENEA_VERIFICA_ETNIA_ID_PERSONA having count(1)>1")

# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "ATENEA_VERIFICA_ETNIA_ID_PERSONA",  all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$ATENEA_PUNTUA_ETNIA),"ATENEA_PUNTUA_ETNIA"]<-"NA"
cro(FEST1$ATENEA_VERIFICA_ETNIA_ESTADO)
cro(FEST1$ATENEA_PUNTUA_ETNIA)
cro(FEST1$ETNIA, FEST1$ATENEA_PUNTUA_ETNIA)

#-------------------------
# VERIFICACION REGISTRO CIVIL
#-------------------------
names(INS_RC)

TMP <- INS_RC[,c("ID_PERSONA","ESTADO_RC")]
TMP[is.na(TMP$ESTADO_RC), "ESTADO_RC"] <-"SIN_SOPORTE"

A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- paste("ATENEA_VERIFICA_RC",A$`names(TMP)`,sep = "_")
A<- A$`names(TMP)`
colnames(TMP) <- A

names(TMP)

colnames(TMP)[colnames(TMP)=="ATENEA_VERIFICA_RC_ESTADO_RC"]<-"ATENEA_VERIFICA_RC_ESTADO"

cro(TMP$ATENEA_VERIFICA_RC_ESTADO)

TMP$ATENEA_PUNTUA_HIJOS <- "N"
TMP[TMP$ATENEA_VERIFICA_RC_ESTADO=="VALIDADO", "ATENEA_PUNTUA_HIJOS"] <- "S"

sqldf("select ATENEA_VERIFICA_RC_ID_PERSONA from TMP group by ATENEA_VERIFICA_RC_ID_PERSONA having count(1)>1")
cro(TMP$ATENEA_VERIFICA_RC_ESTADO, TMP$ATENEA_PUNTUA_HIJOS)

dim(FEST1)
FEST1 <- merge(x=FEST1,y=TMP,by.x="ID_PERSONA",by.y = "ATENEA_VERIFICA_RC_ID_PERSONA",  all.x = TRUE)
dim(FEST1)

FEST1[is.na(FEST1$ATENEA_PUNTUA_HIJOS), "ATENEA_PUNTUA_HIJOS"]<-"NA"

cro(FEST1$INFO_HIJOS, FEST1$ATENEA_PUNTUA_HIJOS, FEST1$SEXO)


View(FEST1[,c("ID_PERSONA","TIPO_DOCUMENTO","NUMERO_DOCUMENTO","PRIMER_NOMBRE","PRIMER_APELLIDO", "SEXO_SICORE","SEXO_RNEC","INFO_HIJOS","ATENEA_VERIFICA_RC_ESTADO", "ATENEA_PUNTUA_HIJOS" )])


#--------------------------------------------------------
# AJUSTE VARIABLE RA_ICFES_VALIDACION
# ES VALIDACION CUANDO TIENE INFO EN VALIDACION Y NO EN GRADO MEDIA
# ES VALIDACION CUANDO TIENE INFO EN VALIDACION Y GRADO MEDIA ES DIF BOGOTA
#--------------------------------------------------------

FEST1<- sqldf("SELECT *, 
            case 
            
           -- 1. SABER11 y no tiene registro en graduación o matricula
            when SABER11_REGISTRO_SNP is not null AND  SABER11_REGISTRO_SNP like 'VG%'  
                                                       AND SIMAT_GM_Divipola_MUNICIPIO is null
                                                       AND MEN_GM_Divipola_MUNICIPIO is null THEN 'S' 
            
            --2. SABER11 ES VG y el divipola de grado MEN es diferente a Bogota
            when SABER11_REGISTRO_SNP is not null AND SABER11_REGISTRO_SNP like 'VG%'  
                                                       AND MEN_GM_Divipola_MUNICIPIO is not null 
                                                       AND MEN_GM_Divipola_MUNICIPIO != 11001 THEN 'S'
            

            -- 3.ES registro en graduación o matricula
            when    SIMAT_GM_Divipola_MUNICIPIO is not null
                  OR MEN_GM_Divipola_MUNICIPIO is not null THEN 'N'
                                                        
            else 'DV' end RA_ICFES_VALIDACION from FEST1")

cro(FEST1$RA_ICFES_VALIDACION)

################################
# CALCULO HABILITADOS 
################################
FEST1$CORTE_EDAD <- as.integer(age_calc(as.Date(FEST1$FECHA_NACIMIENTO, format = "%Y-%m-%d"), enddate = as.Date("2025-06-27"), units = "years", precise = TRUE))
cro(FEST1$CORTE_EDAD)


#------------------------------
# CRITERIO A
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN  SIMAT_GM_Divipola_MUNICIPIO is null 
                          AND MEN_GM_Divipola_MUNICIPIO is null 
                          AND SABER11_PERIODO is null  
                          THEN '01_SIN_GM_SIN_SABER11'

                     WHEN RA_ICFES_VALIDACION=='N' AND SIMAT_GM_Divipola_MUNICIPIO is not null AND SIMAT_GM_Divipola_MUNICIPIO!='11001' THEN '02_SIMAT_GM_NOBOGOTA'
                     WHEN RA_ICFES_VALIDACION=='N' AND MEN_GM_Divipola_MUNICIPIO  is not null AND MEN_GM_Divipola_MUNICIPIO!='11001' THEN '02_MEN_GM_NOBOGOTA' 
                     
                     WHEN RA_ICFES_VALIDACION=='S' AND SABER11_REGISTRO_SNP like 'VG%' AND SABER11_PUNTAJE_GLOBAL < 30 THEN '05_VALIDANTE_MENOR30_PUNTOS'
                     WHEN RA_ICFES_VALIDACION=='S' AND SABER11_REGISTRO_SNP like 'VG%' AND SABER11_MUNICIPIO_CITACION !='BOGOTÁ D.C.'  THEN '05_VALIDANTE_NO_BOGOTA'
                     
                     WHEN RA_ICFES_VALIDACION=='DV' AND SABER11_REGISTRO_SNP like 'AC%' THEN '06_SABER11_NO_ES_VALIDANTE'
                     
                     ELSE 'HABILITADO' END HABILITADO_A
                     FROM FEST1")

cro(FEST1$HABILITADO_A)
View(FEST1[,c("ID_PERSONA","NUMERO_DOCUMENTO","PRIMER_NOMBRE","SEGUNDO_NOMBRE","PRIMER_APELLIDO","SEGUNDO_APELLIDO","FECHA_NACIMIENTO","SIMAT_GM_Divipola_MUNICIPIO","MEN_GM_Divipola_MUNICIPIO","RA_ICFES_VALIDACION","SABER11_REGISTRO_SNP","SABER11_MUNICIPIO_CITACION","SABER11_PUNTAJE_GLOBAL", "HABILITADO_A")])

#------------------------------
# CRITERIO B
#------------------------------
cro(FEST1$SABER11_PERIODO)
str(FEST1$SABER11_PERIODO)
FEST1$SABER11_PERIODO <- as.double(FEST1$SABER11_PERIODO)
FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN SABER11_PERIODO is null THEN 'NO_HABILITADO' 
                     ELSE 'HABILITADO' END HABILITADO_B
                     FROM FEST1")
cro(FEST1$HABILITADO_B)
View(FEST1[,c("ID_PERSONA","SABER11_PERIODO","SABER11_REGISTRO_SNP", "SABER11_PUNTAJE_GLOBAL","SABER11_PUESTO","SABER11_PERCENTIL_NACIONAL_GLOBAL",  "HABILITADO_B")])

#------------------------------
# CRITERIO C
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN CORTE_EDAD > 28 THEN 'NO_HABILITADO' ELSE 'HABILITADO' END HABILITADO_C
                     FROM FEST1")
cro(FEST1$HABILITADO_C)

View(FEST1[,c("ID_PERSONA","FECHA_NACIMIENTO_SICORE","FECHA_NACIMIENTO_RNEC", "FECHA_NACIMIENTO","CORTE_EDAD","HABILITADO_C")])

#------------------------------
# CRITERIO D
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN ESTRATO_RESULTADO != 'HABILITADO' THEN 'NO_HABILITADO' ELSE 'HABILITADO' END HABILITADO_D
                     FROM FEST1")
cro(FEST1$HABILITADO_D)
cro(FEST1$ESTRATO_RESULTADO, FEST1$HABILITADO_D)

#------------------------------
# CRITERIO E
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN ADMISION_RESULTADO != 'HABILITADO' THEN 'NO_HABILITADO' ELSE 'HABILITADO' END HABILITADO_E
                     FROM FEST1")
cro(FEST1$HABILITADO_E)
cro(FEST1$ADMISION_RESULTADO, FEST1$HABILITADO_E)

#------------------------------
# CRITERIO F
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                    -- EGRESADO SUPERIOR
                    WHEN GRADUADO_Universitario IS NOT NULL THEN 'NO_HABILITADO'
                     
                     ELSE 'HABILITADO' END HABILITADO_F 
             FROM FEST1")

cro(FEST1$HABILITADO_F)
View(FEST1[,c("ID_PERSONA","GRADUADO_Tecnologico","GRADUADO_FormacionTecnicaProfesional","GRADUADO_Universitario","GRADUADO_EspecializacionTecnologica","GRADUADO_EspecializacionUniversitaria", "HABILITADO_F")])


#------------------------------
# CRITERIO H
#------------------------------
# FEST1 <- sqldf("SELECT *,
#                      CASE 
#                     -- JU
#                     WHEN RESTRICCION_JU =='S' THEN 'ES_BENEF_JU'
#                     -- UTC
#                     WHEN UTC_ESTADO_JE is not null and UTC_ESTADO_JE =='Bloqueado' THEN 'ES_BENEF_UTC'
#                     -- FONDOS
#                     WHEN RA_FONDOS_ATENEA =='S' OR RA_FONDOS_SED =='S' THEN 'ES_FONDOS'
#                     
#                      ELSE 'HABILITADO' END HABILITADO_H
#              FROM FEST1")
# 
# cro(FEST1$HABILITADO_H)

# View(FEST1[,c("ID_PERSONA","RESTRICCION_JU","UTC_ESTADO_JE","RA_FONDOS_ATENEA","RA_FONDOS_SED","HABILITADO_H")])


#------------------------------
# CRITERIO I - RNEC
#------------------------------
FEST1 <- sqldf("SELECT *,
                     CASE 
                    -- RNEC
                    WHEN RA_INHABILITADO_RENEC is not null AND RA_INHABILITADO_RENEC NOT IN ('HABILITADO') THEN 'NO_HABILITADO'
                    
                     ELSE 'HABILITADO' END HABILITADO_I
             FROM FEST1")


cro(FEST1$RA_INHABILITADO_RENEC, FEST1$HABILITADO_I)

#=================================================================================================================================
# CALCULO HABILITACION SECUENCIAS - BOGOTA
#=================================================================================================================================
FEST1 <- sqldf("SELECT *,
         
         CASE 
                     WHEN HABILITADO_A !='HABILITADO'  THEN 'INHABILITA_REQUISITO_A'
                     WHEN HABILITADO_B !='HABILITADO'  THEN 'INHABILITA_REQUISITO_B'
                     WHEN HABILITADO_C !='HABILITADO'  THEN 'INHABILITA_REQUISITO_C'
                     WHEN HABILITADO_D !='HABILITADO'  THEN 'INHABILITA_REQUISITO_D'
                     WHEN HABILITADO_E !='HABILITADO'  THEN 'INHABILITA_REQUISITO_E'
                     WHEN HABILITADO_F !='HABILITADO'  THEN 'INHABILITA_REQUISITO_F'
                     --WHEN HABILITADO_H !='HABILITADO'  THEN 'INHABILITA_REQUISITO_H'
                     WHEN HABILITADO_I !='HABILITADO'  THEN 'INHABILITA_REQUISITO_I'
              ELSE 'HABILITADO' END HABILITADO
             
             FROM FEST1")

cro(FEST1$HABILITADO)

#### MARCAS PARA VERIFICACION
# 
# FEST1 <- sqldf("SELECT *,
#                      CASE 
#                      WHEN HABILITADO == '00_HABILITADO' AND RA_ICFES_VALIDACION=='N' AND MEN_GM_DIVIPOLA_MUNICIPIO_GRADO_MEDIA IS NULL AND SIMAT_GM_Divipola_MUNICIPIO IS NULL THEN '1-HABILITADO SUJETO A VALIDACIÓN DE INFORMACIÓN - GEPM'
#                      WHEN HABILITADO == '00_HABILITADO' AND RA_ICFES_VALIDACION=='S' AND VALIDACION_ICFES_MUNICIPIO_CITACION IS NULL THEN '1-HABILITADO SUJETO A VALIDACIÓN DE INFORMACIÓN - GEPM'
#                      ELSE NULL END VERIFICACION_GRADUACION_MEDIA
#                      FROM FEST1")
# 
# cro(FEST1$VERIFICACION_GRADUACION_MEDIA)
# 
# 
# 
# FEST1 <- sqldf("SELECT *,
#                      CASE 
#                      WHEN HABILITADO == '00_HABILITADO' AND RA_INHABILITADO_RENEC==' REVISAR_NOMBRE' THEN '1-HABILITADO SUJETO A VALIDACIÓN DE INFORMACIÓN - GEPM'
#                      ELSE NULL END VERIFICACION_IDENTIDAD
#                      FROM FEST1")
# 
# cro(FEST1$VERIFICACION_IDENTIDAD)
# 
# write.xlsx(FEST1[,c(1,35:158)], 'ESPEJO/FEST1_HABILITACION_A_20250707.xlsx', sheetName ="FEST1_HABILITACION")
# write.xlsx(FEST1[is.na(FEST1$SIMAT_GM_CODIGO_DANE) & is.na(FEST1$MEN_GM_CODIGO_DANE) ,c(1:12,29,30,36,47,57:67)], 'ESPEJO/FEST1_SIN_GRADO_MEDIA_20250703.xlsx', sheetName ="FEST1_HABILITACION")
#write.xlsx(FEST1[,c(1,73:104)], 'ESPEJO/FEST1_HABILITACION_20250526.xlsx', sheetName ="CRUCES_PUNTUACION")


#=================================================================================================================================

#-------------------------------------------------------------------------------
# ORDENAMIENTO
# 5.2.2. Actividad 3: Aplicación de criterios de desempate
# Criterios de desempate.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# punto e) Cuando no se logre el desempate por los criterios anteriores, se asignará el cupo de forma aleatoria.
# SEMILLA 2025-06-27 (Cierre de convocatoria)
#-------------------------------------------------------------------------------
set.seed(20250627)
FEST1$SEMILLA <-  FEST1$ID_PERSONA[sample(length(FEST1$ID_PERSONA))]
sqldf("select SEMILLA FROM FEST1 GROUP BY SEMILLA HAVING COUNT(1)>1")


#PRUEBA DE ORDENAMIENTO
View(FEST1[order(-FEST1$SABER11_PERCENTIL_NACIONAL_GLOBAL, 
                 -FEST1$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS, 
                 -FEST1$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA,
                 -FEST1$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS, 
                 -FEST1$SABER11_PUNTAJE_PRUEBA_MATEMÁTICA,
                 -FEST1$SABER11_PUNTAJE_PRUEBA_LENGUAJE,
                 -FEST1$SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES),
           c("ID_PERSONA","SABER11_PERIODO","SABER11_PUNTAJE_GLOBAL","SABER11_PERCENTIL_NACIONAL_GLOBAL","SABER11_PUESTO","SABER11_PUNTAJE_PRUEBA_MATEMÁTICA","SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS",
             "SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA","SABER11_PUNTAJE_PRUEBA_LENGUAJE","SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS","SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES")])

#----------------------------------------
#ORDENAMIENTO FINAL
# 5.1.5.3.1. Criterios de desempate.
#----------------------------------------
FEST1_ORDENAMIENTO <- FEST1[,c("ID_PERSONA","SABER11_PERCENTIL_NACIONAL_GLOBAL","SABER11_PUNTAJE_PRUEBA_MATEMÁTICA","SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS",
                               "SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA","SABER11_PUNTAJE_PRUEBA_LENGUAJE",
                               "SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS","SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES","SEMILLA")]
#HOMOGENIZACION MATEMATICAS
FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_MATEMÁTICA), "SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS" ] <-
  FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_MATEMÁTICA), "SABER11_PUNTAJE_PRUEBA_MATEMÁTICA" ]

#HOMOGENIZACION LECTURA_CRÍTICA
FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_LENGUAJE), "SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA" ] <-
  FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_LENGUAJE), "SABER11_PUNTAJE_PRUEBA_LENGUAJE" ]

#HOMOGENIZACION SOCIALES_Y_CIUDADANAS
FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES), "SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS" ] <-
  FEST1_ORDENAMIENTO[is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS) & !is.na(FEST1_ORDENAMIENTO$SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES), "SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES" ]

FEST1_ORDENAMIENTO <- sqldf("select 
               ROW_NUMBER() OVER(ORDER BY SABER11_PERCENTIL_NACIONAL_GLOBAL desc,
                                          SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS desc,
                                          SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA desc,
                                          SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS desc,
                                          SEMILLA asc ) AS FEST1_LLAVE_PER,
               *
              FROM FEST1_ORDENAMIENTO")

TMP <- sqldf("select SABER11_PERCENTIL_NACIONAL_GLOBAL,SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS,SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA,SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS, count(1) USA_SEMILLA
              FROM FEST1_ORDENAMIENTO group by SABER11_PERCENTIL_NACIONAL_GLOBAL,SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS,SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA,SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS
       having count(1) >1")

FEST1_ORDENAMIENTO <- merge(x=FEST1_ORDENAMIENTO, y=TMP, by=c("SABER11_PERCENTIL_NACIONAL_GLOBAL","SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS","SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA","SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS"), all.x = TRUE)


# PEGUE AL ORIGINAL
dim(FEST1)
FEST1 <- merge(x=FEST1,y=FEST1_ORDENAMIENTO[,c("ID_PERSONA","FEST1_LLAVE_PER","USA_SEMILLA")],by="ID_PERSONA",  all.x = TRUE)
dim(FEST1)


write.xlsx(FEST1[order(FEST1$FEST1_LLAVE_PER),], 'ESPEJO/FEST1_PER_VF_20250716.xlsx', sheetName ="FEST1_PERSONA_UNICA")

#===============================================================================
# VERIFICACION POR IES
#===============================================================================

# FEST1 <- sqldf("SELECT *,
#                      CASE 
#                      
#                      WHEN HABILITADO == '00_HABILITADO' AND RA_ICFES_VALIDACION=='N' 
#                                                         AND MEN_GM_Divipola_MUNICIPIO is null 
#                                                         AND SIMAT_GM_Divipola_MUNICIPIO is null 
#                                                         AND SED_MTR_CODIGO_DANE is null 
#                                                         AND SABER11_PERIODO is not null 
#                                                         AND SABER11_CODIGODANE_ESTABLECIMIENTO is not null THEN '1-HABILITADO_ELEGIBLE SUJETO A VALIDACIÓN DE INFORMACIÓN - GEPM'
#                      
#                      ELSE NULL END VERIFICACION_GRADUACION_MEDIA
#                      FROM FEST1")
# 
# cro(FEST1$VERIFICACION_GRADUACION_MEDIA)
# 
# 
# 
# FEST1 <- sqldf("SELECT *,
#                      CASE 
#                      
#                      WHEN HABILITADO == '00_HABILITADO' AND RA_INHABILITADO_RENEC=='REVISAR_NOMBRE' THEN '1-HABILITADO_ELEGIBLE SUJETO A VALIDACIÓN DE INFORMACIÓN - GEPM'
#                      
#                      ELSE NULL END VERIFICACION_NOMBRES_APELLIDOS
#                      FROM FEST1")
# 
# cro(FEST1$VERIFICACION_NOMBRES_APELLIDOS)


#=========================================================================
# CALCULO DE ELEGIBLES Y LISTAS DE ESPERA
# =========================================================================

SNIES_PROGRAMAS <- read_excel("Insumos/Consolidado/SNIES/Programas_20250714.xlsx",sheet = "Programas")
SNIES_PROGRAMAS<- SNIES_PROGRAMAS[!is.na(SNIES_PROGRAMAS$CÓDIGO_SNIES_DEL_PROGRAMA),]

FEST1_CUPOS_VALORES <- read_excel("Oferta_y_Costos/OFERTA HABILITADA FINAL.xlsx", skip = 2)

# CARGUE PERSONA - OFERTA
FEST1_PER_OFERTA <- read_excel("Inscritos/20250626_FEST_PersonaOfertaCierreConvocatoria_V2.xlsx")
names(FEST1_PER_OFERTA)
#--------------------------------
#PEGAR Datos de SNIES
#--------------------------------
TMP <- merge(x=FEST1_PER_OFERTA[,c("ID_PERSONA","ID_PERSONA_OFERTA","CODIGO_SNIES_PROGRAMA")], y=unique(SNIES_PROGRAMAS[,c("CÓDIGO_SNIES_DEL_PROGRAMA","CÓDIGO_INSTITUCIÓN","NIVEL_DE_FORMACIÓN","MODALIDAD","ÁREA_DE_CONOCIMIENTO","NÚCLEO_BÁSICO_DEL_CONOCIMIENTO")]), by.x="CODIGO_SNIES_PROGRAMA",by.y = "CÓDIGO_SNIES_DEL_PROGRAMA",  all.x = TRUE)
TMP<-TMP[,c(-1)]
names(TMP)
colnames(TMP)<-c("ID_PERSONA","ID_PERSONA_OFERTA","CODIGO_SNIES_IES","NIVEL_FORMACION","MODALIDAD","AREA_DE_CONOCIMIENTO","NUCLEO_BASICO_DEL_CONOCIMIENTO") 
FEST1_PER_OFERTA <- merge(x=FEST1_PER_OFERTA, y=TMP, by= c("ID_PERSONA","ID_PERSONA_OFERTA"), all = FALSE)

#===============================================================================
# CALCULO ELEGIBLES
#===============================================================================

BASE_OFERTA_FEST1<-unique(FEST1_PER_OFERTA[,c("ID_OFERTA_PROGRAMA","CODIGO_SNIES_IES", "NOMBRE_INSTITUCION_SUPERIOR","CODIGO_SNIES_PROGRAMA","NOMBRE_PROGRAMA","TIPO_CICLO","NIVEL_FORMACION","CUPOS_DISPONIBLES")])
names(FEST1_CUPOS_VALORES)

#OFERTA
TMP <- FEST1_CUPOS_VALORES[,c(1,14,20,21,23,24,26:43)]
A<- as.data.frame(names(TMP)) 
A$`names(TMP)` <- gsub("\\s", "_", A$`names(TMP)`)
A$`names(TMP)` <- gsub("-_", "", A$`names(TMP)`)
A$`names(TMP)` <- toupper(A$`names(TMP)`)
A<- A$`names(TMP)`
colnames(TMP) <- A
names(TMP)
colnames(TMP)[colnames(TMP)=="NO."] <- "N_REG_OFERTA"
colnames(TMP)[colnames(TMP)=="NÚMERO_DE_CUPOS_A_OFERTAR___(EN_CASO_DE_NO_TENER_TOPE_ESCRIBA_INDEFINIDO)"] <- "NUMERO_DE_CUPOS_A_OFERTAR"
colnames(TMP)[colnames(TMP)=="PORCENTAJE_DE_DESCUENTO_A_OFERTAR__(DEBERÁ_SER_MÍNIMO_DEL_30%_PARA_LA_OFERTA_GENERAL_Y_DEL_10%_PARA_MEDICINA)"] <- "PORCENTAJE_DE_DESCUENTO_A_OFERTAR"


BASE_OFERTA_FEST1<-merge(x=BASE_OFERTA_FEST1, y=TMP, by.x = "CODIGO_SNIES_PROGRAMA", by.y = "CÓDIGO_SNIES_DEL_PROGRAMA_A_OFERTAR", all.x = TRUE ) 

#PRUBA
sum(TMP$NUMERO_DE_CUPOS_A_OFERTAR)
sum(BASE_OFERTA_FEST1$NUMERO_DE_CUPOS_A_OFERTAR)


# PEGAR VARIABLES DE PERSONA UNICA
dim(FEST1_PER_OFERTA)
FEST1_PER_OFERTA <- merge(x=FEST1_PER_OFERTA, y=FEST1[,c("ID_PERSONA","FEST1_LLAVE_PER","HABILITADO","ADMISION_CODIGO_SNIES_PROGRAMA","ADMISION_NUMERO_PERIODOS_PROGRAMA", "ADMISION_SEMESTRE_INGRESO_20252")], by="ID_PERSONA", all = FALSE )
dim(FEST1_PER_OFERTA)


#-------------------------------------------------------------------------------
# CONSTRUCCION DATAFRAME DE HABILITADOS POR PERSONA PARA
# 1. CALCULO INHABILITAD POR IES (5.1.3.1. Requisitos y costos adicionales establecidos por las IES)
# 2. CALCULO DE ELEGIBLES
#-------------------------------------------------------------------------------

TMP_ELEGIBLE<- FEST1_PER_OFERTA[FEST1_PER_OFERTA$HABILITADO=="HABILITADO",]


#-------------------------------------------------------------------------------
#ELEGIBLES 
#-------------------------------------------------------------------------------

TMP_ELEGIBLE<- TMP_ELEGIBLE[order(TMP_ELEGIBLE$FEST1_LLAVE_PER),] 
TMP_ELEGIBLE$ADMISION_SEMESTRE_INGRESO_20252 <- as.double(TMP_ELEGIBLE$ADMISION_SEMESTRE_INGRESO_20252)
BASE_OFERTA_FEST1$CUPOS_CONTROL<-BASE_OFERTA_FEST1$NUMERO_DE_CUPOS_A_OFERTAR
PPT_FEST1 <- 66826532410

TMP_ELEGIBLE$MAXIMO_PERIODOS_OFERTA <- NA
TMP_ELEGIBLE$FINANCIAR_SEMESTRES <- 0
TMP_ELEGIBLE$FINANCIAR_SEMESTRES_EN_CERO <- 0
TMP_ELEGIBLE$FINANCIAR_COSTO <- 0
TMP_ELEGIBLE$FINANCIAR_COSTO_CON_DESCUENTO <- 0
TMP_ELEGIBLE$ELEGIBLE <- NA
TMP_ELEGIBLE$ASIGNACION <- NA
TMP_ELEGIBLE$N_REG_OFERTA <- NA



for (aspirante in unique(TMP_ELEGIBLE$FEST1_LLAVE_PER)) { # RECORRER POR PERSONA ordenada por la LLAVE
  print(aspirante)
  
  # DATAFRAME DE LA PERSONA
  PERSONA_OFERTA <- TMP_ELEGIBLE[TMP_ELEGIBLE$FEST1_LLAVE_PER==aspirante,]
  
  #DATOS OFERTA A EVALUAR
  EVALUAR_OFERTA <- BASE_OFERTA_FEST1[BASE_OFERTA_FEST1$ID_OFERTA_PROGRAMA==PERSONA_OFERTA$ID_OFERTA_PROGRAMA,]
  
  # COSTO_OFERTA
  COSTO_OFERTA <- EVALUAR_OFERTA[,c("ID_OFERTA_PROGRAMA","CODIGO_SNIES_PROGRAMA","1","2","3","4","5","6","7","8","9","10","11","12")]
  COSTO_OFERTA <- pivot_longer(COSTO_OFERTA, cols = 3:14, names_to = "SEMESTRE", values_to = "COSTO_SEMESTRE")
  COSTO_OFERTA$SEMESTRE <- as.double(COSTO_OFERTA$SEMESTRE)
  
  # DEPURAR  COSTO OFERTA CON SEMESTRES A FINANCIAR (ojo se debe incluir el semestre de admisión por eso se resta -1)
  #COSTO_OFERTA <- COSTO_OFERTA[COSTO_OFERTA$SEMESTRE <= (EVALUAR_OFERTA$NÚMERO_DE_PERÍODOS - (PERSONA_OFERTA$ADMISION_SEMESTRE_INGRESO_20252-1)), ]
  COSTO_OFERTA <- COSTO_OFERTA[COSTO_OFERTA$SEMESTRE <= (PERSONA_OFERTA$ADMISION_NUMERO_PERIODOS_PROGRAMA - (PERSONA_OFERTA$ADMISION_SEMESTRE_INGRESO_20252-1)), ]
  
  SEMESTRES_EN_CERO <-nrow(COSTO_OFERTA[COSTO_OFERTA$COSTO_SEMESTRE==0,])
  
    #TOTAL SEMESTRES PARA FINANCIAR
  TOTAL_FINANCIAR_SEMESTRES <- nrow(COSTO_OFERTA)
  
  #TOTAL COSTO A FINANCIAR
  TOTAL_FINANCIAR_COSTO <- sum(COSTO_OFERTA$COSTO_SEMESTRE)
  
  # APLICAR DESCUENTO DESCUENTO 
  DESCUENTO <- TOTAL_FINANCIAR_COSTO * EVALUAR_OFERTA$PORCENTAJE_DE_DESCUENTO_A_OFERTAR 
  
  TOTAL_FINANCIAR_COSTO_DESCUENTO <- TOTAL_FINANCIAR_COSTO - DESCUENTO
  
  #---------------------------------------------------------------------------
  #--------EL PRESUPUESTO FEST CUBRE EL COSTO A FINANCIAR---------------------
  #--------------------------------------------------------------------------- 
  if(PPT_FEST1>=TOTAL_FINANCIAR_COSTO_DESCUENTO){ # HAY BOLSA PARA CUBRIR PROGRAMA
    
    
    #---------------------------------------------------------------------------
    #--------EL SEMESTRES A FINANCIAR ES MENOR O IGUAL AL MAXIMO----------------
    #---------------------------------------------------------------------------
    #if(TOTAL_FINANCIAR_SEMESTRES > 0) {
      
      
      #---------------------------------------------------------------------------
      #---------------------OFERTA CON RESTRICCION DE CUPOS-----------------------
      #---------------------------------------------------------------------------
      if(EVALUAR_OFERTA$NUMERO_DE_CUPOS_A_OFERTAR > 0 & EVALUAR_OFERTA$CUPOS_CONTROL >0){
        
        #COMO CUMPLE HACEMOS LAS MARCACIONES CORRESPONDIENTES
        
        #MARCAMOS DATAFRAME DE ELEGIBLES
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ELEGIBLE"] <- EVALUAR_OFERTA$CUPOS_CONTROL
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ASIGNACION"] <- "ELEGIBLE"
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_SEMESTRES"] <- TOTAL_FINANCIAR_SEMESTRES
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_SEMESTRES_EN_CERO"] <- SEMESTRES_EN_CERO
        
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_COSTO"] <- TOTAL_FINANCIAR_COSTO
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_COSTO_CON_DESCUENTO"] <- TOTAL_FINANCIAR_COSTO_DESCUENTO
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "N_REG_OFERTA"] <- EVALUAR_OFERTA$N_REG_OFERTA
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "MAXIMO_PERIODOS_OFERTA"] <- EVALUAR_OFERTA$NÚMERO_DE_PERÍODOS
        
        
        #AFECTAMOS CUPO
        nuevo_cupo<- EVALUAR_OFERTA$CUPOS_CONTROL - 1
        BASE_OFERTA_FEST1[BASE_OFERTA_FEST1$ID_OFERTA_PROGRAMA==PERSONA_OFERTA$ID_OFERTA_PROGRAMA & BASE_OFERTA_FEST1$N_REG_OFERTA==EVALUAR_OFERTA$N_REG_OFERTA, "CUPOS_CONTROL" ] <- nuevo_cupo
        
        #AFECTAMOS PRESUPUESTO
        PPT_FEST1<- PPT_FEST1 - TOTAL_FINANCIAR_COSTO_DESCUENTO
      }else
      {
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ASIGNACION"] <- "SIN_CUPO"
      }
    
      
      
      
      #---------------------------------------------------------------------------
      #---------------------OFERTA SIN RESTRICCION DE CUPOS-----------------------
      #---------------------------------------------------------------------------
      if(EVALUAR_OFERTA$NUMERO_DE_CUPOS_A_OFERTAR ==0){
        print("SIN_RESTRUCCION_CUPO")
        
        #COMO CUMPLE HACEMOS LAS MARCACIONES CORRESPONDIENTES
        
        #MARCAMOS DATAFRAME DE ELEGIBLES
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ELEGIBLE"] <- EVALUAR_OFERTA$CUPOS_CONTROL
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ASIGNACION"] <- "ELEGIBLE"
        
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_SEMESTRES"] <- TOTAL_FINANCIAR_SEMESTRES
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_SEMESTRES_EN_CERO"] <- SEMESTRES_EN_CERO
        
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_COSTO"] <- TOTAL_FINANCIAR_COSTO
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "FINANCIAR_COSTO_CON_DESCUENTO"] <- TOTAL_FINANCIAR_COSTO_DESCUENTO
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "N_REG_OFERTA"] <- EVALUAR_OFERTA$N_REG_OFERTA
        TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "MAXIMO_PERIODOS_OFERTA"] <- EVALUAR_OFERTA$NÚMERO_DE_PERÍODOS
        
        #AFECTAMOS PRESUPUESTO
        PPT_FEST1<- PPT_FEST1 - TOTAL_FINANCIAR_COSTO_DESCUENTO
      } 

    #} # cierre semestres a financiar
    
    
    
  }# FIN BOLSA PARA CUBRIR PROGRAMA
  else
  {
    print("SIN BOLSA PRESUPUESTO")
    TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "ASIGNACION"] <- "SIN_PRESUPUESTO"
    TMP_ELEGIBLE[TMP_ELEGIBLE$ID_PERSONA_OFERTA == PERSONA_OFERTA$ID_PERSONA_OFERTA , "MAXIMO_PERIODOS_OFERTA"] <- EVALUAR_OFERTA$NÚMERO_DE_PERÍODOS
  }
  
}# CIERRE PERSONA


TMP_ELEGIBLE$ANALISIS_SNIES <- TMP_ELEGIBLE$CODIGO_SNIES_PROGRAMA == TMP_ELEGIBLE$ADMISION_CODIGO_SNIES_PROGRAMA
TMP_ELEGIBLE$ANALISIS_PERIODOS <- TMP_ELEGIBLE$MAXIMO_PERIODOS_OFERTA > TMP_ELEGIBLE$ADMISION_SEMESTRE_INGRESO_20252

cro(TMP_ELEGIBLE$ASIGNACION)
sum(TMP_ELEGIBLE$FINANCIAR_COSTO_CON_DESCUENTO)
PPT_FEST1


PRUEBA_ELEGIBLE<-  TMP_ELEGIBLE[!is.na(TMP_ELEGIBLE$ASIGNACION),]
sqldf("select ID_PERSONA from PRUEBA_ELEGIBLE group by ID_PERSONA having count(1)>1")

#PRUEBA_ELEGIBLE <- merge(x=PRUEBA_ELEGIBLE, y=BASE_OFERTA_FEST1[,c("ID_OFERTA_PROGRAMA","ATENEA_TOTAL_VALOR_COHORTE_CUPO_3AÑOS","COSTO_UNITARIO_COHORTE_PROGRAMA")], by="ID_OFERTA_PROGRAMA", all = FALSE )

#------------------------------------------------------------
# PEGAR RESULTADO
#------------------------------------------------------------
dim(FEST1_PER_OFERTA)
FEST1_PER_OFERTA<- merge(x=FEST1_PER_OFERTA, y=TMP_ELEGIBLE[,c("ID_PERSONA_OFERTA", "FINANCIAR_SEMESTRES","FINANCIAR_COSTO","FINANCIAR_COSTO_CON_DESCUENTO","ELEGIBLE","ASIGNACION","N_REG_OFERTA","ANALISIS_SNIES")], by="ID_PERSONA_OFERTA", all.x = TRUE )
dim(FEST1_PER_OFERTA)

#-------------------------------------------------------------------------------
# CONSTRUCCCION ESTADO ELEGIBLE
#-------------------------------------------------------------------------------
FEST1_PER_OFERTA$ESTADO_ELEGIBLE<- NA
FEST1_PER_OFERTA[FEST1_PER_OFERTA$HABILITADO!="HABILITADO","ESTADO_ELEGIBLE"]<-"NO_ELEGIBLE"
FEST1_PER_OFERTA[!is.na(FEST1_PER_OFERTA$ASIGNACION) & FEST1_PER_OFERTA$ASIGNACION=="ELEGIBLE","ESTADO_ELEGIBLE"]<-"ELEGIBLE"
FEST1_PER_OFERTA[is.na(FEST1_PER_OFERTA$ESTADO_ELEGIBLE),"ESTADO_ELEGIBLE"]<-"DISPONIBLE"
cro(FEST1_PER_OFERTA$ESTADO_ELEGIBLE)
cro(FEST1_PER_OFERTA$ESTADO_ELEGIBLE, FEST1_PER_OFERTA$ASIGNACION)
# BORRAR VARIABLES Y DATAFRAME QUE NO CUMPLEN SU OBJETO PARA EL CALCULO Y NO SE USAN MAS
rm(A,aspirante,DESCUENTO,nuevo_cupo,SEMESTRES_EN_CERO,TOTAL_FINANCIAR_COSTO,TOTAL_FINANCIAR_COSTO_DESCUENTO,TOTAL_FINANCIAR_SEMESTRES, TMP, TMP1,TMP2,COSTO_OFERTA,EVALUAR_OFERTA,PERSONA_OFERTA)

#===============================================================================
#MARCACION ESTADO PARA TIC
#===============================================================================
FEST1_PER_OFERTA[FEST1_PER_OFERTA$ESTADO_ELEGIBLE %in% c("ELEGIBLE"),"RESULTADO"] <- FEST1_PER_OFERTA[FEST1_PER_OFERTA$ESTADO_ELEGIBLE %in% c("ELEGIBLE"),"ESTADO_ELEGIBLE"]
FEST1_PER_OFERTA[is.na(FEST1_PER_OFERTA$RESULTADO),"RESULTADO"]<-"NO_ELEGIBLE"
cro(FEST1_PER_OFERTA$RESULTADO)
cro(FEST1_PER_OFERTA$ESTADO_ELEGIBLE, FEST1_PER_OFERTA$RESULTADO)

#===============================================================================
# #PUESTO UNICAMENTE PARA ELEGIBLES, LISTA DE ESPERA y HABILITADOS (DISPONIBLES)
#===============================================================================
A<-  FEST1_PER_OFERTA[FEST1_PER_OFERTA$ESTADO_ELEGIBLE %in% c("ELEGIBLE") ,
                           c( "ID_PERSONA_OFERTA","ID_OFERTA_PROGRAMA","N_REG_OFERTA","CODIGO_SNIES_PROGRAMA","FEST1_LLAVE_PER","ESTADO_ELEGIBLE")]

A$ORDEN_ESTADO <- 3
A[A$ESTADO_ELEGIBLE=="ELEGIBLE", "ORDEN_ESTADO"] <-1
A[A$ESTADO_ELEGIBLE=="LISTA_ESPERA", "ORDEN_ESTADO"] <-2
cro(A$ORDEN_ESTADO, A$ESTADO_ELEGIBLE)

A <- sqldf("select 
              *,
              ROW_NUMBER() OVER(PARTITION BY ID_OFERTA_PROGRAMA,CODIGO_SNIES_PROGRAMA ORDER BY ORDEN_ESTADO asc, FEST1_LLAVE_PER asc) AS PUESTO
              FROM A
                 ")
dim(FEST1_PER_OFERTA)
FEST1_PER_OFERTA<- merge(x=FEST1_PER_OFERTA, y=A[,c("ID_PERSONA_OFERTA","PUESTO")], by="ID_PERSONA_OFERTA", all.x = TRUE)
dim(FEST1_PER_OFERTA)
rm(A)

RESULT<- FEST1_PER_OFERTA[,c(1:16,22:26,32:40)]
RESULT <- merge(x=RESULT, y=FEST1, by="ID_PERSONA", all = FALSE)
names(RESULT)

write.xlsx(RESULT, 'ESPEJO/V3_20250716/FEST1_TOTAL_V3_20250716.xlsx', sheetName ="FEST1_TOTAL")
write.xlsx(FEST1, 'ESPEJO/V3_20250716/FEST1_PER_V3_20250716.xlsx', sheetName ="FEST1")
write.xlsx(FEST1_PER_OFERTA, 'ESPEJO/V3_20250716/FEST1_PER_OFERTA_V3_20250716.xlsx', sheetName ="FEST1_PER_OFERTA")
write.xlsx(BASE_OFERTA_FEST1, 'ESPEJO/V3_20250716/BASE_OFERTA_FEST1_V3_20250716.xlsx', sheetName ="BASE_OFERTA_FEST1")

#write.xlsx(A, 'ESPEJO/V2_20250530/SIN_GRADOMEDIA.xlsx', sheetName ="FEST1_PER_OFERTA")



#-------------------------------------------------------------------------------
# CONSTRUCCION MENSAJE PARA PUBLICAR
#-------------------------------------------------------------------------------
TMP <- FEST1[FEST1$HABILITADO_A != "HABILITADO" |
             FEST1$HABILITADO_B != "HABILITADO" |
             FEST1$HABILITADO_C != "HABILITADO" |
             FEST1$HABILITADO_D != "HABILITADO" |
             FEST1$HABILITADO_E != "HABILITADO" |
             FEST1$HABILITADO_F != "HABILITADO" |
             FEST1$HABILITADO_I != "HABILITADO"   
           
           ,c("ID_PERSONA","HABILITADO_A","HABILITADO_B","HABILITADO_C","HABILITADO_D","HABILITADO_E","HABILITADO_F","HABILITADO_I")] 

TMP[TMP$HABILITADO_A!="HABILITADO", "HABILITADO_A"] <- "A"
TMP[TMP$HABILITADO_A=="HABILITADO", "HABILITADO_A"] <- NA
TMP[TMP$HABILITADO_B!="HABILITADO", "HABILITADO_B"] <- "B"
TMP[TMP$HABILITADO_B=="HABILITADO", "HABILITADO_B"] <- NA
TMP[TMP$HABILITADO_C!="HABILITADO", "HABILITADO_C"] <- "C"
TMP[TMP$HABILITADO_C=="HABILITADO", "HABILITADO_C"] <- NA
TMP[TMP$HABILITADO_D!="HABILITADO", "HABILITADO_D"] <- "D"
TMP[TMP$HABILITADO_D=="HABILITADO", "HABILITADO_D"] <- NA
TMP[TMP$HABILITADO_E!="HABILITADO", "HABILITADO_E"] <- "E"
TMP[TMP$HABILITADO_E=="HABILITADO", "HABILITADO_E"] <- NA
TMP[TMP$HABILITADO_F!="HABILITADO", "HABILITADO_F"] <- "F"
TMP[TMP$HABILITADO_F=="HABILITADO", "HABILITADO_F"] <- NA
TMP[TMP$HABILITADO_I!="HABILITADO", "HABILITADO_I"] <- "I"
TMP[TMP$HABILITADO_I=="HABILITADO", "HABILITADO_I"] <- NA


MENSAJE <- pivot_longer(TMP, cols = 2:8,
                        values_to = "MENSAJE")

MENSAJE <-MENSAJE[!is.na(MENSAJE$MENSAJE),]
MENSAJE$SMS <- "MENSAJE"

MENSAJE<- pivot_wider(MENSAJE[,c("ID_PERSONA","MENSAJE","SMS")], names_from = SMS,
                      values_from = MENSAJE)


MENSAJE$MENSAJE <- as.character(MENSAJE$MENSAJE)
str(MENSAJE)

MENSAJE$MENSAJE <- gsub('"', "", MENSAJE$MENSAJE)
MENSAJE$MENSAJE <- gsub('c', "", MENSAJE$MENSAJE)
MENSAJE$MENSAJE<- chartr("("," ", MENSAJE$MENSAJE)
MENSAJE$MENSAJE<- chartr(")"," ", MENSAJE$MENSAJE)
MENSAJE$MENSAJE <- gsub("\\s", "", MENSAJE$MENSAJE)

MENSAJE$MENSAJE <- paste("No cumples con los requisitos de participación",MENSAJE$MENSAJE,sep = " ")

RESULT <- merge(x=RESULT, y=MENSAJE, by="ID_PERSONA", all.x = TRUE )

cro(RESULT$RESULTADO)

RESULT[RESULT$ESTADO_ELEGIBLE=="ELEGIBLE", "MENSAJE"] <- "Has sido seleccionado/a/e para este programa"
# RESULT[RESULT$ESTADO_ELEGIBLE=="LISTA_ESPERA", "MENSAJE"] <- "Cumpliste requisitos. En lista de espera para este programa"
# RESULT[RESULT$ESTADO_ELEGIBLE=="INACTIVO", "MENSAJE"] <- "Cumpliste requisitos.Ya fuiste elegible en otro programa"
# RESULT[RESULT$ESTADO_ELEGIBLE=="INACTIVO_LISTA_ESPERA", "MENSAJE"] <- "Cumpliste requisitos. En lista de espera para otro programa"
RESULT[RESULT$ESTADO_ELEGIBLE=="DISPONIBLE", "MENSAJE"]  <- paste("Cumpliste requisitos.Tu Percentil en la prueba Saber 11 no fue suficiente. Percentil: ", RESULT[RESULT$ESTADO_ELEGIBLE=="DISPONIBLE","SABER11_PERCENTIL_NACIONAL_GLOBAL"],sep="")  
# RESULT[!is.na(RESULT$HABILITADO_IES) & RESULT$HABILITADO_IES=="2-INHABILITA_CRITERIO_IES", "MENSAJE"] <- "No cumples con requisito adicional establecido por la IES"
# RESULT[RESULT$PRIORIDAD > 3, "MENSAJE"] <- "El lineamiento de la convocatoria solo se considera hasta la prioridad 3"


cro(RESULT$MENSAJE, RESULT$ESTADO_ELEGIBLE)


RESULT$CUMPLE_REQUISITOS <- "NO"
RESULT[RESULT$HABILITADO=="HABILITADO", "CUMPLE_REQUISITOS"] <-"SI"

# Ser Bachiller egresado de un colegio ubicado en la ciudad de Bogotá y autorizado por la Secretaría de Educación del Distrito, 
# o haber obtenido el título de Bachiller mediante la prueba de validación del ICFES presentada en Bogotá. (Ver variable HABILITADO_A)
cro(RESULT$HABILITADO_A)
RESULT$RQ_1 <- 1
RESULT[RESULT$HABILITADO_A!="HABILITADO", "RQ_1"] <- 0
cro(RESULT$RQ_1)

# Haber presentado la prueba Saber 11° (Ver variable HABILITADO_B)
cro(RESULT$HABILITADO_B)
RESULT$RQ_2 <- 1
RESULT[RESULT$HABILITADO_B!="HABILITADO", "RQ_2"] <- 0
cro(RESULT$RQ_2)

# Tener hasta 28 años a la fecha de cierre de las inscripciones (Ver variable HABILITADO_C)
cro(RESULT$HABILITADO_C)
RESULT$RQ_3 <- 1
RESULT[RESULT$HABILITADO_C!="HABILITADO", "RQ_3"] <- 0
cro(RESULT$RQ_3)

# NO APLICA PARA FEST (DEJAR VACIO)
RESULT$RQ_4 <- NA
RESULT$RQ_5 <- NA

# No ser egresado(a) de un programa de educación superior en el nivel profesional universitario. (Ver variable HABILITADO_F)
cro(RESULT$HABILITADO_F)
RESULT$RQ_6 <- 1
RESULT[RESULT$HABILITADO_F!="HABILITADO", "RQ_6"] <- 0
cro(RESULT$RQ_6)

#Inscribirse a la convocatoria a través del sistema de inscripciones SICORE 
RESULT$RQ_7 <- 1

# NO APLICA PARA FEST (DEJAR VACIO)
RESULT$RQ_8 <- NA

# Requisito: identidad, Verificación RENEC
cro(RESULT$HABILITADO_I)
RESULT$RQ_9 <- 1
RESULT[RESULT$HABILITADO_I!="HABILITADO", "RQ_9"] <- 0
cro(RESULT$RQ_9)

# NO APLICA PARA FEST (DEJAR VACIO)
RESULT$RQ_10 <- NA

# Pertenecer a un hogar clasificado en los estratos socioeconómicos 1, 2, 3 o 4. (Ver variable HABILITADO_D)
cro(RESULT$HABILITADO_D)
RESULT$RQ_11 <- 1
RESULT[RESULT$HABILITADO_D!="HABILITADO", "RQ_11"] <- 0
cro(RESULT$RQ_11)

# Haber sido admitido en o estar cursando uno de los programas habilitados por la Agencia Atenea. (Ver variable HABILITADO_E)
cro(RESULT$HABILITADO_E)
RESULT$RQ_12 <- 1
RESULT[RESULT$HABILITADO_E!="HABILITADO", "RQ_12"] <- 0
cro(RESULT$RQ_12)

#Percentil en la prueba Saber 11° (SI TIENE ICFES TIENE PERCENTIL)
cro(RESULT$RQ_2)
RESULT$RQ_13 <- RESULT$RQ_2
cro(RESULT$RQ_13)

# PUNTAJE_GLOBAL (No se cambia el nombre del campo y se utilizará para capturar el dato de PERCENTIL_GLOBAL que aplica para FEST)
RESULT$PUNTAJE_GLOBAL <- RESULT$SABER11_PERCENTIL_NACIONAL_GLOBAL

ULTIMO_ADMITIDO <- sqldf("select ID_OFERTA_PROGRAMA, min(PUNTAJE_GLOBAL)  as PTJ_ULTIMO_ADMITIDO from RESULT where ESTADO_ELEGIBLE == 'ELEGIBLE' group by ID_OFERTA_PROGRAMA")
View(RESULT[,c("ID_PERSONA","ID_OFERTA_PROGRAMA","SABER11_PERCENTIL_NACIONAL_GLOBAL","PUNTAJE_GLOBAL","ESTADO_ELEGIBLE")])

RESULT <- merge(x=RESULT, y=ULTIMO_ADMITIDO, by="ID_OFERTA_PROGRAMA", all.x = TRUE )

# VARIABLES DE PUNTUACION VACIAS
RESULT$CRITERIO_1_VUL_ESTRUCTURAL <- NA
RESULT$C1_1 <- NA
RESULT$C1_2 <- NA
RESULT$C1_3 <- NA
RESULT$C1_4 <- NA
RESULT$C1_5 <- NA
RESULT$C1_6 <- NA
RESULT$C1_7 <- NA
RESULT$C1_8 <- NA
RESULT$C1_9 <- NA
RESULT$C1_10 <- NA
RESULT$CRITERIO_2_VUL_ECONOMICA <- NA
RESULT$DTLL_CRITERIO_2_VUL_ECONOMICA <- NA
RESULT$CRITERIO_3_MERITO_ACADEMICO <- NA
RESULT$DTLL_CRITERIO_3_MERITO_ACADEMICO <- NA
RESULT$CRITERIO_4_TRAYECTORIA <- NA
RESULT$C4_1 <- NA
RESULT$C4_2 <- NA
RESULT$C4_3 <- NA
RESULT$C4_4 <- NA
RESULT$C4_5 <- NA


#HOMOGENIZACION MATEMATICAS
RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_MATEMÁTICA), "SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS" ] <-
  RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_MATEMÁTICA), "SABER11_PUNTAJE_PRUEBA_MATEMÁTICA" ]

#HOMOGENIZACION LECTURA_CRÍTICA
RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_LENGUAJE), "SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA" ] <-
  RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_LENGUAJE), "SABER11_PUNTAJE_PRUEBA_LENGUAJE" ]

#HOMOGENIZACION SOCIALES_Y_CIUDADANAS
RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES), "SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS" ] <-
  RESULT[is.na(RESULT$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS) & !is.na(RESULT$SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES), "SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES" ]

View(RESULT[,c("ID_PERSONA","SABER11_PUNTAJE_PRUEBA_CIENCIAS_SOCIALES","SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS")] )

#Puntaje en matemáticas
RESULT$COM_1 <- RESULT$SABER11_PUNTAJE_PRUEBA_MATEMÁTICAS

#Puntaje en lectura crítica
RESULT$COM_2 <- RESULT$SABER11_PUNTAJE_PRUEBA_LECTURA_CRÍTICA

#Puntaje en Puntaje en SOCIALES_Y_CIUDADANAS
RESULT$COM_3 <- RESULT$SABER11_PUNTAJE_PRUEBA_SOCIALES_Y_CIUDADANAS


ULTIMO_ADMITIDO <- sqldf("select ID_OFERTA_PROGRAMA, max(PUESTO) AS PUESTO  from RESULT where ESTADO_ELEGIBLE == 'ELEGIBLE' group by ID_OFERTA_PROGRAMA")
ULTIMO_ADMITIDO <- merge(x=ULTIMO_ADMITIDO, RESULT[!is.na(RESULT$PUESTO),c("ID_OFERTA_PROGRAMA","PUESTO","PUNTAJE_GLOBAL","COM_1","COM_2","COM_3")], by=c("ID_OFERTA_PROGRAMA","PUESTO"), all = FALSE )
names(ULTIMO_ADMITIDO)
colnames(ULTIMO_ADMITIDO) <- c("ID_OFERTA_PROGRAMA","PUESTO","PUNTAJE_GLOBAL_ULTIMO_ADMITIDO","COM_1_ULTIMO_ADMITIDO","COM_2_ULTIMO_ADMITIDO","COM_3_ULTIMO_ADMITIDO")

RESULT <- merge(x=RESULT, y=ULTIMO_ADMITIDO[,c(-2,-3)], by="ID_OFERTA_PROGRAMA", all.x = TRUE )

#No elegible por aleatorio, valores S/N
cro(RESULT$USA_SEMILLA)
RESULT$DESP_ALEATORIO <- "N"
RESULT[!is.na(RESULT$USA_SEMILLA), "DESP_ALEATORIO" ] <-"S"
cro(RESULT$USA_SEMILLA, RESULT$DESP_ALEATORIO )
cro(RESULT$DESP_ALEATORIO )

# PERIODOS POR FINANCIAR
RESULT$PERIODOS_FALTANTES <- RESULT$FINANCIAR_SEMESTRES



write.xlsx(RESULT[order(RESULT$FEST1_LLAVE_PER),c("ID_PERSONA",
                                                                    "UBI_COLEGIO_GRADUACION",
                                                                    "ID_OFERTA_PROGRAMA",
                                                                    "CUPOS_DISPONIBLES",
                                                                    "VALOR",
                                                                    "ID_INSCRIPCION",
                                                                    "ID_PERSONA_OFERTA",
                                                                    "FECHA_REGISTRO_INSCRIPCION",
                                                                    "PRIORIDAD",
                                                                    "CODIGO_SNIES_PROGRAMA",
                                                                    "NOMBRE_PROGRAMA",
                                                                    "NOMBRE_INSTITUCION_SUPERIOR",
                                                                    "TIPO_OFERTA",
                                                                    "TIPO_CICLO",
                                                                    "RESULTADO",
                                                                    "PUESTO",
                                                                    "MENSAJE",
                                                                    "CUMPLE_REQUISITOS","RQ_1","RQ_2","RQ_3","RQ_4","RQ_5","RQ_6","RQ_7","RQ_8","RQ_9","RQ_10","RQ_11","RQ_12","RQ_13",
                                                                    "PUNTAJE_GLOBAL","PTJ_ULTIMO_ADMITIDO",
                                                                    "CRITERIO_1_VUL_ESTRUCTURAL","C1_1","C1_2","C1_3","C1_4","C1_5","C1_6","C1_7","C1_8","C1_9","C1_10",
                                                                    "CRITERIO_2_VUL_ECONOMICA","DTLL_CRITERIO_2_VUL_ECONOMICA",
                                                                    "CRITERIO_3_MERITO_ACADEMICO","DTLL_CRITERIO_3_MERITO_ACADEMICO",
                                                                    "CRITERIO_4_TRAYECTORIA","C4_1","C4_2","C4_3","C4_4","C4_5",
                                                                    "COM_1","COM_2","COM_3","COM_1_ULTIMO_ADMITIDO","COM_2_ULTIMO_ADMITIDO","COM_3_ULTIMO_ADMITIDO",
                                                                    "DESP_ALEATORIO","PERIODOS_FALTANTES"
                                                                    )], "RESULTADOS/TIC/FEST1_PER_OFERTA_TIC.xlsx", sheetName ="FEST1_PER_OFERTA")

write.xlsx(RESULT[order(RESULT$FEST1_LLAVE_PER),], 'RESULTADOS/VF_20250716/FEST1_TOTAL_VF_20250716.xlsx', sheetName ="FEST1_TOTAL")
write.xlsx(FEST1, 'RESULTADOS/VF_20250716/FEST1_PER_VF_20250716.xlsx', sheetName ="FEST1")
write.xlsx(FEST1_PER_OFERTA[order(FEST1_PER_OFERTA$FEST1_LLAVE_PER),], 'RESULTADOS/VF_20250716/FEST1_PER_OFERTA_VF_20250716.xlsx', sheetName ="FEST1_PER_OFERTA")
write.xlsx(BASE_OFERTA_FEST1, 'RESULTADOS/VF_20250716/FEST1_OFERTA_VF_20250716.xlsx', sheetName ="BASE_OFERTA_FEST1")
rm(TMP, ULTIMO_ADMITIDO,MENSAJE)

#==================================================================
# CALCULOS PARA JAVIER (2024-02-23)
#==================================================================
ELEGIBLES <- RESULT[RESULT$RESULTADO=="ELEGIBLE",]

ELEGIBLES<- sqldf("select *,
                  case when CORTE_EDAD  < 18  then '00-17'
                       when CORTE_EDAD  between 18 and 21 then '18-21'
                       when CORTE_EDAD  between 22 and 24 then '22-24'
                       when CORTE_EDAD  between 25 and 28 then '25-28'
                       when CORTE_EDAD  > 28 then '29-∞' else NULL END ETARIO
                  
                  from ELEGIBLES")
cro(ELEGIBLES$ETARIO)
cro(ELEGIBLES$SEXO)

sqldf("select ID_PERSONA from ELEGIBLES group by ID_PERSONA having count(1)>1")
cro(TCF3TOTAL$VERIFICAR_RESIDENCIA,TCF3TOTAL$RESULTADO)
cro(TCF3TOTAL$VERIFICAR_GRADUACION_MEDIA,TCF3TOTAL$RESULTADO)



#=========================================================================
# CONSTRUCCION DE MENSAJES DETALLE PARA LOS CRITERIOS DE HABILITACION
# (2025-06-12)
#=========================================================================


#------------------------------
# CRITERIO A
#------------------------------
FEST1<- FEST1[,c(-312)]
FEST1$GM_Divipola_MUNICIPIO <- FEST1$SIMAT_GM_Divipola_MUNICIPIO 
FEST1[!is.na(FEST1$MEN_GM_Divipola_MUNICIPIO), "GM_Divipola_MUNICIPIO" ] <- FEST1[!is.na(FEST1$MEN_GM_Divipola_MUNICIPIO), "MEN_GM_Divipola_MUNICIPIO"] 
View(FEST1[,c("ID_PERSONA","SIMAT_GM_Divipola_MUNICIPIO","MEN_GM_Divipola_MUNICIPIO","GM_Divipola_MUNICIPIO")])

DIVIPOLA_Municipios <- read_excel("C:/Users/Templario/Downloads/DIVIPOLA_Municipios.xlsx")

FEST1[!is.na(FEST1$GM_Divipola_MUNICIPIO) & nchar(FEST1$GM_Divipola_MUNICIPIO)==4, "GM_Divipola_MUNICIPIO" ] <- paste("0",FEST1[!is.na(FEST1$GM_Divipola_MUNICIPIO) & nchar(FEST1$GM_Divipola_MUNICIPIO)==4, "GM_Divipola_MUNICIPIO" ],sep = "")


TMP <- merge(x=FEST1[,c("ID_PERSONA","GM_Divipola_MUNICIPIO")], y=unique(DIVIPOLA_Municipios[,c("GM_Divipola_MUNICIPIO","NOMBRE_GM_Divipola_DEPTO","NOMBRE_GM_Divipola_MUNICIPIO")]), by="GM_Divipola_MUNICIPIO", all.x = TRUE  )
TMP$GM_MUNICIPIO_DEPTO <- paste(TMP$NOMBRE_GM_Divipola_MUNICIPIO," (",TMP$NOMBRE_GM_Divipola_DEPTO,")",sep = "")
FEST1 <- merge(x=FEST1, y=TMP[,c("ID_PERSONA","GM_MUNICIPIO_DEPTO")], by="ID_PERSONA", all.x = TRUE  )



FEST1 <- sqldf("SELECT *,
                     CASE 
                     WHEN  SIMAT_GM_Divipola_MUNICIPIO is null 
                          AND MEN_GM_Divipola_MUNICIPIO is null 
                          AND SABER11_PERIODO is null  
                          THEN 'Sin Información de Bachiller egresado de un colegio ubicado en la ciudad de Bogotá o título de Bachiller mediante la prueba de validación del ICFES'

                     WHEN RA_ICFES_VALIDACION=='N' AND SIMAT_GM_Divipola_MUNICIPIO is not null AND SIMAT_GM_Divipola_MUNICIPIO!='11001' THEN concat('Bachiller egresado de un colegio diferente a Bogotá, el municipio es ', GM_MUNICIPIO_DEPTO)
                     WHEN RA_ICFES_VALIDACION=='N' AND MEN_GM_Divipola_MUNICIPIO  is not null AND MEN_GM_Divipola_MUNICIPIO!='11001' THEN concat('Bachiller egresado de un colegio diferente a Bogotá, municipio es ', GM_MUNICIPIO_DEPTO) 
                     
                     WHEN RA_ICFES_VALIDACION=='S' AND SABER11_REGISTRO_SNP like 'VG%' AND SABER11_PUNTAJE_GLOBAL < 30 THEN '05_VALIDANTE_MENOR30_PUNTOS'
                     WHEN RA_ICFES_VALIDACION=='S' AND SABER11_REGISTRO_SNP like 'VG%' AND SABER11_MUNICIPIO_CITACION !='BOGOTÁ D.C.'  THEN concat('Título de Bachiller mediante la prueba de validación del ICFES presentada en ', SABER11_MUNICIPIO_CITACION)
                     
                     WHEN RA_ICFES_VALIDACION=='DV' AND SABER11_REGISTRO_SNP like 'AC%' THEN 'Sin información de graduación en media, la prueba ICFES no corresponde a validación'
                     
                     ELSE 'HABILITADO' END HABILITADO_A_MNSJ
                     FROM FEST1")

cro(FEST1$HABILITADO_A_MNSJ)


#------------------------------
# CRITERIO D
#------------------------------

Programas <- read_excel("C:/Users/Templario/Downloads/Programas.xlsx")
Programas <- Programas[!is.na(Programas$CÓDIGO_SNIES_DEL_PROGRAMA),]


#------------------------------
# CRITERIO E
#------------------------------

TMP <- FEST1[,c("ID_PERSONA","HABILITADO_E","MEN_ULTIMA_MATRICULA_SUPERIOR","COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR")]

TMP <- TMP %>% separate(
  col = COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR,                    # nombre de la columna a separar
  into = c("COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR_A", "COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR_B"),  # nombres de las columnas a crear
  sep = "\\," ,                   # patron a buscar, en este caso se usa \\ por ser un caracter especial
  remove = T                      # sirve para conservar la variable a separar
)


TMP <- merge(x=TMP, y=Programas[,c("CÓDIGO_SNIES_DEL_PROGRAMA","NOMBRE_DEL_PROGRAMA","NOMBRE_INSTITUCIÓN")], by.x = "COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR_A", by.y = "CÓDIGO_SNIES_DEL_PROGRAMA", all.x = TRUE )
TMP$GRADUADO_A <- paste(TMP$NOMBRE_DEL_PROGRAMA," (",TMP$NOMBRE_INSTITUCIÓN,")",sep = "")
TMP[TMP$GRADUADO_A=="NA (NA)", "GRADUADO_A"] <- NA
TMP <- TMP[,c(-6,-7)]

TMP <- merge(x=TMP, y=Programas[,c("CÓDIGO_SNIES_DEL_PROGRAMA","NOMBRE_DEL_PROGRAMA","NOMBRE_INSTITUCIÓN")], by.x = "COD_SNIES_PROG_ULT_MATRICULA_SUPERIOR_B", by.y = "CÓDIGO_SNIES_DEL_PROGRAMA", all.x = TRUE )
TMP$GRADUADO_B <- paste(TMP$NOMBRE_DEL_PROGRAMA," (",TMP$NOMBRE_INSTITUCIÓN,")",sep = "")
TMP[TMP$GRADUADO_B=="NA (NA)", "GRADUADO_B"] <- NA
TMP <- TMP[,c(-8,-7)]

TMP <- TMP %>% unite("MATRICULA_SUPERIOR", GRADUADO_A:GRADUADO_B, na.rm = TRUE, remove = FALSE)



TMP <- sqldf("SELECT *,
                     CASE 
                    -- EGRESADO SUPERIOR
                    WHEN MEN_ULTIMA_MATRICULA_SUPERIOR IS NOT NULL THEN concat('En el ultimo año se encuentra cursando el(los) programa(s) de ', MATRICULA_SUPERIOR)
                     
                     ELSE 'HABILITADO' END HABILITADO_E_MNSJ 
             FROM TMP ")

cro(TMP$HABILITADO_E_MNSJ)

FEST1 <- merge(x=FEST1, y=TMP[,c("ID_PERSONA","HABILITADO_E_MNSJ")], by="ID_PERSONA", all.x = TRUE  )


#------------------------------
# CRITERIO F
#------------------------------

TMP <- FEST1[,c("ID_PERSONA","HABILITADO_F","GRADUADO_Universitario")]
TMP <- merge(x=TMP, y=Programas[,c("CÓDIGO_SNIES_DEL_PROGRAMA","NOMBRE_DEL_PROGRAMA","NOMBRE_INSTITUCIÓN")], by.x = "GRADUADO_Universitario", by.y = "CÓDIGO_SNIES_DEL_PROGRAMA", all.x = TRUE )
TMP$GRADUADO <- paste(TMP$NOMBRE_DEL_PROGRAMA," (",TMP$NOMBRE_INSTITUCIÓN,")",sep = "")
TMP[TMP$GRADUADO=="NA (NA)", "GRADUADO"] <- NA



TMP <- sqldf("SELECT *,
                     CASE 
                    -- EGRESADO SUPERIOR
                    WHEN GRADUADO_Universitario IS NOT NULL THEN concat('Es egresado del programa ', GRADUADO, ', que corresponde al nivel profesional universitario')
                     
                     ELSE 'HABILITADO' END HABILITADO_F_MNSJ 
             FROM TMP")

cro(TMP$HABILITADO_F_MNSJ)

FEST1 <- merge(x=FEST1, y=TMP[,c("ID_PERSONA","HABILITADO_F_MNSJ")], by="ID_PERSONA", all.x = TRUE  )


#------------------------------
# CRITERIO H
#------------------------------

TMP <- FEST1[,c("ID_PERSONA","HABILITADO_H","RESTRICCION_JU","JE_CONVOCATORIA","UTC_ESTADO_JE","RA_FONDOS_ATENEA","RA_FONDOS_SED","TIPO_FONDO_ATENEA","TIPO_FONDO_SED_DRESET")]

TMP <- TMP %>% unite("FONDOS_ATENEA_SED", TIPO_FONDO_ATENEA:TIPO_FONDO_SED_DRESET, na.rm = TRUE, remove = FALSE)


TMP <- sqldf("SELECT *,
                     CASE 
                    -- JU
                    WHEN RESTRICCION_JU =='S' THEN concat('Es Beneficiario del programa Jóvenes a la E en la convocatoria ',JE_CONVOCATORIA )
                    -- UTC
                    WHEN UTC_ESTADO_JE is not null and UTC_ESTADO_JE =='Bloqueado' THEN 'Es Beneficiario del programa La U en Tu Colegio'
                    -- FONDOS
                    WHEN RA_FONDOS_ATENEA =='S' OR RA_FONDOS_SED =='S' THEN concat('Es Beneficiario de ',FONDOS_ATENEA_SED )
                    
                     ELSE 'HABILITADO' END HABILITADO_H_MNSJ
             FROM TMP")

cro(TMP$HABILITADO_H_MNSJ)

FEST1 <- merge(x=FEST1, y=TMP[,c("ID_PERSONA","HABILITADO_H_MNSJ")], by="ID_PERSONA", all.x = TRUE  )

write.xlsx(FEST1[,c("ID_PERSONA","HABILITADO_A_MNSJ","HABILITADO_D_MNSJ","HABILITADO_E_MNSJ","HABILITADO_F_MNSJ","HABILITADO_H_MNSJ")], 'RESULTADOS/VF_20250716/FEST1_MENSAJES_HABILITACION_VF_20250716.xlsx', sheetName ="FEST1_MNSJ_HABILITACION")
write.xlsx(FEST1[,c("ID_PERSONA","HABILITADO_A_MNSJ","HABILITADO_F_MNSJ")], 'RESULTADOS/VF_20250716/FEST1_MENSAJES_HABILITACION_VF_20250716.xlsx', sheetName ="FEST1_MNSJ_HABILITACION")
