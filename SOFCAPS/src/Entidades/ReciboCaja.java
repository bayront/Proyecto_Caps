package Entidades;


import java.util.Date;

public class ReciboCaja 
{
   private String descripcion;
   private Boolean estado;
   private Date fecha;
   private Float monto;
   private String ruc;
   private Integer usuaCrea;
   private Integer usuaMod;
   private Integer usuaElim;
   private Date fechaCrea;
   private Date fechaMod;
   private Date fechaElim;
   private Integer tipo;
   public Categoria_Ing_Egreg categoria_Ing_Egreg;
   public Contrato contrato;
   public Cliente cliente;
   public Factura_Maestra factura_Maestra;
   public Reconexion reconexion;

   public ReciboCaja() 
   {
   }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public Boolean getEstado() {
        return estado;
    }
    public void setEstado(Boolean estado) {
        this.estado = estado;
    }
    public Date getFecha() {
        return fecha;
    }
    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    public Float getMonto() {
        return monto;
    }
    public void setMonto(Float monto) {
        this.monto = monto;
    }
    public String getRuc() {
        return ruc;
    }
    public void setRuc(String ruc) {
        this.ruc = ruc;
    }
    public Integer getUsuaCrea() {
        return usuaCrea;
    }
    public void setUsuaCrea(Integer usuaCrea) {
        this.usuaCrea = usuaCrea;
    }
    public Integer getUsuaMod() {
        return usuaMod;
    }
    public void setUsuaMod(Integer usuaMod) {
        this.usuaMod = usuaMod;
    }
    public Integer getUsuaElim() {
        return usuaElim;
    }
    public void setUsuaElim(Integer usuaElim) {
        this.usuaElim = usuaElim;
    }
    public Date getFechaCrea() {
        return fechaCrea;
    }
    public void setFechaCrea(Date fechaCrea) {
        this.fechaCrea = fechaCrea;
    }
    public Date getFechaMod() {
        return fechaMod;
    }
    public void setFechaMod(Date fechaMod) {
        this.fechaMod = fechaMod;
    }
    public Date getFechaElim() {
        return fechaElim;
    }
    public void setFechaElim(Date fechaElim) {
        this.fechaElim = fechaElim;
    }
    public Integer getTipo() {
        return tipo;
    }
    public void setTipo(Integer tipo) {
        this.tipo = tipo;
    }
    public Categoria_Ing_Egreg getCategoria_Ing_Egreg() {
        return categoria_Ing_Egreg;
    }
    public void setCategoria_Ing_Egreg(Categoria_Ing_Egreg categoria_Ing_Egreg) {
        this.categoria_Ing_Egreg = categoria_Ing_Egreg;
    }
    public Contrato getContrato() {
        return contrato;
    }
    public void setContrato(Contrato contrato) {
        this.contrato = contrato;
    }
    public Cliente getCliente() {
        return cliente;
    }
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    public Factura_Maestra getFactura_Maestra() {
        return factura_Maestra;
    }
    public void setFactura_Maestra(Factura_Maestra factura_Maestra) {
        this.factura_Maestra = factura_Maestra;
    }
    public Reconexion getReconexion() {
        return reconexion;
    }
    public void setReconexion(Reconexion reconexion) {
        this.reconexion = reconexion;
    }  
   
}
