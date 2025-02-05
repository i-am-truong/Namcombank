/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.auth;

import java.util.ArrayList;

/**
 *
 * @author Asus
 */
public class Role {
    private int id;
    private String name;
    private ArrayList<Staff> users = new ArrayList<>();
    private ArrayList<Feature> features = new ArrayList<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<Staff> getUsers() {
        return users;
    }

    public void setUsers(ArrayList<Staff> users) {
        this.users = users;
    }

    public ArrayList<Feature> getFeatures() {
        return features;
    }

    public void setFeatures(ArrayList<Feature> features) {
        this.features = features;
    }
    
}
