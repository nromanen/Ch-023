package net.carting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import net.carting.util.DateUtil;

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
        
    @Column(name = "racer_number")
    private Integer racerNumber;
    
    @Column(name = "racer_place")
    private Integer racerPlace;
    
    @Column(name = "racer_time")
    private Integer  racerTime;

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

	public Integer getRacerTime() {
		return racerTime;
	}

	public void setRacerTime(Integer racer_time) {
		this.racerTime = racer_time;
	}
	
	public String getTimeString() {
	    return DateUtil.getTimeStringFromInt(this.racerTime);
	}
	
	public Qualifying(){
	}

	public Qualifying(int id, CarClassCompetition carClassCompetition,
			Integer racerNumber, Integer racerPlace, Integer racer_time) {
		this.id = id;
		this.carClassCompetition = carClassCompetition;
		this.racerNumber = racerNumber;
		this.racerPlace = racerPlace;
		this.racerTime = racer_time;
	}

	@Override
	public String toString() {
		return String.format("Qualifying id=%d [CarclasscompId=%d racer number=%d, racer time=%s, "
				+ " racer place=%d]" , id, carClassCompetition.getId(), racerNumber , racerTime , racerPlace);
	}
}
