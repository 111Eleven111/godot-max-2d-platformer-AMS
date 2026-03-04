// lets
inlets = 1;
outlets = 1;

// global variables
// ...       1  2  3  4  5  6  7  8
var drum_pitches = [];

// functions
function randomMinor() {
    var result = [];
    var randomIndex = 0; // Return a random integer from 0 to 10 (both included):

    for (var i = 0; i < arguments.length; i++) {
        randomIndex = Math.floor(Math.random() * minor.length);
        randomPitch = minor[randomIndex];
        result.push(arguments[i] + randomPitch);
    }
    outlet(0, result);
}

function randomMinor2() {
    var result = [];
    var randomIndex = 0; // Return a random integer from 0 to 10 (both included):

    for (var i = 0; i < arguments.length; i++) {
        randomIndex = Math.floor(Math.random() * minor2.length);
        randomPitch = minor2[randomIndex];
        result.push(arguments[i] + randomPitch);
    }
    outlet(0, result);
}

function randomVelocities() {
    var result = [];
    // Read arguments and randomly set velocity to be either 0 or 127
    for (var i = 0; i < arguments.length; i++) {
        if (Math.random() < 0.5) {
            result.push(0);
        } else {
            result.push(127);
        }
    }
    outlet(0, result);
}

function someVelocities() {
    var result = [];
    // Read arguments and set every forth index tp 127 with a 50/50 chanse, others to 0
    for (var i = 0; i < arguments.length; i++) {
        if (i % 4 === 0) {
            result.push(Math.random() < 0.5 ? 127 : 0);
        } else {
            result.push(0);
        }
    }
    outlet(0, result);
}
