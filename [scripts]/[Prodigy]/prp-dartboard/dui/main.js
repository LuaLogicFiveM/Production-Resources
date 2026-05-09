function initDartboard(players) {
    // Set Names
    document.getElementById('playerOneName').innerText = players["1"].name;
    document.getElementById('playerTwoName').innerText = players["2"].name;
    
    // Starting Scores
    if (players["1"].skipScore) { return; };
    document.getElementById('playerOneScores').innerHTML = `<div class="score">${players["1"].points}</div>`;
    document.getElementById('playerTwoScores').innerHTML = `<div class="score">${players["2"].points}</div>`;
}

function setScore(data) {
    const player = data.player
    if (!player) { console.log("Player Invalid"); return false; }

    const newAmount = data.score
    if (!newAmount) { console.log("New Score Invalid"); return false; }

    const scoreDiv = document.createElement('div');
    scoreDiv.className = 'score';
    scoreDiv.innerText = newAmount;
    if (player === 1) {
        document.getElementById('playerOneScores').appendChild(scoreDiv);
    } else {
        document.getElementById('playerTwoScores').appendChild(scoreDiv);
    };
}

window.addEventListener("message", e => {
    const item = e.data;
    if(item.event === "startGame") {
        initDartboard(item.payload[0]);
    } else if(item.event === "setScore") {
        setScore(item.payload);
    };
})

document.addEventListener("DOMContentLoaded", () => {
    try {
        fetch(`https://prp-dartboard/prp-dartboard:duiLoaded`, {method: "POST", body: "{}"});
    } catch(e){}
});


// Initialize with default players
// const players = [
//     { name: "Spayce", score: 0 },
//     { name: "Jordan", score: 0 }
// ];
// initDartboard(players);