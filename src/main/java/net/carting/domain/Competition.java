package net.carting.domain;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "competitions")
public class Competition {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private int id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "place", nullable = false)
    private String place;

    @Column(name = "date_start", nullable = false, columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateStart;

    @Column(name = "date_end", nullable = false, columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateEnd;

    @Column(name = "first_race_date", nullable = false, columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date firstRaceDate;

    @Column(name = "second_race_date", nullable = false, columnDefinition = "DATE")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date secondRaceDate;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "competition", cascade = CascadeType.ALL)
    private Set<CarClassCompetition> carClassCompetitions;

    @Column(name = "secretary_name", nullable = false)
    private String secretaryName;

    @Column(name = "secretary_category_judicial_license", nullable = false)
    private String secretaryCategoryJudicialLicense;

    @Column(name = "director_name", nullable = false)
    private String directorName;

    @Column(name = "director_category_judicial_license", nullable = false)
    private String directorCategoryJudicialLicense;

    @Column(name = "enabled", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean enabled = false;

	@Column(name = "calculate_by_table_b", nullable = false, columnDefinition = "TINYINT(1)")
    private boolean calculateByTableB = false;
    
    @Column(name = "points_by_places", nullable = false)
    private String pointsByPlaces;
    
    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "absoluteResultsStatement_id")
    @NotFound(action=NotFoundAction.IGNORE)
    private File absoluteResultsStatement;

    public File getAbsoluteResultsStatement() {
        return absoluteResultsStatement;
    }

    public void setAbsoluteResultsStatement(File absoluteResultsStatement) {
        this.absoluteResultsStatement = absoluteResultsStatement;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getFirstRaceDate() {
        return firstRaceDate;
    }

    public void setFirstRaceDate(Date firstRaceDate) {
        this.firstRaceDate = firstRaceDate;
    }

    public Date getSecondRaceDate() {
        return secondRaceDate;
    }

    public void setSecondRaceDate(Date secondRaceDate) {
        this.secondRaceDate = secondRaceDate;
    }

    public Set<CarClassCompetition> getCarClassCompetitions() {
        return carClassCompetitions;
    }

    public void setCarClassCompetitions(
            Set<CarClassCompetition> carClassCompetitions) {
        this.carClassCompetitions = carClassCompetitions;
    }

    public String getSecretaryCategoryJudicialLicense() {
        return secretaryCategoryJudicialLicense;
    }

    public void setSecretaryCategoryJudicialLicense(
            String secretaryCategoryJudicialLicense) {
        this.secretaryCategoryJudicialLicense = secretaryCategoryJudicialLicense;
    }

    public String getDirectorCategoryJudicialLicense() {
        return directorCategoryJudicialLicense;
    }

    public void setDirectorCategoryJudicialLicense(
            String directorCategoryJudicialLicense) {
        this.directorCategoryJudicialLicense = directorCategoryJudicialLicense;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getSecretaryName() {
        return secretaryName;
    }

    public void setSecretaryName(String secretaryName) {
        this.secretaryName = secretaryName;
    }

    public String getDirectorName() {
        return directorName;
    }

    public void setDirectorName(String directorName) {
        this.directorName = directorName;
    }
    
    public boolean isCalculateByTableB() {
		return calculateByTableB;
	}

	public void setCalculateByTableB(boolean calculateByTableB) {
		this.calculateByTableB = calculateByTableB;
	}

	public String getPointsByPlaces() {
		return pointsByPlaces;
	}

	public void setPointsByPlaces(String pointsByPlaces) {
		this.pointsByPlaces = pointsByPlaces;
	}

    @Override
    public String toString() {
        return String.format("Competition [id=%d, name=%s, absRankingFileId=%d]", id, name,absoluteResultsStatement.getId());
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((dateEnd == null) ? 0 : dateEnd.hashCode());
        result = prime * result
                + ((dateStart == null) ? 0 : dateStart.hashCode());
        result = prime * result + ((name == null) ? 0 : name.hashCode());
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
        Competition other = (Competition) obj;
        if (dateEnd == null) {
            if (other.dateEnd != null)
                return false;
        } else if (!dateEnd.equals(other.dateEnd))
            return false;
        if (dateStart == null) {
            if (other.dateStart != null)
                return false;
        } else if (!dateStart.equals(other.dateStart))
            return false;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        return true;
    }


}
