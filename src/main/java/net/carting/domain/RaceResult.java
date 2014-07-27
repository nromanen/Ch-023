package net.carting.domain;

import javax.persistence.*;

@Entity
@Table(name = "race_results")
public class RaceResult {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "racer_id", nullable = false)
    private Racer racer;

    @Column(name = "place", nullable = false)
    private Integer place;

    @Column(name = "points", nullable = false)
    private Integer points;

    @Column(name = "full_laps", nullable = false)
    private Integer fullLaps;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "race_id", nullable = false)
    private Race race;


    @Column(name = "car_number", nullable = false)
    private Integer carNumber;

    public Integer getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(Integer carNumber) {
        this.carNumber = carNumber;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Racer getRacer() {
        return racer;
    }

    public void setRacer(Racer racer) {
        this.racer = racer;
    }

    public Integer getPlace() {
        return place;
    }

    public void setPlace(Integer place) {
        this.place = place;
    }

    public Integer getPoints() {
        return points;
    }

    public void setPoints(Integer points) {
        this.points = points;
    }

    public Integer getFullLaps() {
        return fullLaps;
    }

    public void setFullLaps(Integer fullLaps) {
        this.fullLaps = fullLaps;
    }

    public Race getRace() {
        return race;
    }

    public void setRace(Race race) {
        this.race = race;
    }
}
