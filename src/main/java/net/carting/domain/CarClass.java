package net.carting.domain;

import javax.persistence.*;

@Entity
@Table(name="car_classes", uniqueConstraints={@UniqueConstraint(columnNames = {"name"})})
public class CarClass{
  
	@Id
	@Column(name = "id")
	@GeneratedValue
    private int id;
    
	@Column(name="name", nullable = false, unique = true)
	private String name;		
	
	@Column(name="lower_years_limit", nullable = false)
	private int lowerYearsLimit;	
	
	@Column(name="upper_years_limit", nullable = false)
	private int upperYearsLimit;	
	
	public CarClass() {}
    
    public CarClass(String name, int lowerYearsLimit, int upperYearsLimit) {
    	this.name = name;
    	this.lowerYearsLimit = lowerYearsLimit;
    	this.upperYearsLimit = upperYearsLimit;
    }
    
    public int getId() {
		return id;
	}
    
    public void setId(int id){
    	this.id = id;
    }
    
    public String getName() {
    	return name;
    }
    
    public void setName(String name) {
    	this.name = name;
    }
    	
	public int getLowerYearsLimit() {
		return lowerYearsLimit;
	}

	public void setLowerYearsLimit(int lowerYearsLimit) {
		this.lowerYearsLimit = lowerYearsLimit;
	}

	public int getUpperYearsLimit() {
		return upperYearsLimit;
	}

	public void setUpperYearsLimit(int upperYearsLimit) {
		this.upperYearsLimit = upperYearsLimit;
	}

	@Override
    public String toString(){
        return name;
    }

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CarClass other = (CarClass) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
}

