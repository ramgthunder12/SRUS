package kr.co.srus.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.srus.rentalbox.RentalBox;

public class RentalBoxValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return RentalBox.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "model", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "location", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "size", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "charge", "required");
	}
}
