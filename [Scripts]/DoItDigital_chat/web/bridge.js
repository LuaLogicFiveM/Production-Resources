var _debug = false;
var SelectedFont = "Roboto";
var pushFonts = true;
window.chatcommands = window.chatcommands || [];
var scriptAlreadyExists = false;
(function cleanDuplicateScripts() {
    const seen = new Set();
    const scripts = document.querySelectorAll('script[src]');
    
    scripts.forEach(script => {
      const src = script.getAttribute('src');
      if (seen.has(src)) {
        script.parentNode.removeChild(script); 
        scriptAlreadyExists = true;
      } else {
        seen.add(src); 
      }
    });
    
  })();

(function () {
    if (scriptAlreadyExists) {
        return;
      }
    window.addEventListener('message', (event) => {
        const data = event.data;
        if (data.type === 'ON_MESSAGE' && data.message?.args?.[0]) {
            const msg = data.message.args[0];
            const parts = msg.split(' ');
            const command = parts[0];

            switch (command) {
                case "upuis1293": {
                    const selector = parts[1];
                    const cssProps = parts.slice(2);

                    const cssObj = {};
                    cssProps.forEach(prop => {
                        const [key, value] = prop.split(':');
                        if (key && value) {
                            cssObj[key.trim()] = value.trim();
                        }
                    });

                    const el = document.querySelector(selector);
                    if (el) {
                        Object.entries(cssObj).forEach(([key, value]) => {
                            el.style.setProperty(key, value);
                        });
                        if (_debug === true) {
                            console.log(`[CSS] Applied styles to ${selector}`, cssObj);
                        }
                    } else if (_debug === true) {
                        console.warn(`[CSS] Selector not found: ${selector}`);
                    }
                    break;
                }

                case "upuis1294": {
                    const theme = parts[1];
                    const el = document.querySelector("#app");
                    if (el) {
                        for (let i = 1; i <= 9; i++) {
                            el.classList.remove(`theme${i}`);
                        }
                        el.classList.add(theme);
                        if (_debug === true) {
                            console.log(`[CSS] Changed theme to ${theme}`);
                        }
                    } else if (_debug === true) {
                        console.warn(`[CSS] Selector not found: #app`);
                    }
                    break;
                }

                case "upuis1295": {
                    pushFonts = false;
                    const font = parts.slice(1).join(' '); 
                    const elements = document.querySelectorAll("#app, .chat-text, .chat-category, .chat-sender");

                    elements.forEach(el => {
                        if (el) {
                            el.style.fontFamily = `'${font}'`;
                            el.style.setProperty('font-family', `'${font}'`, 'important');
                        } else {
                            pushFonts = true;
                        }
                    });
                        // Check if the style tag already exists
    let style = document.getElementById('dynamic-font-style');
    if (!style) {
        style = document.createElement('style');
        style.id = 'dynamic-font-style';
        document.head.appendChild(style);
    }

// Only apply font to specific elements inside #app
style.innerHTML = `
  #app .chat-text,
  #app .chat-sender,
  #app .chat-category {
    font-family: '${font}' !important;
  }
`;

                    SelectedFont = font;
                    if (_debug === true) {
                        console.log(`[CSS] Changed font to ${font}`);
                    }
                    break;
                }
                case "upuiscategories": {
                    const categories = parts.slice(1);
                    categories.forEach(category => {
                        if (category && !window.chatcommands.includes(category)) {
                            window.chatcommands.push(category);
                        }
                    });
                    
                    break;
                }

                default: {
                    if (_debug === true) {
                        console.warn(`[CSS] Unknown command: ${command}`);
                    }
                    break;
                }
            }

            if (pushFonts) {
                pushFonts = false;
                const elements = document.querySelectorAll("#app, .chat-text, .chat-category, .chat-sender");

                elements.forEach(el => {
                    if (el) {
                        el.style.fontFamily = `'${SelectedFont}'`;
                    } else {
                        pushFonts = true;
                    }
                });
            }
        }
    });
})();



