/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TQT
 */
public class Active {
    private int active;
    private String activename;

    public Active() {
    }

    public Active(int active, String activename) {
        this.active = active;
        this.activename = activename;
    }
    
    

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    public String getActivename() {
        return activename;
    }

    public void setActivename(String activename) {
        this.activename = activename;
    }
    
    
}
