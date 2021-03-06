package net.carting.domain;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "firstStartStatement_id")
    private File firstRaceStartStatement;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "secondStartStatement_id")
    private File secondRaceStartStatement;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "maneuverStatement_id")
    private File maneuverStatement;
    
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "personalOffset_id")
    private File personalOffset;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public File getFirstRaceStartStatement() {
        return firstRaceStartStatement;
    }

    public void setFirstRaceStartStatement(File firstRaceStartStatement) {
        this.firstRaceStartStatement = firstRaceStartStatement;
    }

    public File getSecondRaceStartStatement() {
        return secondRaceStartStatement;
    }

    public void setSecondRaceStartStatement(File secondRaceStartStatement) {
        this.secondRaceStartStatement = secondRaceStartStatement;
    }

    public File getManeuverStatement() {
        return maneuverStatement;
    }

    public void setManeuverStatement(File maneuverStatement) {
        this.maneuverStatement = maneuverStatement;
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

    public File getPersonalOffset() {
        return personalOffset;
    }

    public void setPersonalOffset(File personalOffset) {
        this.personalOffset = personalOffset;
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
