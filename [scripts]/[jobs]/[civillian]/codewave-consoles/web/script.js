let backgroundMusic;

/**
 * FIX #1: Reuse click audio (no new Audio() per click)
 */
const clickSound = new Audio('sounds/click.mp3');
clickSound.preload = 'auto';

function playClickSound() {
    try {
        clickSound.currentTime = 0;
        clickSound.play();
    } catch (e) {
        // Ignore autoplay/interaction restrictions or transient play errors
    }
}

/**
 * FIX #2: DocumentFragment + single append for list building
 * (reduces layout thrash while creating many items)
 */

/**
 * FIX #3: Reuse background music instance (don’t recreate each open)
 */
function playBackgroundMusic(volume) {
    if (!backgroundMusic) {
        backgroundMusic = new Audio('sounds/background.mp3');
        backgroundMusic.loop = true;
        backgroundMusic.preload = 'auto';
    }
    backgroundMusic.volume = volume;
    if (backgroundMusic.paused) {
        backgroundMusic.play().catch(() => {});
    }
}

function stopBackgroundMusic() {
    if (backgroundMusic) {
        backgroundMusic.pause();
        backgroundMusic.currentTime = 0;
        // keep instance for reuse (less churn); do NOT set to null
    }
}

window.addEventListener('message', function(event) {
    if (event.data.action == "openMenu") {
        document.body.style.display = "flex";
        document.getElementById('menu-container').style.display = "flex";
        document.getElementById('crafting-container').style.display = "none";
        document.getElementById('newui-container').style.display = "none";
        createMenu(event.data.items);
        if (event.data.playMusic) {
            playBackgroundMusic(event.data.volume);
        }
    } else if (event.data.action == "closeMenu") {
        document.getElementById('menu-container').style.display = "none";
        stopBackgroundMusic();
        if (document.getElementById('crafting-container').style.display === "none" &&
            document.getElementById('newui-container').style.display === "none") {
            document.body.style.display = "none";
        }
    } else if (event.data.action == "openCrafting") {
        document.body.style.display = "flex";
        document.getElementById('crafting-container').style.display = "flex";
        document.getElementById('menu-container').style.display = "none";
        document.getElementById('newui-container').style.display = "none";
        createCraftingMenu(event.data.recipes);
        if (event.data.playMusic) {
            playBackgroundMusic(event.data.volume);
        }
    } else if (event.data.action == "closeCrafting") {
        document.getElementById('crafting-container').style.display = "none";
        stopBackgroundMusic();
        if (document.getElementById('menu-container').style.display === "none" &&
            document.getElementById('newui-container').style.display === "none") {
            document.body.style.display = "none";
        }
    } else if (event.data.action == "openNewUI") {
        document.body.style.display = "flex";
        document.getElementById('newui-container').style.display = "flex";
        document.getElementById('menu-container').style.display = "none";
        document.getElementById('crafting-container').style.display = "none";
        createNewUIMenu(event.data.items);
        if (event.data.playMusic) {
            playBackgroundMusic(event.data.volume);
        }
    } else if (event.data.action == "closeNewUI") {
        document.getElementById('newui-container').style.display = "none";
        stopBackgroundMusic();
        if (document.getElementById('menu-container').style.display === "none" &&
            document.getElementById('crafting-container').style.display === "none") {
            document.body.style.display = "none";
        }
    } else if (event.data.action == "notify") {
        showNotification(event.data.message, event.data.type);
    }
});

function nuiPost(endpoint, data = {}) {
  if (typeof GetParentResourceName !== 'function') {
    console.warn(`nuiPost("${endpoint}") called outside NUI`);
    return Promise.resolve(null);
  }

  return fetch(`https://${GetParentResourceName()}/${endpoint}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json; charset=UTF-8' },
    body: JSON.stringify(data)
  })
  .then(async (res) => {
    // Try JSON first, fallback to text
    const text = await res.text();
    try { return JSON.parse(text); } catch { return text; }
  })
  .catch((err) => {
    console.error(`NUI fetch failed (${endpoint}):`, err);
    return null;
  });
}

document.getElementById('close-button').addEventListener('click', function() {
  nuiPost('close', {}).then((resp) => {
    if (resp === 'ok' || resp?.ok === true) {
      document.getElementById('menu-container').style.display = "none";
      stopBackgroundMusic();
      if (document.getElementById('crafting-container').style.display === "none" &&
          document.getElementById('newui-container').style.display === "none") {
        document.body.style.display = "none";
      }
    } else {
      // Optional: log unexpected response to diagnose callback side
      console.log('close response:', resp);
    }
  });
});
document.getElementById('close-crafting-button').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeCrafting`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({})
    }).then(resp => resp.json()).then(resp => {
        if (resp == 'ok') {
            document.getElementById('crafting-container').style.display = "none";
            stopBackgroundMusic();
            if (document.getElementById('menu-container').style.display === "none" &&
                document.getElementById('newui-container').style.display === "none") {
                document.body.style.display = "none";
            }
        }
    });
});

