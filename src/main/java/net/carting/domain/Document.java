package net.carting.domain;

import java.util.Date;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name = "documents")
public class Document {

	public static final int TYPE_RACER_LICENCE = 1;
	public static final int TYPE_RACER_INSURANCE = 2;
	public static final int TYPE_RACER_MEDICAL_CERTIFICATE = 3;
	public static final int TYPE_RACER_PERENTAL_PERMISSIONS = 4;

	@Id
	@GeneratedValue
	@Column(name = "id")
	private int id;

	@Column(name = "type", nullable = false, columnDefinition = "TINYINT(1)")
	private int type;

	@Column(name = "name")
	private String name;

	@Column(name = "start_date")
	private Date startDate;

	@Column(name = "finish_date")
	private Date finishDate;

	@ManyToMany(fetch = FetchType.EAGER, mappedBy = "documents")
	private Set<Racer> racers;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "document", cascade = CascadeType.ALL)
	private Set<File> files;

	@Column(name = "approved", nullable = false, columnDefinition = "TINYINT(1)")
	private boolean approved = false;

	@Column(name = "reason")
	private String reason = "";

	@Column(name = "checked", nullable = false, columnDefinition = "TINYINT(1)")
	private boolean checked = false;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(Date finishDate) {
		this.finishDate = finishDate;
	}

	public Set<File> getFiles() {
		return files;
	}

	public void setFiles(Set<File> files) {
		this.files = files;
	}

	public Set<Racer> getRacers() {
		return racers;
	}

	public void setRacers(Set<Racer> racers) {
		this.racers = racers;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public static String getStringDocumentType(int documentType) {
		String stringDocumentType;
		switch (documentType) {
		case TYPE_RACER_LICENCE:
			stringDocumentType = "Racer's license";
			break;
		case TYPE_RACER_INSURANCE:
			stringDocumentType = "Racer's insurance";
			break;
		case TYPE_RACER_MEDICAL_CERTIFICATE:
			stringDocumentType = "Racer's medical certificate";
			break;
		case TYPE_RACER_PERENTAL_PERMISSIONS:
			stringDocumentType = "Racer's parental permission";
			break;
		default:
			stringDocumentType = "invalidDocumentType";
			break;
		}
		return stringDocumentType;
	}

	public String getCurrentStringDocumentType() {
		String stringDocumentType;
		switch (this.type) {
		case TYPE_RACER_LICENCE:
            stringDocumentType = "Racer's license";
            break;
            case TYPE_RACER_INSURANCE:
                stringDocumentType = "Racer's insurance";
                break;
            case TYPE_RACER_MEDICAL_CERTIFICATE:
                stringDocumentType = "Racer's medical certificate";
                break;
            case TYPE_RACER_PERENTAL_PERMISSIONS:
                stringDocumentType = "Racer's parental permission";
                break;
            default:
                stringDocumentType = "invalidDocumentType";
                break;
        }
		return stringDocumentType;
	}

	public Team getTeamOwner() {
		Team team = null;
		if (type == TYPE_RACER_LICENCE || type == TYPE_RACER_INSURANCE
				|| type == TYPE_RACER_MEDICAL_CERTIFICATE
				|| type == TYPE_RACER_PERENTAL_PERMISSIONS) {
			for (Racer racer : this.racers) {
				return racer.getTeam();
			}
		}
		return team;
	}

	public Document() {
	}

	public Document(int type, Set<File> files) {
		this.setType(type);
		this.setFiles(files);
	}

}
