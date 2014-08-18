package net.carting.domain;

import java.sql.Time;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "qualifying")
public class Qualifying {
    
	@Id
    @Column(name = "id")
    @GeneratedValue
	private int id;
	
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_competition_id")
    private CarClassCompetition carClassCompetition;
        
    @Column(name = "racer_number", nullable = false)
    private Integer racerNumber;
    
    @Column(name = "racer_place", nullable = false)
    private Integer racerPlace;
    
    @Column(name = "racer_time", nullable = false)
    private Time  racerTime;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CarClassCompetition getCarClassCompetition() {
		return carClassCompetition;
	}

	public void setCarClassCompetition(CarClassCompetition carClassCompetition) {
		this.carClassCompetition = carClassCompetition;
	}

	public Integer getRacerNumber() {
		return racerNumber;
	}

	public void setRacerNumber(Integer racerNumber) {
		this.racerNumber = racerNumber;
	}

	public Integer getRacerPlace() {
		return racerPlace;
	}

	public void setRacerPlace(Integer racerPlace) {
		this.racerPlace = racerPlace;
	}

	public Time getRacerTime() {
		return racerTime;
	}

	public void setRacerTime(Time racer_time) {
		this.racerTime = racer_time;
	}
	
	public Qualifying(){
	}

	public Qualifying(int id, CarClassCompetition carClassCompetition,
			Integer racerNumber, Integer racerPlace, Time racer_time) {
		this.id = id;
		this.carClassCompetition = carClassCompetition;
		this.racerNumber = racerNumber;
		this.racerPlace = racerPlace;
		this.racerTime = racer_time;
	}

	@Override
	public String toString() {
		return "Qualifying [id=" + id + ", carClassCompetition="
				+ carClassCompetition + ", racerNumber=" + racerNumber
				+ ", racerPlace=" + racerPlace + ", racerTime=" + racerTime
				+ "]";
	}

/*	@Override
	public String toString() {
		return String.format("Qualifying id=%d [CarclasscompId=%d racer number=%d, racer time=%s, "
				+ " racer place=%d]" , id, carClassCompetition.getId(), racerNumber , racerTime , racerPlace);
	}*/
}
