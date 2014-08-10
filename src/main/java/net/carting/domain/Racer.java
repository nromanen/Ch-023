package net.carting.domain;

import java.util.Calendar;
import java.util.Date;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(catalog="carting", name = "racers")
@AttributeOverrides({
        @AttributeOverride(name = "firstName", column = @Column(name = "first_name", nullable = false)),
        @AttributeOverride(name = "lastName", column = @Column(name = "last_name", nullable = false)),
        @AttributeOverride(name = "document", column = @Column(name = "document", nullable = false)),
        @AttributeOverride(name = "address", column = @Column(name = "address", nullable = false)),
        @AttributeOverride(name = "birthday", column = @Column(name = "birthday", nullable = false)),
        @AttributeOverride(name = "registrationDate", column = @Column(name = "registration_date", nullable = false))})
public class Racer extends Person {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "team_id", nullable = false)
    private Team team;

    @Column(name = "sports_category", nullable = false, columnDefinition = "TINYINT(1)")
    private int sportsCategory;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "racer", cascade = CascadeType.ALL)
    private Set<RacerCarClassNumber> carClassNumbers;

    @Column(name = "enabled", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean enabled = true;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "racer_document", joinColumns = {@JoinColumn(name = "racer_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "document_id", nullable = false, updatable = false)})
    private Set<Document> documents;

    public Team getTeam() {
        return team;
    }

    public void setTeam(Team team) {
        this.team = team;
    }

    public int getSportsCategory() {
        return sportsCategory;
    }

    public void setSportsCategory(int sportsCategory) {
        this.sportsCategory = sportsCategory;
    }

    public Set<RacerCarClassNumber> getCarClassNumbers() {
        return carClassNumbers;
    }

    public void setCarClassNumbers(Set<RacerCarClassNumber> carClassNumbers) {
        this.carClassNumbers = carClassNumbers;
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
        return String.format("Racer [id=%d, firstName=%s, lastName=%s]",id, firstName, lastName);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Set<Document> getDocuments() {
        return documents;
    }

    public void setDocuments(Set<Document> documents) {
        this.documents = documents;
    }

    public int getAge() {
        Calendar currentDate = Calendar.getInstance();
        currentDate.setTime(new Date());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(birthday);
        int age = currentDate.get(Calendar.YEAR) - calendar.get(Calendar.YEAR)
                - (calendar.get(Calendar.MONTH) + 6) / 12;
        return age;
    }

    public String getStringSportsCategory() {
        String stringSportsCategory;
        switch (this.sportsCategory) {
            case 0:
                stringSportsCategory = "Without sports category";
                break;
            case 1:
                stringSportsCategory = "1";
                break;
            case 2:
                stringSportsCategory = "2";
                break;
            case 3:
                stringSportsCategory = "3";
                break;
            case 4:
                stringSportsCategory = "Candidate master of sports";
                break;
            case 5:
                stringSportsCategory = "Master of sports";
                break;
            default:
                stringSportsCategory = "Invalid sportsCategory";
                break;
        }
        return stringSportsCategory;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    /**
     * Returns a Document object according to type and to current racer
     * <p/>
     * <center><b>Transcript types<b></center>
     * <p/>
     * 1 - racer's license;
     * <p/>
     * 2 - racer's insurance;
     * <p/>
     * 3 - racer's medical certificate;
     * <p/>
     * 4 - racer's parental permission;
     *
     * @param type a type from the set {1, 2, 3, 4}
     * @return the document according to type or null if document don't exist or
     * type incorrect
     */
    public Document getDocumentByType(int type) {
        if (this.documents != null && this.documents.size() != 0) {
            for (Document document : this.documents) {
                if (document.getType() == type) {
                    return document;
                }
            }
        }
        return null;
    }

    public boolean isRacerSuitableToCarClass(CarClass carClass) {
        if (getAge() >= carClass.getLowerYearsLimit()
                && getAge() <= carClass.getUpperYearsLimit()) {
            return true;
        }
        return false;
    }

    public Racer() {
    }

}
