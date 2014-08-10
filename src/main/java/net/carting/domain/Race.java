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
@Table(name = "races")
public class Race {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_id", nullable = false)
    private CarClass carClass;

    @Column(name = "result_sequance", nullable = false)
    private String resultSequance;

    @Column(name = "number_of_laps", nullable = false)
    private Integer numberOfLaps;

    @Column(name = "number_of_members", nullable = false)
    private Integer numberOfMembers;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_competition_id")
    private CarClassCompetition carClassCompetition;

    @Column(name = "race_number", nullable = false)
    private Integer raceNumber;

    public CarClassCompetition getCarClassCompetition() {
        return carClassCompetition;
    }

    public void setCarClassCompetition(CarClassCompetition carClassCompetition) {
        this.carClassCompetition = carClassCompetition;
    }

    public Integer getRaceNumber() {
        return raceNumber;
    }

    public void setRaceNumber(Integer raceNumber) {
        this.raceNumber = raceNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getResultSequance() {
        return resultSequance;
    }

    public void setResultSequance(String resultSequance) {
        this.resultSequance = resultSequance;
    }

    public Integer getNumberOfLaps() {
        return numberOfLaps;
    }

    public void setNumberOfLaps(Integer numberOfLaps) {
        this.numberOfLaps = numberOfLaps;
    }

    public Integer getNumberOfMembers() {
        return numberOfMembers;
    }

    public void setNumberOfMembers(Integer numberOfMembers) {
        this.numberOfMembers = numberOfMembers;
    }

    public CarClass getCarClass() {
        return carClass;
    }

    public void setCarClass(CarClass carClass) {
        this.carClass = carClass;
    }

    public Race() {
    }

    public Race(String resultSequance, Integer numberOfLaps,
                Integer numberOfMembers) {
        this.resultSequance = resultSequance;
        this.numberOfLaps = numberOfLaps;
        this.numberOfMembers = numberOfMembers;
    }

    @Override
    public String toString() {
        return String.format("Race [id=%d, carClass=%s]", id, carClass);
    }

}
