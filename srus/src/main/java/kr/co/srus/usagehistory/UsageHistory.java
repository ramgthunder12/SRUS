package kr.co.srus.usagehistory;


import java.io.Serializable;
import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

public class UsageHistory implements Serializable {
    private int no;
    private String memberId;
    private int rentalBoxNo;
	@DateTimeFormat(pattern = "yyyy-MM-dd kk:mm:ss")
    private LocalDateTime usageDate;
    private char division;

    public UsageHistory() {
    }

    public UsageHistory(int no, String memberId, int rentalBoxNo, LocalDateTime usageDate, char division) {
        this.no = no;
        this.memberId = memberId;
        this.rentalBoxNo = rentalBoxNo;
        this.usageDate = usageDate;
        this.division = division;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public int getNo() {
        return this.no;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberId() {
        return this.memberId;
    }

    public void setRentalBoxNo(int rentalBoxNo) {
        this.rentalBoxNo = rentalBoxNo;
    }

    public int getRentalBoxNo() {
        return this.rentalBoxNo;
    }

    public void setUsageDate(LocalDateTime usageDate) {
        this.usageDate = usageDate;
    }

    public LocalDateTime getUsageDate() {
        return this.usageDate;
    }

    public void setDivision(char division) {
        this.division = division;
    }

    public char getDivision() {
        return this.division;
    }
}