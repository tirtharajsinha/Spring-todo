package com.example.demo;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
public class todoController {

    @Autowired
    TodoRepo repo;



    @RequestMapping("/")
    public ModelAndView index() {
//        index page, only returns the saved todos.
        ModelAndView mv = new ModelAndView("index");
        List<Todo> data = repo.findAll();
        mv.addObject("datas", data);
        mv.addObject("total",data.size());
        int due=repo.getTotalDue();
        System.out.println(repo.getMaxId());
        int done=data.size()-due;
        mv.addObject("due",due);
        mv.addObject("done",done);
        return mv;
    }


    @RequestMapping(value = "/", method = RequestMethod.POST)
    public String indexpost(@RequestParam(required = false) Map<String, String> allParams) {
        //    save a new todo
        String title = allParams.get("title");
        String desc = allParams.get("desc");
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        LocalDateTime now = LocalDateTime.now();
        String date = dtf.format(now);
        System.out.println("Title : " + title + "\nDesc: " + desc);

        int id;
        if (repo.getMaxId()==null){
            id=1;
        }
        else {
            id=repo.getMaxId()+1;
        }
        System.out.println(repo.getMaxId());

        Todo newtodo = new Todo();
        newtodo.setTitle(title);
        newtodo.setDescription(desc);
        newtodo.setCdate(date);
        newtodo.setId(id);
        newtodo.setTstatus(false);

        repo.save(newtodo);


        return "redirect:/";
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteById(@PathVariable("id") int id) {

//        delete a todo by id
        System.out.println("id : " + id);

        Optional<Todo> doto = repo.findById(id);
        if (doto.isPresent()) {
            repo.deleteById(id);
            System.out.println("deleting data at id "+id);
        }
        else{
            System.out.println("data at id "+id +" not found");
        }

        return "redirect:/";
    }

    @RequestMapping(value = "/togglestatus/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String toggleStatusById(@PathVariable("id") int id) {

//        toggle the status of the todo if true set false and vice-varca

        System.out.println("id : " + id);

        Todo doto = repo.getById(id);
        if (doto.isTstatus()){
            doto.setTstatus(false);
        }
        else{
            doto.setTstatus(true);
        }
        repo.save(doto);


        return "hello";
    }


}
