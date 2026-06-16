"""
API REST - Pólizas de Seguro
FastAPI Backend con CRUD completo
Datos embebidos en JSON
"""

from fastapi import FastAPI, HTTPException, Query, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from typing import Optional
import json
import os
from datetime import date

# ──────────────────────────────────────────────
# Configuración de rutas
# ──────────────────────────────────────────────
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_FILE = os.path.join(BASE_DIR, "data", "polizas.json")

# ──────────────────────────────────────────────
# Tipos de seguro válidos
# ──────────────────────────────────────────────

TIPOS_SEGURO = ["Vida", "Salud", "Hogar", "Automóvil", "Crédito"]

TIPOS_SEGURO_INFO = {
    "Vida": "Protege a los beneficiarios ante el fallecimiento o incapacidad del titular.",
    "Salud": "Cubre gastos médicos, hospitalarios y tratamientos.",
    "Hogar": "Protege la vivienda y bienes personales contra daños, robos o fenómenos naturales.",
    "Automóvil": "Obligatorio en muchos lugares, cubre daños a terceros, al vehículo y conductor.",
    "Crédito": "Protege a empresas contra el riesgo de impago por parte de sus clientes.",
}

# ──────────────────────────────────────────────
# Perfil fijo del agente de seguros
# ──────────────────────────────────────────────

AGENTE_PERFIL = {
    "id": 1,
    "nombre": "Danna Valentina Espinoza",
    "cedula": "1722651567",
    "email": "daandrade@aseguradora.com",
    "telefono": "+593 93 918 5134",
    "cargo": "Agente de Seguros",
    "sucursal": "Quito - Matriz",
    "licencia": "AGT-2024-001",
    "especialidades": ["Vida", "Salud", "Hogar", "Automóvil", "Crédito"],
}

# ──────────────────────────────────────────────
# Modelos Pydantic
# ──────────────────────────────────────────────

class PolizaBase(BaseModel):
    """Esquema base para una póliza de seguro."""
    codigo: str = Field(..., min_length=1, json_schema_extra={"example": "POL-006"})
    cliente: str = Field(..., min_length=1, json_schema_extra={"example": "Juan López"})
    tipo_seguro: str = Field(..., min_length=1, json_schema_extra={"example": "Vida"})
    fecha_inicio: str = Field(..., json_schema_extra={"example": "2026-01-01"})
    fecha_vencimiento: str = Field(..., json_schema_extra={"example": "2027-01-01"})
    valor_asegurado: float = Field(..., gt=0, json_schema_extra={"example": 50000.00})


class PolizaCreate(PolizaBase):
    """Esquema para crear una póliza (sin id, se autogenera)."""
    pass


class PolizaUpdate(BaseModel):
    """Esquema para actualizar una póliza (todos los campos opcionales)."""
    codigo: Optional[str] = None
    cliente: Optional[str] = None
    tipo_seguro: Optional[str] = None
    fecha_inicio: Optional[str] = None
    fecha_vencimiento: Optional[str] = None
    valor_asegurado: Optional[float] = Field(None, gt=0)


class Poliza(PolizaBase):
    """Esquema completo de una póliza con id."""
    id: int

    model_config = {"from_attributes": True}


# ──────────────────────────────────────────────
# Funciones de persistencia (JSON embebido)
# ──────────────────────────────────────────────

def cargar_polizas() -> list[dict]:
    """Carga las pólizas desde el archivo JSON."""
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        return json.load(f)


def guardar_polizas(polizas: list[dict]) -> None:
    """Guarda las pólizas en el archivo JSON."""
    os.makedirs(os.path.dirname(DATA_FILE), exist_ok=True)
    with open(DATA_FILE, "w", encoding="utf-8") as f:
        json.dump(polizas, f, indent=2, ensure_ascii=False)


def obtener_siguiente_id(polizas: list[dict]) -> int:
    """Genera el siguiente ID autoincremental."""
    if not polizas:
        return 1
    return max(p["id"] for p in polizas) + 1


