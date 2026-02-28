package com.example.demo.controllers;

import com.example.demo.models.Bill;
import com.example.demo.models.Reservation;
import com.example.demo.repositories.BillRepository;
import com.example.demo.repositories.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
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

    @PostMapping("/generate/{reservationId}")
    public ResponseEntity<?> generateBill(@PathVariable(name = "reservationId") int reservationId) {
        Optional<Reservation> resOpt = reservationRepository.findById(reservationId);
        
        if (resOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Error: Reservation not found.");
        }
        
        Reservation reservation = resOpt.get();
        
        if (reservation.getRoom() == null) {
            return ResponseEntity.badRequest().body("Error: No room associated with this reservation.");
        }
        
        // LOGIC FIX: Calculate nights based on TODAY if they check out early
        LocalDate actualCheckOut = LocalDate.now();
        long nights = ChronoUnit.DAYS.between(reservation.getCheckInDate(), actualCheckOut);
        
        if (nights <= 0) nights = 1; // Minimum 1 night charge
        
        double totalAmount = nights * reservation.getRoom().getDailyRate();
        
        Bill bill = new Bill();
        bill.setReservation(reservation);
        bill.setNumberOfNights((int) nights);
        bill.setTotalAmount(totalAmount);
        
        billRepository.save(bill);
        
        return ResponseEntity.ok(bill);
    }
}