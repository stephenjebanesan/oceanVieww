package com.example.demo.controllers;

import com.example.demo.models.Bill;
import com.example.demo.models.Reservation;
import com.example.demo.repositories.BillRepository;
import com.example.demo.repositories.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.CrossOrigin;
import java.time.temporal.ChronoUnit;
import java.util.Optional;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/api/bills")
public class BillController {

    @Autowired
    private ReservationRepository reservationRepository;
    
    @Autowired
    private BillRepository billRepository;

    // Task 4: Calculate and Print Bill
    @PostMapping("/generate/{reservationId}")
    public ResponseEntity<?> generateBill(@PathVariable int reservationId) {
        Optional<Reservation> resOpt = reservationRepository.findById(reservationId);
        
        if (resOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Error: Reservation not found.");
        }
        
        Reservation reservation = resOpt.get();
        
        // Calculate the number of nights
        long nights = ChronoUnit.DAYS.between(reservation.getCheckInDate(), reservation.getCheckOutDate());
        if (nights <= 0) nights = 1; // Minimum 1 night charge
        
        // Calculate total amount (Nights * Room Rate)
        double totalAmount = nights * reservation.getRoom().getDailyRate();
        
        // Create and save the Bill
        Bill bill = new Bill();
        bill.setReservation(reservation);
        bill.setNumberOfNights((int) nights);
        bill.setTotalAmount(totalAmount);
        
        billRepository.save(bill);
        
        return ResponseEntity.ok(bill);
    }
}