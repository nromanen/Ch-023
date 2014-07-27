package net.carting.domain;

import javax.persistence.*;

@Entity
@Table(name = "racer_car_class_numbers", uniqueConstraints = {@UniqueConstraint(columnNames = {"racer_id", "car_class_id"})})
public class RacerCarClassNumber {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "racer_id", nullable = false)
    private Racer racer;

    @OneToOne
    @JoinColumn(name = "car_class_id", nullable = false)
    private CarClass carClass;

    @Column(name = "number", nullable = false)
    private int number;

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

    public CarClass getCarClass() {
        return carClass;
    }

    public void setCarClass(CarClass carClass) {
        this.carClass = carClass;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result
                + ((carClass == null) ? 0 : carClass.hashCode());
        result = prime * result + id;
        result = prime * result + number;
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
        RacerCarClassNumber other = (RacerCarClassNumber) obj;
        if (carClass == null) {
            if (other.carClass != null)
                return false;
        } else if (!carClass.equals(other.carClass))
            return false;
        if (id != other.id)
            return false;
        if (number != other.number)
            return false;
        if (racer == null) {
            if (other.racer != null)
                return false;
        } else if (!racer.equals(other.racer))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return String.format("RacerCarClassNumber [id=%s, racer=%s, "
                + "carClass=%s, number=%s]", id, racer, carClass, number);
    }

    public RacerCarClassNumber() {
    }

    public RacerCarClassNumber(Racer racer, CarClass carClass, int number) {
        this.racer = racer;
        this.carClass = carClass;
        this.number = number;
    }
}