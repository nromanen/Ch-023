package net.carting.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "car_class_competition")
public class CarClassCompetition {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "competition_id", nullable = false)
    private Competition competition;

    @OneToOne
    @JoinColumn(name = "car_class_id", nullable = false)
    private CarClass carClass;

    @Column(name = "first_race_time", nullable = false, columnDefinition = "TIME")
    @DateTimeFormat(pattern = "HH:mm")
    private Date firstRaceTime;

    @Column(name = "second_race_time", nullable = false, columnDefinition = "TIME")
    @DateTimeFormat(pattern = "HH:mm")
    private Date secondRaceTime;

    @Column(name = "circle_count", nullable = false)
    private int circleCount;

    @Column(name = "percentage_offset", nullable = false)
    private int percentageOffset;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "carClassCompetition", cascade = CascadeType.ALL)
    private Set<Race> races;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "carClassCompetition", cascade = CascadeType.ALL)
    private Set<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers = new HashSet<RacerCarClassCompetitionNumber>();
    
    @Column(name = "calculate_by_table_b", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean calculateByTableB = false;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public Set<RacerCarClassCompetitionNumber> getRacerCarClassCompetitionNumbers() {
    	return racerCarClassCompetitionNumbers;
    }
    
    public void setRacerCarClassCompetitionNumbers(Set<RacerCarClassCompetitionNumber> racerCarClassCompetitionNumbers) {
    	this.racerCarClassCompetitionNumbers = racerCarClassCompetitionNumbers;
    }

    public Competition getCompetition() {
        return competition;
    }

    public void setCompetition(Competition competition) {
        this.competition = competition;
    }

    public CarClass getCarClass() {
        return carClass;
    }

    public void setCarClass(CarClass carClass) {
        this.carClass = carClass;
    }

    public Date getFirstRaceTime() {
        return firstRaceTime;
    }

    public void setFirstRaceTime(Date firstRaceTime) {
        this.firstRaceTime = firstRaceTime;
    }

    public Date getSecondRaceTime() {
        return secondRaceTime;
    }

    public void setSecondRaceTime(Date secondRaceTime) {
        this.secondRaceTime = secondRaceTime;
    }

    public int getCircleCount() {
        return circleCount;
    }

    public void setCircleCount(int circleCount) {
        this.circleCount = circleCount;
    }

    public int getPercentageOffset() {
        return percentageOffset;
    }

    public void setPercentageOffset(int percentageOffset) {
        this.percentageOffset = percentageOffset;
    }

    public Set<Race> getRaces() {
        return races;
    }

    public void setRaces(Set<Race> races) {
        this.races = races;
    }
    
    public void setCalculateByTableB(boolean calculateByTableB) {
    	this.calculateByTableB = calculateByTableB;
    }
    
    public boolean getCalculateByTableB() {
    	return calculateByTableB;
    }

    @Override
    public String toString() {
        return String
                .format("CarClassCompetition [id=%d, competition=%s]",
                        id, competition);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((carClass == null) ? 0 : carClass.hashCode());
        result = prime * result
                + ((competition == null) ? 0 : competition.hashCode());
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
        CarClassCompetition other = (CarClassCompetition) obj;
        if (carClass == null) {
            if (other.carClass != null)
                return false;
        } else if (!carClass.equals(other.carClass))
            return false;
        if (competition == null) {
            if (other.competition != null)
                return false;
        } else if (!competition.equals(other.competition))
            return false;
        return true;
    }


}
