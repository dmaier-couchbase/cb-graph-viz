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

import com.tinkerpop.blueprints.Graph;
import com.tinkerpop.blueprints.Vertex;

/**
 *
 * @author David Maier <david.maier at couchbase.com>
 */
public class AddVertexBean {

    private Graph graph;

    private String id;
    private String age;
    private String to;
    private String label;

    public Graph getGraph() {
        return graph;
    }

    public void setGraph(Graph graph) {
        this.graph = graph;
    }

    public String getId() {
        return id;
    }

    public String getAge() {
        return age;
    }

    public String getTo() {
        return to;
    }

    public String getLabel() {
        return label;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public boolean add() {

        try {

            Vertex newV = graph.addVertex(id);

            if (newV != null) {

                newV.setProperty("age", age);

                Vertex toV = graph.getVertex(to);

                if (toV != null) {

                    graph.addEdge(null, newV, toV, label);

                    return true;
                }
            }

        } catch (Exception e) {

            //Ignore
        }

        return false;
    }

}