# ──────────────────────────────────────────────
# Aplicación FastAPI
# ──────────────────────────────────────────────

app = FastAPI(
    title="API Pólizas de Seguro",
    description="API REST para administrar pólizas de seguro - CRUD completo",
    version="1.0.0",
)

# CORS - permitir conexiones desde Flutter (cualquier origen en dev)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ──────────────────────────────────────────────
# Endpoints CRUD
# ──────────────────────────────────────────────

@app.get("/")
def root():
    """Endpoint raíz con información de la API."""
    return {
        "mensaje": "API Pólizas de Seguro - FastAPI",
        "version": "1.0.0",
        "endpoints": {
            "agente": "GET /agente",
            "tipos_seguro": "GET /tipos-seguro",
            "listar": "GET /polizas",
            "obtener": "GET /polizas/{id}",
            "crear": "POST /polizas",
            "actualizar": "PUT /polizas/{id}",
            "eliminar": "DELETE /polizas/{id}",
        }
    }


# ── AGENTE ──────────────────────────────────

@app.get("/agente")
def obtener_agente():
    """Devuelve el perfil fijo del agente de seguros."""
    polizas = cargar_polizas()
    return {
        **AGENTE_PERFIL,
        "total_polizas_vendidas": len(polizas),
    }


# ── TIPOS DE SEGURO ────────────────────────

@app.get("/tipos-seguro")
def listar_tipos_seguro():
    """Devuelve todos los tipos de seguro disponibles."""
    return {
        "tipos": TIPOS_SEGURO,
        "detalle": TIPOS_SEGURO_INFO,
    }


# ── CREATE ──────────────────────────────────

@app.post("/polizas", response_model=Poliza, status_code=status.HTTP_201_CREATED)
def crear_poliza(poliza: PolizaCreate):
    """Registra una nueva póliza de seguro."""
    polizas = cargar_polizas()
    
    # Verificar código duplicado
    if any(p["codigo"] == poliza.codigo for p in polizas):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Ya existe una póliza con el código '{poliza.codigo}'"
        )
    
    nueva_poliza = {
        "id": obtener_siguiente_id(polizas),
        **poliza.model_dump()
    }
    
    polizas.append(nueva_poliza)
    guardar_polizas(polizas)
    
    return nueva_poliza


# ── READ (todos con filtros) ────────────────

@app.get("/polizas", response_model=list[Poliza])
def listar_polizas(
    id: Optional[int] = Query(None, description="Filtrar por ID exacto"),
    tipo_seguro: Optional[str] = Query(None, description="Filtrar por tipo: Vida, Salud, Hogar, Automóvil, Crédito"),
    cliente: Optional[str] = Query(None, description="Buscar por nombre de cliente (parcial)"),
    codigo: Optional[str] = Query(None, description="Buscar por código de póliza"),
    fecha_inicio_desde: Optional[str] = Query(None, description="Desde fecha inicio (YYYY-MM-DD)"),
    fecha_inicio_hasta: Optional[str] = Query(None, description="Hasta fecha inicio (YYYY-MM-DD)"),
    fecha_vencimiento_desde: Optional[str] = Query(None, description="Desde fecha vencimiento (YYYY-MM-DD)"),
    fecha_vencimiento_hasta: Optional[str] = Query(None, description="Hasta fecha vencimiento (YYYY-MM-DD)"),
    valor_min: Optional[float] = Query(None, ge=0, description="Valor asegurado mínimo"),
    valor_max: Optional[float] = Query(None, ge=0, description="Valor asegurado máximo"),
    orden_por: Optional[str] = Query(None, description="Ordenar por: id, codigo, cliente, tipo_seguro, fecha_inicio, valor_asegurado"),
    orden_dir: Optional[str] = Query("asc", description="Dirección: asc o desc"),
):
    """Consulta todas las pólizas con filtros opcionales."""
    polizas = cargar_polizas()

    # ── Filtros ──
    if id is not None:
        polizas = [p for p in polizas if p.get("id") == id]
    if tipo_seguro:
        polizas = [p for p in polizas if p.get("tipo_seguro", "").lower() == tipo_seguro.lower()]
    if cliente:
        polizas = [p for p in polizas if cliente.lower() in p.get("cliente", "").lower()]
    if codigo:
        polizas = [p for p in polizas if codigo.lower() in p.get("codigo", "").lower()]
    if fecha_inicio_desde:
        polizas = [p for p in polizas if p.get("fecha_inicio", "") >= fecha_inicio_desde]
    if fecha_inicio_hasta:
        polizas = [p for p in polizas if p.get("fecha_inicio", "") <= fecha_inicio_hasta]
    if fecha_vencimiento_desde:
        polizas = [p for p in polizas if p.get("fecha_vencimiento", "") >= fecha_vencimiento_desde]
    if fecha_vencimiento_hasta:
        polizas = [p for p in polizas if p.get("fecha_vencimiento", "") <= fecha_vencimiento_hasta]
    if valor_min is not None:
        polizas = [p for p in polizas if p.get("valor_asegurado", 0) >= valor_min]
    if valor_max is not None:
        polizas = [p for p in polizas if p.get("valor_asegurado", 0) <= valor_max]

    # ── Ordenamiento ──
    campos_validos = ["id", "codigo", "cliente", "tipo_seguro", "fecha_inicio", "fecha_vencimiento", "valor_asegurado"]
    if orden_por and orden_por in campos_validos:
        reverse = orden_dir and orden_dir.lower() == "desc"
        polizas.sort(key=lambda p: p.get(orden_por, ""), reverse=reverse)

    return polizas


