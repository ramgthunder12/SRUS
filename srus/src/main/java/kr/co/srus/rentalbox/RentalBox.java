package kr.co.srus.rentalbox;

import java.io.Serializable;
import java.time.LocalDateTime;

public class RentalBox implements Serializable {
	private int no;
	private int charge;
	private String model;
	private String location;
	private String authKey;
	private LocalDateTime authIssueDate;
	private char division;
	private String size;


	public RentalBox() {
	}

	public RentalBox(int no, int charge, String model, String location, String authKey, LocalDateTime authIssueDate,
			char division, String size) {
		this.no = no;
		this.charge = charge;
		this.model = model;
		this.location = location;
		this.authKey = authKey;
		this.authIssueDate = authIssueDate;
		this.division = division;
		this.size = size;

	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCharge() {
		return charge;
	}

	public void setCharge(int charge) {
		this.charge = charge;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getAuthKey() {
		return authKey;
	}

	public void setAuthKey(String authKey) {
		this.authKey = authKey;
	}

	public LocalDateTime getAuthIssueDate() {
		return authIssueDate;
	}

	public void setAuthIssueDate(LocalDateTime authIssueDate) {
		this.authIssueDate = authIssueDate;
	}

	public char getDivision() {
		return division;
	}

	public void setDivision(char division) {
		this.division = division;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	@Override
	public String toString() {
		return "RentalBox [no=" + no + ", charge=" + charge + ", model=" + model + ", location=" + location
				+ ", authenticationKey=" + authKey + ", authenticationDate=" + authIssueDate + ", division=" + division
				+ "]";
	}
}