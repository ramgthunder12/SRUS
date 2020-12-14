package kr.co.srus.validator;

import java.time.LocalDate;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.srus.rental.Rental;

public class RentalDateValidator implements Validator {
	@Override
	public boolean supports(Class<?> clazz) {
		return Rental.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Rental rental = (Rental) target;
		
		LocalDate startDate = rental.getStartDate();
		LocalDate endDate = rental.getEndDate();
		LocalDate currentDate = LocalDate.now();
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "rentalBoxNo", "required");
		
		if (startDate == null) {
			errors.rejectValue("startDate", "required");
		} else if (startDate.isBefore(currentDate) 
				|| (endDate != null && startDate.isAfter(endDate))) {
			errors.rejectValue("startDate", "invalid");
		}
		
		if (endDate == null) {
			errors.rejectValue("endDate", "required");
		} else if (endDate.isBefore(currentDate)
				|| (startDate != null && endDate.isBefore(startDate))) {
			errors.rejectValue("endDate", "invalid");
		}
	}
}
