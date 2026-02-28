package com.example.demo.controllers;

import com.example.demo.models.Room;
import com.example.demo.repositories.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*", allowedHeaders = "*")
@RestController
@RequestMapping("/api/rooms")
public class RoomController {

    @Autowired
    private RoomRepository roomRepository;

    @GetMapping("/available")
    public List<Room> getAvailableRooms() {
        return roomRepository.findByIsAvailableTrue();
    }

    // NEW METHOD: Fetch a single room's details by ID
    @GetMapping("/{id}")
    public ResponseEntity<Room> getRoomById(@PathVariable("id") String id) {
        return roomRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/add")
    public ResponseEntity<String> addRoom(@RequestBody Room room) {
        if (roomRepository.existsById(room.getRoomNumber())) {
            return ResponseEntity.badRequest().body("Error: Room number already exists.");
        }
        room.setAvailable(true); 
        roomRepository.save(room);
        return ResponseEntity.ok("Room " + room.getRoomNumber() + " added successfully!");
    }
}