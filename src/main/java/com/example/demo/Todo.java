package com.example.demo;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
public class Todo {
    @Id
    private int id;
    private String title;
    private String description;
    private String cdate;
    private boolean tstatus;




    public boolean isTstatus() {
        return tstatus;
    }

    public void setTstatus(boolean tstatus) {
        this.tstatus = tstatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCdate() {
        return cdate;
    }

    public void setCdate(String cdate) {
        this.cdate = cdate;
    }






}
