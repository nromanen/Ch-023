package net.carting.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailServiceImpl implements MailService {

    private static final Logger LOG = LoggerFactory.getLogger(MailServiceImpl.class);
    
    @Autowired
    private JavaMailSender javaMailSender;

    @Override
    public void sendMail(String to, String from, String subject, String body) {

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
            helper.setTo(to);
            helper.setFrom(from);
            helper.setSubject(subject);
            helper.setText("From: " + from + "<br><br>" + body, true);

		      /*file = new FileSystemResource(&quot;attachment.jpg&quot;);
              helper.addAttachment(file.getFilename(), file);*/

            javaMailSender.send(mimeMessage);

        } catch (MessagingException e) {
            LOG.error("Errors in sendMail method. Tried to send mail(from = {}, to = {})", from, to, e);
        }
    }

}
