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
             
            //Basic JS code, suing Springy
            var graph = new Springy.Graph(); 
            
            function resubmit(vId) {
                
                var input = document.getElementById("inputStartVertex");
                input.value = vId;
                
                var button = document.getElementById("submitButton");
               button.click();
                
            } 
            
            
            //Mixed in Java code 
            <%
                 String startNode = request.getParameter("start_vertex");
              
                 Graph graph = new CBGraph();
                 
                 
                 
                 
                 if (startNode != null) {
                        
                     Vertex v = graph.getVertex(startNode);
                     
                     if (v != null) {
                         
                         out.println("graph.addNodes('" + v.getId() + "');");
                         
                         Iterable<Edge> edges = v.getEdges(Direction.BOTH);
                         
                         for (Edge e : edges) {
                             
                             String label = e.getLabel();
                             
                             Vertex v2 = e.getVertex(Direction.IN);
                            
                             out.println("graph.addNodes('" + v2.getId()  + "');");                            
                             out.println("graph.addEdges(['" + v.getId() + "', '" + v2.getId() + "', {color: '#00A0B0', label: '"+ label +"'}]);");
                         
                             Vertex v3 = e.getVertex(Direction.OUT);
                             
                             out.println("graph.addNodes('" + v3.getId()  + "');");                            
                             out.println("graph.addEdges(['" + v3.getId() + "', '" + v.getId() + "', {color: '#00A0B0', label: '"+ label +"'}]);");
                         
                         }
                     }
                 
                 }
                 else {
                     
                     try {
                     
                        Vertex v_bart = graph.addVertex("bart");
                        v_bart.setProperty("age", 10);        
                        
                        Vertex v_march = graph.addVertex("march");
                        v_march.setProperty("age", 45);
                        
                        Vertex v_homer = graph.addVertex("homer");
                        v_march.setProperty("age", 47);
                        
                        Vertex v_lisa = graph.addVertex("lisa");
                        v_march.setProperty("age", 8);
                        
                        Edge e_1 = graph.addEdge(null, v_bart, v_homer, "son of");
                        Edge e_2 = graph.addEdge(null, v_bart, v_march, "son of");
                        Edge e_3 = graph.addEdge(null, v_bart, v_lisa, "brother of");
                        Edge e_4 = graph.addEdge(null, v_lisa, v_bart, "sister of");
                        Edge e_5 = graph.addEdge(null, v_march, v_lisa, "mother_of");
                        
                     } catch (DocumentAlreadyExistsException e) {
                         
                         //Ignore it 
                     }
                 }
            %>
    
            
            jQuery(function () {
                var springy = jQuery('#springydemo').springy({
                    graph: graph
                });
            });
        </script>

        
        <div class="container">
            
             <div style="margin: 30px" id="header">
                <a href = "index.jsp"><img src="images/cb.png" height="30px" alt="CB Graph Viz"/></a>
                <font size = "4" style="margin: 10px">GraphViz Demo</font>
             </div>
            
            
            <form id="myform" action="index.jsp" method="GET">
                <div class="form-group">
                    <label for="inputStartVertex">Start vertex</label>
                    <input type="text" class="form-control" name="start_vertex" id="inputStartVertex" placeholder="Please provide the id of a start vertex!">
                </div>

                <button type="submit" id="submitButton" class="btn btn-default">OK</button>
            </form>

            
            <canvas id="springydemo" width="640" height="480"></canvas>
        </div>
        
    </body>
</html>
