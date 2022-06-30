package com.example.demo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


public interface TodoRepo extends JpaRepository<Todo,Integer> {

//    fetch the maximum id from the database
    @Query("select max(t.id) from Todo t")
    public Integer getMaxId();


//    count the due status
    @Query("select count(t.id) from Todo t where t.tstatus=false")
    public Integer getTotalDue();



}