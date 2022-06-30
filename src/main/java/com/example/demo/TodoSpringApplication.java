package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;

@SpringBootApplication
public class TodoSpringApplication{
//    @Override
//    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
//        return application.sources(TodoSpringApplication.class);
//    }
    public static void main(String[] args) {
        SpringApplication.run(TodoSpringApplication.class, args);
    }

}
