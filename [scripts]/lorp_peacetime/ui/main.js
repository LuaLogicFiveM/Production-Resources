window.addEventListener('message', (event) => {
    const data = event.data;
    const started = document.getElementById('started');
    const ended = document.getElementById('ended');

    if (data && data.action === 'isPeaceTimeOn') {
        if (data.status === true) {
            started.style.display = 'flex';
            ended.style.display = 'none';
        } else {
            started.style.display = 'none';
            ended.style.display = 'flex';

            setTimeout(() => {
                ended.style.display = 'none';
            }, 3500); // If you want the banner go away instantly then you can just change the timeout here i reccomend leaving it like this ngl
        }
    }
});
