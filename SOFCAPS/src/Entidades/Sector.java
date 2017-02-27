package Entidades;


public class Sector 
{
   private String nombreSector;
   private Integer sector_ID;
   
   public Sector() 
   {
   }

    public String getNombreSector() {
        return nombreSector;
    }
    public void setNombreSector(String nombreSector) {
        this.nombreSector = nombreSector;
    }
	public Integer getSector_ID() {
		return sector_ID;
	}
	public void setSector_ID(Integer sector_ID) {
		this.sector_ID = sector_ID;
	}
	
}
