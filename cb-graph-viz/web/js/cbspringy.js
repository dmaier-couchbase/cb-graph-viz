//Constructor
function CBGraphViz() {

    Springy.Graph.call(this);
}

//Extend the Springy Graph
CBGraphViz.prototype = new Springy.Graph();
CBGraphViz.prototype.constructor = CBGraphViz;

//Overrides


/**
 * Accepts an object with properties
 * 
 * @returns {undefined}
 */
CBGraphViz.prototype.addNodes = function () {
    
    // accepts variable number of arguments, where each argument
    // is a string that becomes both node identifier and label
    for (var i = 0; i < arguments.length; i++) {

        var arg = arguments[i];

        var name = "";
        var props = null;

        if (typeof arg == 'string')
            name = arg;
        else {
            name = arg.name;
            props = arg.props;
        }
        var node = new Springy.Node(name, {label: name, props: props});
        this.addNode(node);
    }
};