document.getElementById('close-newui-button').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/closeNewUI`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json; charset=UTF-8' },
        body: JSON.stringify({})
    })
    .then(resp => resp.json())
    .then(resp => {
        console.log("closeNewUI response:", resp); // Debug log
        if (resp == 'ok') {
            document.getElementById('newui-container').style.display = "none";
            stopBackgroundMusic();
            if (document.getElementById('menu-container').style.display === "none" &&
                document.getElementById('crafting-container').style.display === "none") {
                document.body.style.display = "none";
            }
        }
    })
    .catch(error => {
        console.error("Error closing new UI:", error);
    });
});

function createMenu(items) {
    const menu = document.getElementById('menu');
    menu.innerHTML = '';

    const frag = document.createDocumentFragment();

    items.forEach(item => {
        const menuItem = document.createElement('div');
        menuItem.className = 'menu-item';
        menuItem.id = item.id;

        const itemImg = document.createElement('img');
        itemImg.src = item.img;
        itemImg.alt = item.name;
        itemImg.loading = 'lazy';

        const itemName = document.createElement('span');
        itemName.innerText = item.name;

        const itemPrice = document.createElement('span');
        itemPrice.className = 'item-price';
        itemPrice.innerText = `$${item.price}`;

        const quantityInput = document.createElement('input');
        quantityInput.type = 'number';
        quantityInput.min = '1';
        quantityInput.value = '1';

        const purchaseButton = document.createElement('button');
        purchaseButton.innerText = 'Purchase';

        purchaseButton.addEventListener('click', function() {
            playClickSound();
            const quantity = quantityInput.value;
            console.log(`Purchasing ${quantity} of ${item.id}`);
            fetch(`https://${GetParentResourceName()}/purchase`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({ id: item.id, quantity: quantity })
            }).then(resp => resp.json()).then(resp => {
                console.log('Purchase response:', resp);
            });
        });

        menuItem.appendChild(itemImg);
        menuItem.appendChild(itemName);
        menuItem.appendChild(itemPrice);
        menuItem.appendChild(quantityInput);
        menuItem.appendChild(purchaseButton);

        frag.appendChild(menuItem);
    });

    menu.appendChild(frag);
}

function createCraftingMenu(recipes) {
    const craftingMenu = document.getElementById('crafting-menu');
    craftingMenu.innerHTML = '';

    const frag = document.createDocumentFragment();

    recipes.forEach(recipe => {
        const craftingItem = document.createElement('div');
        craftingItem.className = 'crafting-item';
        craftingItem.id = recipe.id;

        const itemImg = document.createElement('img');
        itemImg.src = recipe.img;
        itemImg.alt = recipe.name;
        itemImg.loading = 'lazy';

        const itemName = document.createElement('span');
        itemName.innerText = recipe.name.replace(/_/g, ' ');

        const requiredItems = document.createElement('div');
        requiredItems.className = 'required-items';
        recipe.requiredItems.forEach(item => {
            const itemDiv = document.createElement('div');
            itemDiv.innerText = `${item.quantity}x ${item.id.replace(/_/g, ' ')}`;
            requiredItems.appendChild(itemDiv);
        });

        const craftButton = document.createElement('button');
        craftButton.innerText = 'Craft';
        craftButton.addEventListener('click', function() {
            playClickSound();
            fetch(`https://${GetParentResourceName()}/craft`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({ id: recipe.id })
            }).then(resp => resp.json()).then(resp => {
                console.log('Crafting response:', resp);
            });
        });

        craftingItem.appendChild(itemImg);
        craftingItem.appendChild(itemName);
        craftingItem.appendChild(requiredItems);
        craftingItem.appendChild(craftButton);

        frag.appendChild(craftingItem);
    });

    craftingMenu.appendChild(frag);
}

function createNewUIMenu(items) {
    const newUIMenu = document.getElementById('newui-menu');
    newUIMenu.innerHTML = '';

    const frag = document.createDocumentFragment();

    items.forEach(item => {
        const uiItem = document.createElement('div');
        uiItem.className = 'crafting-item'; // reusing same styling as crafting items
        uiItem.id = item.id;

        const itemImg = document.createElement('img');
        itemImg.src = item.img;
        itemImg.alt = item.name;
        itemImg.loading = 'lazy';

        const itemName = document.createElement('span');
        itemName.innerText = item.name.replace(/_/g, ' ');

        const requiredItems = document.createElement('div');
        requiredItems.className = 'required-items';
        item.requiredItems.forEach(reqItem => {
            const itemDiv = document.createElement('div');
            itemDiv.innerText = `${reqItem.quantity}x ${reqItem.id.replace(/_/g, ' ')}`;
            requiredItems.appendChild(itemDiv);
        });

        const actionButton = document.createElement('button');
        actionButton.innerText = 'JailBreak Console';
        actionButton.addEventListener('click', function() {
            playClickSound();
            fetch(`https://${GetParentResourceName()}/newUIAction`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify({ id: item.id })
            }).then(resp => resp.json()).then(() => {});
        });

        uiItem.appendChild(itemImg);
        uiItem.appendChild(itemName);
        uiItem.appendChild(requiredItems);
        uiItem.appendChild(actionButton);

        frag.appendChild(uiItem);
    });

    newUIMenu.appendChild(frag);
}

function showNotification(message, type) {
    const notificationContainer = document.getElementById('notification-container');
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.classList.add(type);
    notification.innerText = message;
    notificationContainer.appendChild(notification);
    setTimeout(() => {
        notification.remove();
    }, 4000);
}

document.getElementById('more-info-button').addEventListener('click', function() {
    document.getElementById('info-container').style.display = 'flex';
    document.getElementById('crafting-container').style.display = 'none';
});

document.getElementById('close-info-button').addEventListener('click', function() {
    document.getElementById('info-container').style.display = 'none';
    document.getElementById('crafting-container').style.display = 'flex';
});

// Open the modal when the new button is clicked
document.getElementById('open-modal-button').addEventListener('click', function() {
    document.getElementById('modal-container').style.display = 'flex';
});

// Close the modal when the close icon is clicked
document.querySelector('.modal-close').addEventListener('click', function() {
    document.getElementById('modal-container').style.display = 'none';
});

// Optionally, close the modal if clicking outside the modal-content area
window.addEventListener('click', function(event) {
    const modal = document.getElementById('modal-container');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
});