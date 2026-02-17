var beep = new Audio("beep.wav")

window.addEventListener('message', (event) => {
    if (event.data.event == "playSound") {
        beep.play()
    }
})
