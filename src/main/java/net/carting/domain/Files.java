package net.carting.domain;

/**
 * Carting
 * Created by manson on 8/10/14.
 */

import javax.persistence.*;

@Entity
@Table(name = "filesDB")
public class Files {

    @Id
    @Column(name = "id")
    @GeneratedValue
    private Integer id;

    @Column(name = "fileName")
    private String fileName;

    @Column(name = "file")
    private byte[] file;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public byte[] getFile() {
        return file;
    }

    public void setFile(byte[] file) {
        this.file = file;
    }

    public Files() {
    }

    public Files(Integer id, String fileName, byte[] file) {
        this.id = id;
        this.fileName = fileName;
        this.file = file;
    }
}
