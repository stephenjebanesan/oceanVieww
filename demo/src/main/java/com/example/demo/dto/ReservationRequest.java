package com.example.demo.dto;

import java.time.LocalDate;

public class ReservationRequest {
    private String guestName;
    private String address;
    private String contactNumber;
    private String roomNumber;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;

    // Getters
    public String getGuestName() { return guestName; }
    public String getAddress() { return address; }
    public String getContactNumber() { return contactNumber; }
    public String getRoomNumber() { return roomNumber; }
    public LocalDate getCheckInDate() { return checkInDate; }
    public LocalDate getCheckOutDate() { return checkOutDate; }
}