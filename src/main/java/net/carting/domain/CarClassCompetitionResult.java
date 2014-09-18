package net.carting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import net.carting.util.DateUtil;


@Entity
@Table(name = "car_class_competition_results")
public class CarClassCompetitionResult {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;


    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + absolutePlace;
        result = prime * result + absolutePoints;
        result = prime * result + ((comment == null) ? 0 : comment.hashCode());
        result = prime * result + id;
        long temp;
        temp = Double.doubleToLongBits(maneuverTime);
        result = prime * result + (int) (temp ^ (temp >>> 32));
        result = prime * result + race2points;
        result = prime * result + ((racerCarClassCompetitionNumber == null) ? 0 : racerCarClassCompetitionNumber.hashCode());
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
        CarClassCompetitionResult other = (CarClassCompetitionResult) obj;
        if (absolutePlace != other.absolutePlace)
            return false;
        if (absolutePoints != other.absolutePoints)
            return false;
        if (comment == null) {
            if (other.comment != null)
                return false;
        } else if (!comment.equals(other.comment))
            return false;
        if (id != other.id)
            return false;
        if (Double.doubleToLongBits(maneuverTime) != Double.doubleToLongBits(other.maneuverTime))
            return false;
        if (race2points != other.race2points)
            return false;
        if (racerCarClassCompetitionNumber == null) {
            if (other.racerCarClassCompetitionNumber != null)
                return false;
        } else if (!racerCarClassCompetitionNumber.equals(other.racerCarClassCompetitionNumber))
            return false;
        return true;
    }

    @Column(name = "absolute_points")
    private int absolutePoints;

    @Column(name = "absolute_place")
    private int absolutePlace;
    
    @Transient
    private int absolutePointsByTableB;
    
    @Transient
    private double absoluteSumm;
    
    @Transient
    private int finalPlace;

    @Column(name = "race2_points")
    private int race2points;

    @Column(name = "comment")
    private String comment;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "racer_competition_carclass_number_id", nullable = false)
    private RacerCarClassCompetitionNumber racerCarClassCompetitionNumber;

    //TODO: label
    @Column(name="maneuver_time")
    private double maneuverTime;
    
    @Column(name = "qualifying_racer_place")
    private Integer qualifyingRacerPlace;
    
    @Column(name = "qualifying_racer_time")
    private Integer  qualifyingRacerTime;
    
    public Integer getQualifyingRacerPlace() {
        return qualifyingRacerPlace;
    }

    public void setQualifyingRacerPlace(Integer qualifyingRacerPlace) {
        this.qualifyingRacerPlace = qualifyingRacerPlace;
    }

    public Integer getQualifyingRacerTime() {
        return qualifyingRacerTime;
    }

    public void setQualifyingRacerTime(Integer qualifyingRacerTime) {
        this.qualifyingRacerTime = qualifyingRacerTime;
    }
    
    public String getQualifyingTimeString() {
        return DateUtil.getTimeStringFromInt(this.qualifyingRacerTime);
    }

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
        if (absolutePoints < 0) {
            this.absolutePoints = 0;
        } else {
            this.absolutePoints = absolutePoints;

        }
    }

    public int getAbsolutePointsByTableB() {
		return absolutePointsByTableB;
	}

	public void setAbsolutePointsByTableB(int absolutePointsByTableB) {
        this.absolutePointsByTableB = absolutePointsByTableB;

	}

	public double getAbsoluteSumm() {
		return absoluteSumm;
	}

	public void setAbsoluteSumm(double absoluteSumm) {
		this.absoluteSumm = absoluteSumm;
	}

	public int getFinalPlace() {
		return finalPlace;
	}

	public void setFinalPlace(int finalPlace) {
		this.finalPlace = finalPlace;
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

    public double getManeuverTime() {
        return maneuverTime;
    }

    public void setManeuverTime(double maneuverTime) {
        this.maneuverTime = maneuverTime;
    }

    @Override
    public String toString() {
        return "CarClassCompetitionResult [id=" + id + ",  absolutePoints=" + absolutePoints + ", absolutePlace="
                + absolutePlace + ", qualifyingTime= "+getQualifyingTimeString()+", qualifyingPlace= "+qualifyingRacerPlace+"]";
    }

    public CarClassCompetitionResult() {
        this.setComment("без штрафу");
    }


}
