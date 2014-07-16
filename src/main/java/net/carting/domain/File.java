package net.carting.domain;

import javax.persistence.*;

@Entity
@Table(name = "files")
public class File {

	@Id
	@GeneratedValue
	@Column(name = "id")
	private int id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "document_id", nullable = false)
	private Document document;

	@Column(name = "path", nullable = false)
	private String path;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Document getDocument() {
		return document;
	}

	public void setDocument(Document document) {
		this.document = document;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public File() {
	}

	public File(Document document, String path) {
		this.setDocument(document);
		this.setPath(path);
	}

}
