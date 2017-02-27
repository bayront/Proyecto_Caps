package Entidades;


import java.util.List;


public class Departamento 
{
   private String dep;
   private Integer departamento_ID;
   private List<Municipio> municipios;
   
   public Departamento() 
   {
   }

    public String getDep() {
        return dep;
    }
    public void setDep(String dep) {
        this.dep = dep;
    }
	public Integer getDepartamento_ID() {
		return departamento_ID;
	}
	public void setDepartamento_ID(Integer departamento_ID) {
		this.departamento_ID = departamento_ID;
	}
	public List<Municipio> getMunicipios() {
		return municipios;
	}
	public void setMunicipios(List<Municipio> municipios) {
		this.municipios = municipios;
	}  
    
}
