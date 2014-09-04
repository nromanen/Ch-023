package net.carting.domain;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
@Entity
@Table(name = "logs")
public class Logs {

    @Column(name = "logger")
    String logger;

    @Column(name = "level")
    String level;

    @Id
    @Column(name = "message")
    String message;

    @Column(name = "date")
    Timestamp date;

    public Logs() {
    }

    public Logs(String logger, String level, String message, Timestamp date) {
        this.logger = logger;
        this.level = level;
        this.message = message;
        this.date = date;
    }

    public String getLogger() {
        return logger;
    }

    public void setLogger(String logger) {
        this.logger = logger;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
}
