package net.carting.domain;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Carting
 * Created by manson on 8/20/14.
 */
@Entity
@Table(name = "logs")
public class Logs {

    @Column(name = "logger")
    String logger;

    @Id
    @Column(name = "message")
    String message;

    @Column(name = "date")
    @DateTimeFormat(pattern="dd.MM.yyyy")
    Date date;

    public Logs() {
    }

    public Logs(String logger, String message, Date date) {
        this.logger = logger;
        this.message = message;
        this.date = date;
    }

    public String getLogger() {
        return logger;
    }

    public void setLogger(String logger) {
        this.logger = logger;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Date getDate() {
        return date;
    }

    public String getStringDate() {
        DateFormat formatter = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss");
        return formatter.format(date);
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
