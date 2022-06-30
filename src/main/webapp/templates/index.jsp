<%--
  Created by IntelliJ IDEA.
  User: TIRTHA
  Date: 24-06-2022
  Time: 10:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang='en'>

<head>
    <meta charset='UTF-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'>
    <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
    <script src="https://code.jquery.com/jquery-3.6.0.js"
            integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="../static/create.css">
    <link rel="stylesheet" href="../static/disp.css">
    <link rel="stylesheet" href="../static/style.css">
    <link rel="shortcut icon" href="../static/favicon.png" type="image/x-icon">
    <title>Todo App</title>
</head>

<body>
<div class="nav">
    <div class="nav-start">
        <img src="../static/favicon.png" alt="">
        <a href="/">TaskAssigner</a>
    </div>
    <div class="nav-mid">
        <a href="#">FAQ</a>
        <a href="#" class="tour">Tour</a>
        <a href="/">Dashboard</a>
    </div>
    <div class="nav-end">
        <a href="#">Cradits</a>
        <i class="fa fa-bell-o"></i>
        <button>Join</button>
    </div>
</div>
<div class="status">
    <div class="close"><i class="fa fa-qrcode"></i></div>
    <h2>Status</h2>
    <div class="t_status">
        <p class="t_val">${total}</p>
        <p class="t_name">Total Tasks</p>
    </div>
    <div class="t_status">
        <p class="t_val" id="tdue">${due}</p>
        <p class="t_name">Due Tasks</p>
    </div>
    <div class="t_status">
        <p class="t_val" id="tdone">${done}</p>
        <p class="t_name">Done</p>
    </div>
</div>
<div class="container">
    <div class="create">
        <div class="create-box" onclick="enableform(this)">
            <img src="../static/create.jpg" alt="">
            <h2><i class="fa fa-plus"></i>Create new Task</h2>
        </div>
        <form action="/" method="post" id="form">

            <div class="form-group">
                <span>Title</span>
                <input class="form-field" name="title" id="title" type="text" placeholder="My todo">
            </div>
            <div class="disp">
                <span>Description</span>
                <textarea class="form-field" name="desc" id="desc"
                          placeholder="Brief description of your todo"></textarea>
            </div>
            <div class="form-group">
                <button type="button" id="fsubmit">Add Todo</button>
            </div>
            <button type="submit" id="submit" display="none"></button>

        </form>
    </div>

    <div class="task-cards">
        <h2><i class="fa fa-get-pocket"></i> Tasks Bucket <br><span>- your Tasks appear here.</span></h2>

        <c:if test="${total == 0}">

            <div class="empty-box">
                <img src="../static/empty-box.png" alt="">
                <h2><i class="fa fa-glass"></i>No Task Created</h2>
            </div>
        </c:if>


        <c:forEach items="${datas}" var="data">

            <div class="card">
                <div class="left-block">
                    <p class="card-all">
                        <span>${data.title}</span> <br>
                        ${data.description}
                    </p>
                    <p class="card-date">Created on <span>${data.cdate}</span></p>
                </div>
                <div class="right-block">
                    <ul class="card-type">
                        <li>
                            <input id="s1" type="checkbox" class="switch" data-id="${data.id}" <c:out value="${data.tstatus eq false ? '': 'checked'}"/>>
                            <label for="s1" id="lable_s1" class="switch_label"></label>
                        </li>

                    </ul>

                    <a href="/delete/${data.id}" class="subbtn">Remove</a>
                </div>
            </div>

        </c:forEach>



    </div>

    <div class="confermation" id="conf">
        <div class="cbox">
            <p>Do you want to continue with these options?</p>
            <div class="btns">
                <button id="yes" onclick="conf('yes')">Yes</button>
                <Button id="no" onclick="conf('no')">No</Button>
            </div>
        </div>
    </div>

    <div class="popup" id="popup">
        <i class="fa fa-arrow-up close-popup" title="Close notification" onclick="close_popup()"></i>
        <i class="fa fa-bell-o icon-popup"></i>
        <p id="msg"></p>
    </div>


</div>
<footer>
    <h2>TaskAssigner</h2>
    <p>
        <i class="fa fa-code" style="color:sandybrown"></i>
        by @tirtharajSinha. Made with
        <i class="fa fa-heart" style="color:tomato"></i> <br>
        Build using <img src="../static/flask.png" alt="">
    </p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>

    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }

    $(document).ready(function () {
        $('.person').select2({
            placeholder: "Select a assignee",
            allowClear: true,
            tags: true,

        });
        $('.task').select2({
            placeholder: "Select a task for assignee",
            allowClear: true,
            tags: true,

        });

        let isperson = false;
        let istask = false;


        $('#desc').on("input", function () {
            if ($(this).val()) {
                istask = true;
                console.log("task selected")

            } else {
                istask = false;
            }
        })
        $('#title').on("input", function () {
            if ($(this).val()) {
                isperson = true;
                console.log("assignee selected")

            } else {
                isperson = false;

            }
        })
        $('#fsubmit').on("click", function () {
            if (isperson && istask) {
                console.log("both selected")
                checked();
            } else {
                create_popup("Title and Description field can't be empty.");
            }
        })


        function checked() {
            if (isperson && istask) {
                console.log("both selected")

                setTimeout(() => {
                    document.getElementById("conf").style.display = "flex"
                }, 1000);
            }
        }


    });

    function conf(state = "") {
        if (state == "yes") {
            setTimeout(() => {
                document.getElementById("submit").click();
            }, 1000);
        } else if (state == "no") {
            document.getElementById("conf").style.display = "none"
        }
    }

    checksbmitted();

    function checksbmitted() {
        var switchs = document.getElementsByClassName("switch");
        var lebels = document.getElementsByClassName("switch_label");
        for(var i=0;i<switchs.length;i++){
            if (switchs[i].checked) {
                lebels[i].innerHTML = "Done";
            } else {
                lebels[i].innerHTML = "Due";
            }
        }


    }

    // function liveCheck(element){
    //     if (element.checked) {
    //         lebels[index].innerHTML = "Done";
    //     } else {
    //         lebels[index].innerHTML = "Due";
    //     }
    // }
    $(".switch").bind("click", function(){
        var divs = $(".switch");
        var index = divs.index($(this));
        console.log("clicked")
        var lebels = document.getElementsByClassName("switch_label");
        var due=document.getElementById("tdue");
        var dueval=parseInt(due.innerHTML);
        var done=document.getElementById("tdone");
        var doneval=parseInt(done.innerHTML);
        if (this.checked) {
            lebels[index].innerHTML = "Done";
            doneval++;
            dueval--;
        } else {
            lebels[index].innerHTML = "Due";
            doneval--;
            dueval++;
        }
        due.innerHTML=dueval;
        done.innerHTML=doneval;
        var id=this.dataset.id;
        fetch('/togglestatus/'+id);

    });

    function create_popup(msg) {
        document.getElementById("msg").innerHTML = msg;
        document.getElementById("popup").style.transform = "translateY(0px)";
        console.log("opening popup");
    }

    function close_popup() {
        document.getElementById("msg").innerHTML = "";
        document.getElementById("popup").style.transform = "translateY(-500px)";
        console.log("closing popup");
    }

    function enableform(elem) {
        elem.style.display = "none";
        document.getElementById("form").style.display = "flex";
    }


</script>
</body>

</html>
