// in- and outlets
inlets = 1;
outlets = 1;

function bang() {
    var result = [];
    
    for (var i = 0; i < 16; i++) {
        result.push(Math.random()*10 + 30)
    }

    outlet(0, result)
}