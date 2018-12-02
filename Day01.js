// Part 1:
eval(document.body.innerText)

// Part 2:
// Note that this would NOT work if the input could contain 0
for(let [sums, s, input] = [{0:1}, 0, document.body.innerText.split("\n").map(Number)];;) {
    s = input.reduce((a, b) => { if (sums[a+b]) throw a+b; sums[a] = 1; return a+b }, s)
}
