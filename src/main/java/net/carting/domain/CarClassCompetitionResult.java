package net.carting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name = "car_class_competition_results")
public class CarClassCompetitionResult {

	@Id
	@Column(name = "id")
	@GeneratedValue
	private int id;
	
	
	@Column(name="absolute_points")
	private int absolutePoints;
	
	@Column(name="absolute_place")
	private int absolutePlace;
	
	@Column(name="race2_points")
	private int race2points;
	
	@Column(name="comment")
	private String comment;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "racer_competition_carclass_number_id", nullable = false)
	private RacerCarClassCompetitionNumber racerCarClassCompetitionNumber;

	public RacerCarClassCompetitionNumber getRacerCarClassCompetitionNumber() {
		return racerCarClassCompetitionNumber;
	}

	public void setRacerCarClassCompetitionNumber(
			RacerCarClassCompetitionNumber racerCarClassCompetitionNumber) {
		this.racerCarClassCompetitionNumber = racerCarClassCompetitionNumber;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getAbsolutePoints() {
		return absolutePoints;
	}

	public void setAbsolutePoints(int absolutePoints) {
		if (absolutePoints<0){
			this.absolutePoints=0;
		}else{
		this.absolutePoints = absolutePoints;
	
		}
	}
	public int getAbsolutePlace() {
		return absolutePlace;
	}

	public void setAbsolutePlace(int absolutePlace) {
		this.absolutePlace = absolutePlace;
	}

	public int getRace2points() {
		return race2points;
	}

	public void setRace2points(int race2points) {
		this.race2points = race2points;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	@Override
	public String toString() {
		return "CarClassCompetitionResult [id=" + id + ",  absolutePoints=" + absolutePoints + ", absolutePlace="
				+ absolutePlace + "]";
	}
	
	public CarClassCompetitionResult(){
		this.setComment("без штрафу");
	}
	
	
	

}