# ── READ (uno) ──────────────────────────────

@app.get("/polizas/{poliza_id}", response_model=Poliza)
def obtener_poliza(poliza_id: int):
    """Consulta una póliza específica por su ID."""
    polizas = cargar_polizas()
    
    for poliza in polizas:
        if poliza["id"] == poliza_id:
            return poliza
    
    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Póliza con id {poliza_id} no encontrada"
    )


# ── UPDATE ──────────────────────────────────

@app.put("/polizas/{poliza_id}", response_model=Poliza)
def actualizar_poliza(poliza_id: int, datos: PolizaUpdate):
    """Actualiza la información de una póliza existente."""
    polizas = cargar_polizas()
    
    for i, poliza in enumerate(polizas):
        if poliza["id"] == poliza_id:
            # Solo actualizar campos que se enviaron (no None)
            datos_actualizados = datos.model_dump(exclude_none=True)
            
            if not datos_actualizados:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Debe enviar al menos un campo para actualizar"
                )
            
            # Verificar código duplicado si se está actualizando
            if "codigo" in datos_actualizados:
                if any(
                    p["codigo"] == datos_actualizados["codigo"] and p["id"] != poliza_id
                    for p in polizas
                ):
                    raise HTTPException(
                        status_code=status.HTTP_400_BAD_REQUEST,
                        detail=f"Ya existe otra póliza con el código '{datos_actualizados['codigo']}'"
                    )
            
            polizas[i].update(datos_actualizados)
            guardar_polizas(polizas)
            return polizas[i]
    
    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Póliza con id {poliza_id} no encontrada"
    )


# ── DELETE ──────────────────────────────────

@app.delete("/polizas/{poliza_id}")
def eliminar_poliza(poliza_id: int):
    """Elimina una póliza por su ID."""
    polizas = cargar_polizas()
    
    for i, poliza in enumerate(polizas):
        if poliza["id"] == poliza_id:
            eliminada = polizas.pop(i)
            guardar_polizas(polizas)
            return {
                "mensaje": f"Póliza '{eliminada['codigo']}' eliminada exitosamente",
                "poliza_eliminada": eliminada
            }
    
    raise HTTPException(
        status_code=status.HTTP_404_NOT_FOUND,
        detail=f"Póliza con id {poliza_id} no encontrada"
    )


# ──────────────────────────────────────────────
# Punto de entrada
# ──────────────────────────────────────────────

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
