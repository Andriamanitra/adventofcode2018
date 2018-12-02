// Part 1
input = document.body.innerText.split("\n");
input.map(w => {
    let charCount = {}, twos = 0, threes = 0;
    for (let c of w) {
        charCount[c] ? charCount[c] += 1 : charCount[c] = 1
    }
    for (let k in charCount) {
        if (charCount[k] === 2) twos = 1;
        if (charCount[k] === 3) threes = 1;
    }
    return [twos, threes];
}).reduce((a, b) => [a[0]+b[0], a[1]+b[1]], [0, 0])
.reduce((a, b) => a*b)

// Part 2
function diff1 (a, b) {
    var diff = 0, commonPart = "";
    for (var i = 0; i < a.length; i++) {
        if (a[i] !== b[i]) diff += 1
        else commonPart += a[i];
        if (diff > 1) return
    }
    if (diff === 1) console.log(commonPart)
}
for (var i = 0; i < input.length; i++) {
    for (var j = i; j < input.length; j++) {
        diff1(input[i], input[j])
    }
}