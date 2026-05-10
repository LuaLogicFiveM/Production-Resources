let countdownInterval = null;

window.addEventListener('message', function(event) {
    if (event.data.type === 'showCountdown') {
        // Start visual countdown with total time
        startCountdown(event.data.totalTime);
    } else if (event.data.type === 'hideCountdown') {
        // Force hide countdown (for cancellation)
        hideCountdown();
    }

    if (event.data.type === 'notification') {
        showNotification(event.data.message, event.data.notificationType);
    }
});

function startCountdown(totalSeconds) {
    // Clear any existing countdown
    if (countdownInterval) {
        clearInterval(countdownInterval);
    }

    let remainingTime = totalSeconds;

    // Show countdown container
    const countdownContainer = document.getElementById('countdown-container');
    countdownContainer.style.display = 'block';
    setTimeout(() => {
        countdownContainer.classList.add('show');
    }, 10);

    // Update display immediately
    updateCountdownDisplay(remainingTime);

    // Start countdown interval
    countdownInterval = setInterval(() => {
        remainingTime--;

        if (remainingTime <= 0) {
            // Countdown finished, hide automatically
            hideCountdown();
        } else {
            // Update display
            updateCountdownDisplay(remainingTime);
        }
    }, 1000);
}

function updateCountdownDisplay(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    const formattedTime = `${mins}:${secs.toString().padStart(2, '0')}`;
    document.getElementById('countdown-time').innerText = formattedTime;
}

function hideCountdown() {
    // Clear countdown interval
    if (countdownInterval) {
        clearInterval(countdownInterval);
        countdownInterval = null;
    }

    // Hide countdown container
    const countdownContainer = document.getElementById('countdown-container');
    countdownContainer.classList.remove('show');
    setTimeout(() => {
        countdownContainer.style.display = 'none';
    }, 500);
}

function showNotification(message, type) {
    const notificationContainer = document.getElementById('notification-container');

    const notification = document.createElement('div');
    notification.classList.add('notification', `notification-${type}`);

    const iconContainer = document.createElement('div');
    iconContainer.classList.add('icon-container');
    const icon = document.createElement('img');
    icon.classList.add('icon');
    icon.src = type === 'success' ? 'nui://grp_aidoc/ui/img/tick.png' : 'nui://grp_aidoc/ui/img/cross.png';
    icon.alt = type === 'success' ? 'Success Icon' : 'Error Icon';
    iconContainer.appendChild(icon);
    notification.appendChild(iconContainer);

    const text = document.createElement('div');
    text.classList.add('notification-text');

    const amountMatch = /\$\d+/;
    const formattedMessage = message.replace(amountMatch, (match) => `<span class="amount-${type}">${match}</span>`);

    const arrivalTimeMatch = /\d+\sseconds/;
    const finalFormattedMessage = formattedMessage.replace(arrivalTimeMatch, (match) => `<span class="arrival-time-${type}">${match}</span>`);

    text.innerHTML = `
        <div class="notification-title">${type === 'success' ? 'SUCCESS' : 'ERROR'}</div>
        <div class="notification-description">${finalFormattedMessage}</div>
    `;
    notification.appendChild(text);

    const badge = document.createElement('div');
    badge.classList.add('notification-badge', `badge-${type}`);
    badge.innerText = 'EMS';
    notification.appendChild(badge);

    const progressBar = document.createElement('div');
    progressBar.classList.add('notification-progress');
    const progressBarFill = document.createElement('div');
    progressBarFill.classList.add('notification-progress-fill');
    progressBar.appendChild(progressBarFill);
    notification.appendChild(progressBar);

    notificationContainer.appendChild(notification);

    setTimeout(function() {
        notification.style.opacity = '1';
        notification.style.transform = 'translateX(0)';
        progressBarFill.style.width = '100%';
    }, 10);

    setTimeout(function() {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(100%)';
        setTimeout(function() {
            notificationContainer.removeChild(notification);
        }, 500);
    }, 3000);
}
