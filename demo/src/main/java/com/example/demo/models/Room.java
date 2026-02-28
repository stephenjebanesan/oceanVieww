package com.example.demo.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "rooms")
public class Room {
    
    @Id
    @Column(name = "room_number", length = 10)
    private String roomNumber;
    private String roomType;
    private double dailyRate;
    private boolean isAvailable;
    
    @Column(name = "ac_status")
    private String acStatus;
    
    @Column(name = "suite_type")
    private String suiteType;

    // Getters and Setters
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getDailyRate() { return dailyRate; }
    public void setDailyRate(double dailyRate) { this.dailyRate = dailyRate; }

    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    
    public String getAcStatus() { return acStatus; }
    public void setAcStatus(String acStatus) { this.acStatus = acStatus; }
    
    public String getSuiteType() { return suiteType; }
    public void setSuiteType(String suiteType) { this.suiteType = suiteType; }
}