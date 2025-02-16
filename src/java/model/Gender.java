/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TQT
 */
public class Gender {
    private int gender;
    private String gendername;

    public Gender() {
    }

    public Gender(int gender, String gendername) {
        this.gender = gender;
        this.gendername = gendername;
    }

    
    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getGendername() {
        return gendername;
    }

    public void setGendername(String gendername) {
        this.gendername = gendername;
    }
    
    
}
