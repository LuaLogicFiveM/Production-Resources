const screen = document.querySelector(".screen");

function setDisplayText(text) {
    screen.innerHTML = "";

    const textElement = document.createElement("p");
    textElement.classList.add("text");
    textElement.innerText = text;

    screen.appendChild(textElement);
}

function setDisplayValue(value) {
    const stateElement = screen.querySelector(".state");
    if(stateElement) {
        stateElement.classList.toggle("fill", value.value);

        const textEleemnt = screen.querySelector(".text");
        textEleemnt.innerText = value.text;
    } else {
        setDisplayText(value.text);

        const stateElement = document.createElement("div");
        stateElement.classList.add("state");
        stateElement.classList.toggle("fill", value.value);

        screen.appendChild(stateElement);
    }
}

function setProgressVisible(visible) {
    screen.innerHTML = "";
    if(visible) {
        const progressElement = document.createElement("div");
        progressElement.classList.add("progbar");

        const bar = document.createElement("div");
        bar.id = "bar";

        progressElement.appendChild(bar);
        screen.appendChild(progressElement);
    }
}

function setProgressValue(value) {
    const bar = screen.querySelector("#bar");

    if(bar) {
        bar.style.setProperty("--progress", value);
    }
}

window.addEventListener("message", e => {
    const item = e.data;

    if(item.event === "setDisplayText") {
        setDisplayText(item.payload);
    } else if(item.event === "setDisplayValue") {
        setDisplayValue(item.payload);
    } else if(item.event === "setProgressVisible") {
        setProgressVisible(item.payload);
    } else if(item.event === "setProgressValue") {
        setProgressValue(item.payload);
    }
})

document.addEventListener("DOMContentLoaded", () => {
    try {
        fetch(`https://prp-electricaljob/prp-electricaljob:duiLoaded`, {method: "POST", body: "{}"});
    } catch(e){}
});
