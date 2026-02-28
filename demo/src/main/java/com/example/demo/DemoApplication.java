package com.example.demo;

import com.example.demo.models.User;
import com.example.demo.repositories.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }

    // NEW: This intercepts the startup process and safely injects the admin user
    @Bean
    public CommandLineRunner seedDatabase(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            // Find the existing admin, or create a new one if it doesn't exist
            User admin = userRepository.findByUsername("admin").orElse(new User());
            
            admin.setUsername("admin");
            // Let Spring Boot handle the exact BCrypt mathematics!
            admin.setPassword(passwordEncoder.encode("admin123")); 
            admin.setRole("ADMIN");
            
            userRepository.save(admin);
            System.out.println("====== ADMIN ACCOUNT SECURED AND READY ======");
        };
    }
}