package net.carting.service;

public interface MailService {

    public void sendMail(String to, String from, String subject, String body);

}
