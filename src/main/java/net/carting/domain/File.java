package net.carting.domain;

import org.springframework.security.crypto.codec.Base64;

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

    @Column(name = "file", nullable = false)
    private byte[] file;

    @Column(name="name")
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

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

    public String getFile() {
        return new String(Base64.encode(file));
    }

    public void setFile(byte[] file) {
        this.file = file;
    }


    public File() {
    }

    public File(Document document, byte[] path) {
        this.setDocument(document);
        this.setFile(path);
    }

}