(function addTabKeyListener() {
    if (scriptAlreadyExists) {
        return;
      }
    const chatInput = document.querySelector('.chat-input');
    const textarea = chatInput?.querySelector('textarea');
    
    let currentCommandIndex = 0;
    
    const emojiList = [
        '😀','😂','😎','😍','😡','👍','🔥','💀','🎉',
        '🚔','🚨','👮‍♂️','🕵️‍♂️','🚓','🔫','💣','🧨','🦺',
        '🚑','🩺','🏥','💉','💊','🆘','📟','📞','📢',
        '💼','💵','💰','📦','🏪','🏢','🛒','🧰','🔧',
        '🔒','🔓','🛠️','🪓','🧲','🗝️','🚪','🔑','📍','📌',
        '📷','🎥','📺','🎮','🕹️','🎯','🎲','🎰','🎵','🎧',
        '🧑‍⚖️','⚖️','📜','✍️','📝','📂','📁','📊','📋','📌',
        '🚬','🍺','🍻','🥃','🍔','🌮','🍩','🍕','🥡','🥪',
        '😴','💤','👀','🤝','🙌','🤙','💪','🙏','🤬','🥵',
        '😈','👑','👊','🧠','🧃','📅','🕒','🔊','🔇','🔔',
        '🛑','🚷','🚫','⛔','❗','⚠️','✅','❌','🔁','🔄'
      ];
    let emojiPicker;
    let emojiIndex = 0;
    let pickerOpen = false;
    let isListenerAdded = false;
    
    // Create emoji picker if not exists
    let emojiPickerCreated = false; // This variable tracks if the emoji picker has been created

    function createEmojiPicker() {
        // If emoji picker exists, remove it first to avoid duplicates or errors
        const existingPicker = document.getElementById('emoji-picker');
        if (existingPicker) {
          existingPicker.remove();  // Remove the old picker
        }
      
        // Create the emoji picker container
        emojiPicker = document.createElement('div');
        emojiPicker.id = 'emoji-picker';
        emojiPicker.style.cssText = `
        position: absolute;
        bottom: 50px;
        left: 10px;
        background: #222;
        padding: 6px 10px;
        border-radius: 6px;
        display: none;
        flex-wrap: wrap;
        width: 320px;               /* 60% wider */
        gap: 4px;
        font-size: 18px;
        z-index: 9999;
        color: white;
        flex-direction: column;
      `;
      
        // Create and add the title to the picker
        const title = document.createElement('div');
        title.textContent = 'Use ← → to navigate';
        title.style.cssText = `
          font-size: 12px;
          color: #aaa;
          margin-bottom: 8px;
          text-align: center;
        `;
        emojiPicker.appendChild(title);
      
        // Create container for emojis
        const emojiContainer = document.createElement('div');
        emojiContainer.style.cssText = `
        display: flex;
        flex-wrap: wrap;
        gap: 4px;
        justify-content: flex-start;
      `;
      
        // Add each emoji to the container
        emojiList.forEach((emoji) => {
          const span = document.createElement('span');
          span.textContent = emoji;
          span.style.cssText = `
          cursor: pointer;
          padding: 4px;
          border-radius: 4px;
          width: 28px;
          height: 28px;
          text-align: center;
          line-height: 28px;
          box-sizing: border-box;
        `;
      
          // Only add event listener if it's not already added (check data attribute)
          if (!span.dataset.listenerAdded) {
            span.addEventListener('click', function() {
              insertEmojiAtCursor(emoji);
              toggleEmojiPicker(false); // Close the picker after selecting an emoji
            });
            
            // Mark the emoji as having the event listener added
            span.dataset.listenerAdded = 'true';
          }
      
          emojiContainer.appendChild(span);
        });
      
        // Append the emoji container to the emoji picker
        emojiPicker.appendChild(emojiContainer);
      
        // Append the emoji picker to the chat input div
        chatInput.appendChild(emojiPicker);
      }
      
    
    
    function highlightEmoji(index) {
      const spans = emojiPicker.querySelectorAll('span');
      spans.forEach((el, i) => {
        el.style.background = i === index ? '#444' : 'transparent';
      });
    }
    
    function insertEmojiAtCursor(emoji) {
        const start = textarea.selectionStart;
        const end = textarea.selectionEnd;
        const value = textarea.value;
      
        textarea.value = value.slice(0, start) + emoji + value.slice(end);
        textarea.setSelectionRange(start + emoji.length, start + emoji.length);
        textarea.focus();
      
        // 👇 This line tells the system "hey, user typed something"
        textarea.dispatchEvent(new Event('input', { bubbles: true }));
      }
      
    
    function toggleEmojiPicker(open = !pickerOpen) {
      pickerOpen = open;
      emojiPicker.style.display = pickerOpen ? 'flex' : 'none';
      emojiIndex = 0;
      if (pickerOpen) highlightEmoji(emojiIndex);
    }
    
    // Emoji hint
    function createEmojiHint() {
        if (document.getElementById('emoji-hint')) return;
      
        const hint = document.createElement('div');
        hint.id = 'emoji-hint';
        hint.textContent = '💡 [Alt] = Emojis / [Tab] = Switch Channels';
        hint.style.cssText = `
          color: #f2ebeb;
          font-size: 12px;
          margin-top: 5px;
          user-select: none;
          opacity: 0.9;
          display: none;
        `;
      
        chatInput.appendChild(hint);
      }

    
    
    // Combined key handler
    function handleKeydown(e) {
      if (e.altKey && !pickerOpen) {
        e.preventDefault();
        toggleEmojiPicker(true);
        return;
      }
    
      if (pickerOpen) {
        switch (e.key) {
          case 'ArrowRight':
            e.preventDefault();
            emojiIndex = (emojiIndex + 1) % emojiList.length;
            highlightEmoji(emojiIndex);
            break;
          case 'ArrowLeft':
            e.preventDefault();
            emojiIndex = (emojiIndex - 1 + emojiList.length) % emojiList.length;
            highlightEmoji(emojiIndex);
            break;
          case 'Enter':
            e.preventDefault();
            insertEmojiAtCursor(emojiList[emojiIndex]);
            toggleEmojiPicker(false);
            break;
          case 'Escape':
            e.preventDefault();
            toggleEmojiPicker(false);
            break;
        }
        return;
      }
    
      if (e.key === 'Tab') {
        e.preventDefault();
        const currentText = textarea.value.trim();
        const words = currentText.split(/\s+/);
        const firstWord = words[0];
    
        const nextCommand = `/${window.chatcommands[currentCommandIndex].toLowerCase()}`;
    
        if (firstWord.startsWith('/')) {
          words[0] = nextCommand;
        } else {
          words.unshift(nextCommand);
        }
    
        textarea.value = words.join(' ');
        currentCommandIndex = (currentCommandIndex + 1) % window.chatcommands.length;
        textarea.dispatchEvent(new Event('input', { bubbles: true }));
      }
    }
    
    // Initialize everything
    if (chatInput && textarea && !isListenerAdded) {
      createEmojiPicker();
      createEmojiHint();
      document.removeEventListener('keydown', handleKeydown); // Remove previous listener (if any)
      document.addEventListener('keydown', handleKeydown);    // Add the listener again
      isListenerAdded = true;
    }

    const hintElement = document.getElementById('emoji-hint');

textarea.addEventListener('focus', () => {
  if (hintElement) hintElement.style.display = 'block';
});

textarea.addEventListener('blur', () => {
  if (hintElement) hintElement.style.display = 'none';
});

    
    
})();
   
(function addWheelScrollListener() {

    if (scriptAlreadyExists) {
        return;
    }
    const chatContainer = document.querySelector('.chat-messages'); // Replace with the actual chat container selector

    if (!chatContainer) {
        if (_debug === true) {
            console.warn('[Scroll] Chat container not found.');
        }
        return;
    } 
    window.addEventListener('wheel', (event) => {
        
        event.preventDefault();
        chatContainer.scrollTop += event.deltaY > 0 ? 50 : -50; // Adjust scroll speed as needed
    }, { passive: false });

})();
