# API REST - Pólizas de Seguro

Este es el backend desarrollado con **FastAPI** para la gestión de pólizas de seguro. Permite crear, leer y filtrar registros mediante una base de datos local embebida en formato JSON. Esta API está diseñada para ser consumida desde cualquier frontend, como **Flutter**.

## Requisitos Previos
- [Python 3.8+](https://www.python.org/downloads/) instalado en tu sistema.

## Instalación y Configuración

Sigue estos pasos en tu terminal para poner en marcha el proyecto de forma segura:

### 1. Clonar / Ubicarse en el proyecto
Abre tu terminal y navega hasta la carpeta `backend` del proyecto:
```bash
cd ruta/hasta/tu/proyecto/backend
```

### 2. Crear el entorno virtual
Es una buena práctica crear un entorno virtual para que las dependencias no interfieran con otros proyectos de Python en tu sistema:
```bash
python -m venv .venv
```

### 3. Activar el entorno virtual
Dependiendo de tu sistema operativo, ejecuta el comando correspondiente:

**Windows (PowerShell):**
```powershell
.\.venv\Scripts\Activate.ps1
```
**Windows (Command Prompt / CMD):**
```cmd
.venv\Scripts\activate.bat
```
**Mac / Linux:**
```bash
source .venv/bin/activate
```

*(Sabrás que funcionó porque verás `(.venv)` al inicio de la línea de comandos en tu terminal).*

### 4. Instalar las dependencias
Con el entorno virtual activado, instala las librerías necesarias ejecutando:
```bash
python -m pip install -r requirements.txt
```

---

## Ejecutar el Servidor Local

Una vez instaladas las dependencias, puedes encender el servidor con el siguiente comando:
```bash
python -m uvicorn main:app --reload
```
*(El parámetro `--reload` hace que el servidor se reinicie automáticamente si haces cambios en el código de `main.py`).*

El servidor se iniciará y estará disponible en: **http://localhost:8000**

---

## Probar la API (Documentación Interactiva)

FastAPI genera documentación interactiva automáticamente. Para ver los endpoints y hacer pruebas directamente desde tu navegador:

1. Asegúrate de que el servidor está corriendo.
2. Abre tu navegador web.
3. Ingresa a la URL: **[http://localhost:8000/docs](http://localhost:8000/docs)**

Desde allí podrás ver los esquemas y ejecutar pruebas (peticiones GET, POST, PUT, DELETE) haciendo clic en el botón **"Try it out"**.

## Resumen de Endpoints Disponibles

- `GET /agente` - Obtiene el perfil fijo del agente logueado.
- `GET /tipos-seguro` - Devuelve la lista de tipos de pólizas válidas (Vida, Salud, Hogar, etc.) junto con sus descripciones.
- `GET /polizas` - Lista todos los registros. Soporta múltiples filtros a través de la URL (ej. `?tipo_seguro=Vida`, `?id=1`, `?valor_min=500`).
- `GET /polizas/{id}` - Obtiene los detalles de una póliza específica.
- `POST /polizas` - Crea una nueva póliza (el ID es autogenerado).
- `PUT /polizas/{id}` - Modifica campos de una póliza existente.
- `DELETE /polizas/{id}` - Elimina un registro de la base de datos.
