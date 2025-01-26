/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author TQT
 */
public class Staff {
    private int staffId;
    private int departmentId;
    private String fullName;
    private String username;
    private String password;
    private boolean active;
    private String email;
    private Date dob;
    private boolean gender;
    private String citizenIdentificationCard;
    private String address;

    public Staff() {
    }

    public Staff(int staffId, int departmentId, String fullName, String username, String password, boolean active, String email, Date dob, boolean gender, String citizenIdentificationCard, String address) {
        this.staffId = staffId;
        this.departmentId = departmentId;
        this.fullName = fullName;
        this.username = username;
        this.password = password;
        this.active = active;
        this.email = email;
        this.dob = dob;
        this.gender = gender;
        this.citizenIdentificationCard = citizenIdentificationCard;
        this.address = address;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getCitizenIdentificationCard() {
        return citizenIdentificationCard;
    }

    public void setCitizenIdentificationCard(String citizenIdentificationCard) {
        this.citizenIdentificationCard = citizenIdentificationCard;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Staff{" + "staffId=" + staffId + ", departmentId=" + departmentId + ", fullName=" + fullName + ", username=" + username + ", password=" + password + ", active=" + active + ", email=" + email + ", dob=" + dob + ", gender=" + gender + ", citizenIdentificationCard=" + citizenIdentificationCard + ", address=" + address + '}';
    }
    
    
}
