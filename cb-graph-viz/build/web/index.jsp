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
                String startNode = request.getParameter("start_vertex");
                Graph graph = new CBGraph();

                if (startNode != null) {

                    VizVertexBean vizBean = new VizVertexBean(graph.getVertex(startNode), out);
                    vizBean.draw();

                } else {

                    DemoDataBean demoDataBean = new DemoDataBean();
                    demoDataBean.load(graph);
                }
                %>

                var springy = jQuery('#springydemo').springy({
                    graph: graph
                });

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
            
           
            <form id="myform" action="index.jsp" method="GET">
                <div class="form-group">
                    <label for="inputStartVertex">Start vertex</label>
                    <input type="text" class="form-control" name="start_vertex" id="inputStartVertex" placeholder="Please provide the id of a start vertex!">
                </div>

                <button type="submit" id="submitButton" class="btn btn-default">OK</button>
            </form>

            <div class="container">
                <div class="row">
                    <div class="col-sm-8">
                        <canvas id="springydemo" width="640" height="480"></canvas>
                    </div>
                    <div class="col-sm-4">
                        <div class="panel panel-default" style="margin: 30px">
                            <div class="panel-heading">JSON</div>
                            <div class="panel-body" id="propsPanel">
                                <div class="form-group">
                                    <label for="propsView" id="propsLabel"></label>
                                    <textarea class="form-control" rows="5" id="propsView"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>     
        </div>

    </body>
</html>
