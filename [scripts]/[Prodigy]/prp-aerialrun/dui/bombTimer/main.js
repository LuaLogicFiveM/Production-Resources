const screen = document.querySelector(".screen");
let timer = 0;

document.addEventListener("DOMContentLoaded", () => {
    const text = screen.querySelector(".text");
    if (text) {
        resizeTextToFit(text);
    }

    // try {
    //     const id = new URLSearchParams(window.location.search).get("id");
    //     fetch(`https://prp-heists/object:duiLoaded`, {method: "POST", body: JSON.stringify({id}), headers: {"Content-Type": "application/json"}});
    // } catch(e){}
});

function resizeTextToFit(text) {
    const wrapper = text.parentElement;
    const code = text;

    const wrapperWidth = wrapper.clientWidth;
    const wrapperHeight = wrapper.clientHeight;

    const codeWidth = code.clientWidth + 50;
    const codeHeight = code.clientHeight;

    let scale = Math.min(
        1,
        wrapperWidth / codeWidth,
        wrapperHeight / codeHeight,
    );
    scale -= 0.1 * scale;
    code.style.fontSize = `${scale}em`;
}

function removeTimer() {
    if (timer) {
        clearTimeout(timer);
        timer = 0;

        screen.querySelectorAll(".segment").forEach((s) => s.remove());
    }
}

function setTimer(targetTimestamp) {
    removeTimer();
    screen.innerHTML = "";

    const segment = document.createElement("div");
    segment.classList.add("segment");
    screen.appendChild(segment);
    const span = document.createElement("span");
    span.classList.add("timer");
    span.innerHTML = "&nbsp;";
    segment.appendChild(span);

    function refresh() {
        let sec = Math.max(
            0,
            Math.floor((targetTimestamp - Date.now()) / 1000),
        );
        const min = Math.floor(sec / 60);
        sec = sec % 60;

        span.textContent = `${min.toString().padStart(2, "0")}:${sec.toString().padStart(2, "0")}`;
    }

    timer = setInterval(refresh, 500);
    refresh();
}

window.addEventListener("message", (e) => {
    const item = e.detail || e.data;

    if (item.event === "setScreenText") {
        removeTimer();

        screen.innerHTML = "";
        const text = document.createElement("div");
        text.classList.add("text");
        text.textContent = item.payload;
        screen.appendChild(text);

        return;
    }

    if (item.event === "setScreenColor") {
        screen.classList.remove("green", "red");
        if (item.payload) {
            screen.classList.add(item.payload);
        }
        return;
    }

    if (item.event === "setTimer") {
        setTimer(item.payload);
    }
});
