package com.example.demo.repositories;

import com.example.demo.models.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, String> {
    // Spring magically writes the SQL query for this method name!
    List<Room> findByIsAvailableTrue();
}