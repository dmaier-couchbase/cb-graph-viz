/*
 * Copyright 2015 Couchbase, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.couchbase.graph.viz;

import com.tinkerpop.blueprints.Direction;
import com.tinkerpop.blueprints.Edge;
import com.tinkerpop.blueprints.Vertex;
import java.io.IOException;
import javax.servlet.jsp.JspWriter;

/**
 *
 * @author David Maier <david.maier at couchbase.com>
 */
public class VizVertexBean {
    
    /**
     * The vertex to visualize
     */
    private Vertex vertex;

    /**
     * The output stream to use
     */
    private JspWriter out;
    

    public void setVertex(Vertex vertex) {
        this.vertex = vertex;
    }


    public Vertex getVertex() {
        return vertex;
    }

    public void setOut(JspWriter out) {
        this.out = out;
    }

    public JspWriter getOut() {
        return out;
    }
    
    
    /**
     * Draw a vertex and it's edges
     * 
     * @throws java.io.IOException
     */
    public void draw() throws IOException {
        
        if (vertex != null) {
                         
            out.println("graph.addNodes({ name:'" + vertex.getId()  + "'});");
            
            out.println("var label= $('#propsLabel').html('" + vertex.getId() + "');");
            
            StringBuilder sb = new StringBuilder();
            
            for ( String propKey : vertex.getPropertyKeys() ) {
                
                Object propVal = vertex.getProperty(propKey);
                
                sb.append(propKey).append(" = ").append(propVal).append("<br/>");
            }
            
            out.println("var view = $('#propsView').html('"+ sb.toString() + "');");
            
            //Get the incoming and outgoing edges of the vertex
            Iterable<Edge> edges = vertex.getEdges(Direction.BOTH);
                         
            for (Edge e : edges) {
                             
                String label = e.getLabel();         
                
                Vertex target = e.getVertex(Direction.IN);                
                          
                
                out.println("graph.addNodes('" + target.getId()  + "');");                            
                out.println("graph.addEdges(['" + vertex.getId() + "', '" + target.getId() + "', {color: '#00A0B0', label: '"+ label +"'}]);");
                         
                Vertex source = e.getVertex(Direction.OUT);
                             
                 out.println("graph.addNodes('" + source.getId()  + "');");                            
                 out.println("graph.addEdges(['" + source.getId() + "', '" + vertex.getId() + "', {color: '#00A0B0', label: '"+ label +"'}]);");
                         
            }
        }
        
    }
    
    
}
