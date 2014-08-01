package net.carting.domain;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "leaders")
@AttributeOverrides({
        @AttributeOverride(name = "firstName", column = @Column(name = "first_name", nullable = false)),
        @AttributeOverride(name = "lastName", column = @Column(name = "last_name", nullable = false)),
        @AttributeOverride(name = "document", column = @Column(name = "document", nullable = false)),
        @AttributeOverride(name = "address", column = @Column(name = "address", nullable = false)),
        @AttributeOverride(name = "birthday", column = @Column(name = "birthday", nullable = false)),
        @AttributeOverride(name = "registrationDate", column = @Column(name = "registration_date", nullable = false))})
public class Leader extends Person {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user", nullable = false)
    private User user;

    @Column(name = "license", nullable = false)
    private String license;

    public Leader() {
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    @Override
    public int hashCode() {
        return super.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    @Override
    public String toString() {
        return String.format("Leader [id=%d, firstName=%s, lastName=%s]",id, firstName, lastName);
    }

}
