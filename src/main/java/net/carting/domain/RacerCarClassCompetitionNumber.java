package net.carting.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(catalog="carting", name = "racer_competition_car_class_numbers", uniqueConstraints = {@UniqueConstraint(columnNames = {"racer_id", "car_class_competition_id"})})
public class RacerCarClassCompetitionNumber {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "racer_id", nullable = false)
    private Racer racer;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "car_class_competition_id", nullable = false)
    private CarClassCompetition carClassCompetition;

    @Column(name = "number_in_competition", nullable = false)
    private int numberInCompetition;

    public RacerCarClassCompetitionNumber() {
    }

    public RacerCarClassCompetitionNumber(Racer racer,
                                          CarClassCompetition carClassCompetition, int numberInCompetition) {
        this.racer = racer;
        this.carClassCompetition = carClassCompetition;
        this.numberInCompetition = numberInCompetition;
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

    public CarClassCompetition getCarClassCompetition() {
        return carClassCompetition;
    }

    public void setCarClassCompetition(CarClassCompetition carClassCompetition) {
        this.carClassCompetition = carClassCompetition;
    }

    public int getNumberInCompetition() {
        return numberInCompetition;
    }

    public void setNumberInCompetition(int numberInCompetition) {
        this.numberInCompetition = numberInCompetition;
    }

    @Override
    public String toString() {
        return String.format(
                "RacerCarClassCompetitionNumber [id=%d, racer=%s]",id, racer);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime
                * result
                + ((carClassCompetition == null) ? 0 : carClassCompetition
                .hashCode());
        result = prime * result + numberInCompetition;
        result = prime * result + ((racer == null) ? 0 : racer.hashCode());
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
        RacerCarClassCompetitionNumber other = (RacerCarClassCompetitionNumber) obj;
        if (carClassCompetition == null) {
            if (other.carClassCompetition != null)
                return false;
        } else if (!carClassCompetition.equals(other.carClassCompetition))
            return false;
        if (numberInCompetition != other.numberInCompetition)
            return false;
        if (racer == null) {
            if (other.racer != null)
                return false;
        } else if (!racer.equals(other.racer))
            return false;
        return true;
    }

}