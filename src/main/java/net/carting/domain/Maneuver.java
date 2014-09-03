package net.carting.domain;

import javax.annotation.Generated;
import javax.persistence.*;

/**
 * Created by manson on 9/2/14.
 */
@Entity
@Table(name = "maneuver")
public class Maneuver {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private Integer id;

    @Column(name = "name")
    private String name;

    public Maneuver() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
