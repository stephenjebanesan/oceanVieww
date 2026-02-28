-- 1. Create the Database
CREATE DATABASE IF NOT EXISTS ocean_view_resort;
USE ocean_view_resort;

-- 2. Create Users Table (Addresses Task 1: User Authentication [cite: 22, 24])
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Storing plain text is bad practice
    role VARCHAR(20) DEFAULT 'Receptionist'
);

-- 3. Create Guests Table (Addresses Task 2: Store guest details [cite: 25, 26])
CREATE TABLE guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    contact_number VARCHAR(20) NOT NULL
);

-- 4. Create Rooms Table 
CREATE TABLE rooms (
    room_number VARCHAR(10) PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    daily_rate DECIMAL(10, 2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);

-- 5. Create Reservations Table (Addresses Task 2: Store booking details [cite: 25, 26])
-- Uses a UUID or auto-increment for the unique "reservation number" [cite: 20]
CREATE TABLE reservations (
    reservation_number INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id) ON DELETE CASCADE,
    FOREIGN KEY (room_number) REFERENCES rooms(room_number) ON DELETE RESTRICT
);

-- 6. Create Bills Table (Addresses Task 4: Calculate and Print Bill [cite: 30, 31])
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_number INT NOT NULL,
    number_of_nights INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    generated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reservation_number) REFERENCES reservations(reservation_number) ON DELETE CASCADE
);

-- 7. ADVANCED FEATURE: Trigger for Business Logic 
-- Automatically updates a room's status to unavailable when a new reservation is made.
DELIMITER //

CREATE TRIGGER after_reservation_created
AFTER INSERT ON reservations
FOR EACH ROW
BEGIN
    UPDATE rooms 
    SET is_available = FALSE 
    WHERE room_number = NEW.room_number;
END;
//

DELIMITER ;

-- 8. Insert some dummy data to test the system
INSERT INTO users (username, password_hash) VALUES ('admin', 'hashed_password_here');
INSERT INTO rooms (room_number, room_type, daily_rate) VALUES ('101', 'Standard', 100.00), ('102', 'Deluxe', 150.00), ('201', 'Suite', 250.00);
