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

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "qualifying")
public class Qualifying {
    
	@Id
    @Column(name = "id")
    @GeneratedValue
	private int id;
	
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_id", nullable = false)
    private CarClass carClass;
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_competition_id")
    private CarClassCompetition carClassCompetition;
        
    @Column(name = "racer_number", nullable = false)
    private Integer racerNumber;
    
    @Column(name = "racer_place", nullable = false)
    private Integer racerPlace;
    
    @Column(name = "racer_time", nullable = false)
    @DateTimeFormat(pattern = "mm:ss")
    private Time  racer_time;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public CarClass getCarClass() {
		return carClass;
	}

	public void setCarClass(CarClass carClass) {
		this.carClass = carClass;
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

	public Time getRacer_time() {
		return racer_time;
	}

	public void setRacer_time(Time racer_time) {
		this.racer_time = racer_time;
	}
	
	public Qualifying(){
	}

	public Qualifying(int id, CarClass carClass,
			CarClassCompetition carClassCompetition, Integer racerNumber,
			Integer racerPlace, Time racer_time) {
		this.id = id;
		this.carClass = carClass;
		this.carClassCompetition = carClassCompetition;
		this.racerNumber = racerNumber;
		this.racerPlace = racerPlace;
		this.racer_time = racer_time;
	}

	@Override
	public String toString() {
		return String.format("Qualifying id=%d [Carclass=%s, racer number=%d, racer time=%s, "
				+ " racer place=%d]" , id,carClass , racerNumber , racer_time , racerPlace);
	}
}
