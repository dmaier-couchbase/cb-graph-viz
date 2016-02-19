/*
 * Copyright 2016 Couchbase, Inc.
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

import com.couchbase.client.java.error.DocumentAlreadyExistsException;
import com.tinkerpop.blueprints.Edge;
import com.tinkerpop.blueprints.Graph;
import com.tinkerpop.blueprints.Vertex;

/**
 * 
 * Bean to load the demo data
 * 
 * @author David Maier <david.maier at couchbase.com>
 */
public class DemoDataBean {

    private Graph graph; 
    
    public Graph getGraph() {
        return graph;
    }

    public void setGraph(Graph graph) {
        this.graph = graph;
    }
    
    public void load() {

        try {

            Vertex v_bart = graph.addVertex("bart");
            v_bart.setProperty("age", 10);
            v_bart.setProperty("city", "Springfield");
            
            Vertex v_marge = graph.addVertex("marge");
            v_marge.setProperty("age", 45);

            Vertex v_homer = graph.addVertex("homer");
            v_homer.setProperty("age", 47);

            Vertex v_lisa = graph.addVertex("lisa");
            v_lisa.setProperty("age", 8);

            Edge e_1 = graph.addEdge(null, v_bart, v_homer, "son of");
            Edge e_2 = graph.addEdge(null, v_bart, v_marge, "son of");
            Edge e_3 = graph.addEdge(null, v_bart, v_lisa, "brother of");
            Edge e_4 = graph.addEdge(null, v_lisa, v_bart, "sister of");
            Edge e_5 = graph.addEdge(null, v_marge, v_lisa, "mother_of");

        } catch (DocumentAlreadyExistsException e) {

            //Ignore it 
        }
    }

}
