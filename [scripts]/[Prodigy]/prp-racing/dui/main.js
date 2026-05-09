const dist = document.querySelector("#dist");
const line = document.querySelector(".line");

document.addEventListener("DOMContentLoaded", () => {
    try {
        fetch(`https://prp-racing/prp-racing:duiLoaded`, {method: "POST", body: "{}"});
    } catch(e){}
});

window.addEventListener("message", e => {
    const item = e.data;

    if(item.event === "setDist") {
        dist.innerText = item.payload;
    }

    if(item.event === "setActive") {
        if(item.payload) {
            line.classList.add("green");
        } else {
            line.classList.remove("green");
        }
    }
})
