package net.carting.util;

import net.carting.domain.Leader;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * Carting
 * Created by mgalctc on 8/19/14.
 */
public class LeaderValidator implements Validator {

	private static final String NAME_PATTERN = "[A-ZА-ЯІЇЄ]{1}[A-ZА-ЯІЇЄa-zа-яіїє-]{1,30}";
	private static final String EMAIL_PATTERN = "[A-Za-z0-9_\\.-]{1,30}@[A-Za-z0-9_\\.-]{1,30}";
	
	
    @Override
    public boolean supports(Class aClass) {
        return Leader.class.equals(aClass);
    }

    @Override
    public void validate(Object obj, Errors errors) {
        Leader leader = (Leader) obj;
        if (!leader.getFirstName().matches(NAME_PATTERN)) {
        	errors.rejectValue("firstName", "dataerror.firstname");
        }
        if (!leader.getLastName().matches(NAME_PATTERN)) {
        	errors.rejectValue("lastName", "dataerror.lastname");
        }
        if (!leader.getDocument().matches(".{1,50}")) {
        	errors.rejectValue("document", "dataerror.field_required");
        }
        if (!leader.getAddress().matches(".{1,100}")) {
        	errors.rejectValue("address", "dataerror.field_required");
        }
        if (!leader.getLicense().matches(".{1,30}")) {
        	errors.rejectValue("license", "dataerror.field_required");
        }
        if (!leader.getUser().getUsername().matches(".{1,30}")) {
        	errors.rejectValue("user.username", "dataerror.field_required");
        }
        if (leader.getUser().getPassword().length() < 5) {
        	errors.rejectValue("user.password", "dataerror.mimimum_5_characters");
        }
        if (!leader.getUser().getEmail().matches(EMAIL_PATTERN)) {
        	errors.rejectValue("user.email", "dataerror.email_example");
        }
    }
}
