package kr.co.srus.member;

import java.io.Serializable;
import java.time.LocalDate;

public class Member implements Serializable {
	private String id;
	private String password;
	private String email;
	private String phoneNumber;
	private char division;
	private LocalDate withdrawalDate;
	private String cardName;
	private String cardUid;

	public Member() {
	}

	public Member(String id, String password, String email, String phoneNumber, char division, LocalDate withdrawalDate,
			String cardName, String cardUid) {
		this.id = id;
		this.password = password;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.division = division;
		this.withdrawalDate = withdrawalDate;
		this.cardName = cardName;
		this.cardUid = cardUid;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return this.id;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return this.email;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getPhoneNumber() {
		return this.phoneNumber;
	}

	public void setDivision(char division) {
		this.division = division;
	}

	public char getDivision() {
		return this.division;
	}

	public void setWithdrawalDate(LocalDate withdrawalDate) {
		this.withdrawalDate = withdrawalDate;
	}
	
	public String getCardName() {
		return cardName;
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getCardUid() {
		return cardUid;
	}

	public void setCardUid(String cardUid) {
		this.cardUid = cardUid;
	}

	public LocalDate getWithdrawalDate() {
		return this.withdrawalDate;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", password=" + password + ", email=" + email + ", phoneNumber=" + phoneNumber
				+ ", division=" + division + ", withdrawalDate=" + withdrawalDate + "]";
	}

}