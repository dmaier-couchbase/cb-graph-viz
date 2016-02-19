function onNodeSelected(node) {

    if (node && node.data) {

        var input = $("#inputStartVertex");

        var id = node.id;

        console.log("Setting new input value " + id)
        input.val(id);

        var button = $("#submitButton");
        button.click();
    }
}
