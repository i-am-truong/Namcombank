/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.auth;

import java.util.ArrayList;
import java.sql.Date;
import model.Department;

/**
 *
 * @author Asus
 */
public class Staff {
    private int id;
    private String fullname;
    private String username;
    private String password;
    private boolean active;
    private String email;
    private Date dob;
    private boolean gender;
    private String phonenumber;
    private String address;
    private String citizenId;
    private Department dept;
    private Department did;
    private ArrayList<Role> roles;

    public Staff(int id, String fullname, String username, String password, boolean active, String email, Date dob, boolean gender, String phonenumber, String address, String citizenId, Department dept, Department did, ArrayList<Role> roles) {
        this.id = id;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.active = active;
        this.email = email;
        this.dob = dob;
        this.gender = gender;
        this.phonenumber = phonenumber;
        this.address = address;
        this.citizenId = citizenId;
        this.dept = dept;
        this.did = did;
        this.roles = roles;
    }
  
    

    public ArrayList<Role> getRoles() {
        return roles;
    }

    public void setRoles(ArrayList<Role> roles) {
        this.roles = roles;
    }
    
    
    public Department getDid() {
        return did;
    }

    public void setDid(Department did) {
        this.did = did;
    }

    public Department getDept() {
        return dept;
    }

    public void setDept(Department dept) {
        this.dept = dept;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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


    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCitizenId() {
        return citizenId;
    }

    public void setCitizenId(String citizenId) {
        this.citizenId = citizenId;
    }

    
    
    public Staff() {
    }


}
