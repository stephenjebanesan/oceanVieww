package com.example.demo.controllers;

import com.example.demo.dto.ReservationRequest;
import com.example.demo.models.Guest;
import com.example.demo.models.Reservation;
import com.example.demo.models.Room;
import com.example.demo.repositories.GuestRepository;
import com.example.demo.repositories.ReservationRepository;
import com.example.demo.repositories.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/api/reservations")
public class ReservationController {

    @Autowired
    private GuestRepository guestRepository;
    @Autowired
    private RoomRepository roomRepository;
    @Autowired
    private ReservationRepository reservationRepository;

    @GetMapping("/all")
    public List<Reservation> getAll() {
        return reservationRepository.findAll();
    }

    @PostMapping("/book")
    public ResponseEntity<String> bookRoom(@RequestBody ReservationRequest request) {
        Optional<Room> roomOpt = roomRepository.findById(request.getRoomNumber());
        if (roomOpt.isEmpty()) {
            return ResponseEntity.badRequest().body("Room not available.");
        }

        Guest guest = new Guest();
        guest.setGuestName(request.getGuestName());
        guest.setAddress(request.getAddress());
        guest.setContactNumber(request.getContactNumber());
        guest = guestRepository.save(guest);

        Reservation res = new Reservation();
        res.setGuest(guest);
        res.setRoom(roomOpt.get());
        res.setCheckInDate(request.getCheckInDate());
        res.setCheckOutDate(request.getCheckOutDate());
        reservationRepository.save(res);

        return ResponseEntity.ok("Booking successful!");
    }

@DeleteMapping("/{id}")
    public ResponseEntity<String> deleteBooking(@PathVariable("id") int id) {
        System.out.println("Received delete request for Reservation ID: " + id); // Log for Ubuntu Terminal
        
        Optional<Reservation> resOpt = reservationRepository.findById(id);
        
        if (resOpt.isPresent()) {
            Reservation reservation = resOpt.get();
            Room room = reservation.getRoom();
            
            room.setAvailable(true);
            roomRepository.save(room);
            
            reservationRepository.deleteById(id);
            return ResponseEntity.ok("Deleted successfully");
        }
        return ResponseEntity.status(404).body("Reservation not found");
    }
}