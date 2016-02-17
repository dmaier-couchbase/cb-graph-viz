<%@page import="com.couchbase.graph.viz.DemoDataBean"%>
<%@page import="com.couchbase.graph.viz.VizVertexBean"%>
<%@page import="com.couchbase.client.java.error.DocumentAlreadyExistsException"%>
<%@page import="com.tinkerpop.blueprints.Edge"%>
<%@page import="com.tinkerpop.blueprints.Direction"%>
<%@page import="com.tinkerpop.blueprints.Vertex"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="com.couchbase.graph.CBGraph"%>
<%@page import="com.tinkerpop.blueprints.Graph"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<html>
    <head>
        <title>CB Graph Viz</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
        <script src="js/springy.js"></script>
        <script src="js/springyui.js"></script>
        <script src="js/bootstrap.min.js"></script>



        <script>

            jQuery(function () {

                //Basic JS code, suing Springy
                var graph = new Springy.Graph();
       

                //Mixed in Java code 
                <%
                String id = request.getParameter("id");
                String age = request.getParameter("age");
                String to = request.getParameter("to");
                String label = request.getParameter("label");
                
                Graph graph = new CBGraph();

                if (id != null && age != null && to != null && label != null) {

                    Vertex newV = graph.addVertex(id);
                    
                    if (newV != null) {
                        
                        newV.setProperty("age", age);
                 
                        Vertex toV = graph.getVertex(to);
                        
                        if (toV != null) {
                            
                            graph.addEdge(null,newV ,toV, label);
                            
                            out.println("alert('Successfully created the vertex')");
                        }
                    }
                }
                %>
           });
        </script>


        <div class="container">

            <div style="margin: 30px" id="header">
                <a href = "index.jsp"><img src="images/cb.png" height="30px" alt="CB Graph Viz"/></a>
                <font size = "4" style="margin: 10px">GraphViz Demo</font>
                <div style="margin: 30px">
                    <a style="margin-left: 20px" href="index.jsp">Browse</a>
                    <a style="margin-left: 20px" href="add.jsp">Add</a>
                </div>
            </div>
            
           
            <form id="myform" action="add.jsp" method="GET">
                <div class="form-group">
                    <label for="id">Id</label>
                    <input type="text" class="form-control" name="id" id="id" placeholder="">
                    <label for="age">Age</label>
                    <input type="text" class="form-control" name="age" id="age" placeholder="">
                    <label for="to">To</label>
                    <input type="text" class="form-control" name="to" id="to" placeholder="">
                    <label for="label">Label</label>
                    <input type="text" class="form-control" name="label" id="label" placeholder="">
                </div>

                <button type="submit" id="submitButton" class="btn btn-default">OK</button>
            </form>

        </div>

    </body>
</html>
