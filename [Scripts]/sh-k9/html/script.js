const app = Vue.createApp({
    data() {
        return {
            menuPosition: config.menu_pos,
            menuVisible: false,
            activeMenuIndex: 0,
            activeOptionIndex: 0,
            showSubMenu: false,
            menus: [],
            isEnterPressed: false,

            dragMode: false,
            isDragging: false,
            dragOffset: { x: 0, y: 0 },
            savedStatusPosition: null,
            
            // Dog status data
            warning: 20,
            dog: {
                health: 0,
                armor: 0,
                hunger: 0,
                thirst: 0,
                level: 1,
                xp: 0,
                xpToNextLevel: 1000
            },
            isVisible: false,
            showLevelCategory: true,
            
            // UI configuration
            statusIcons: {
                health: 'fas fa-heart',
                armor: 'fas fa-shield-alt',
                hunger: 'fas fa-drumstick-bite',
                thirst: 'fas fa-tint'
            },
            statusLabels: {},
            updatingStatus: {
                health: false,
                armor: false,
                hunger: false,
                thirst: false
            }
        }
    },

    computed: {
        currentMenuOptions() {
            return this.menus[this.activeMenuIndex]?.options || [];
        },
        
        dogStatus() {
            const { health, armor, hunger, thirst } = this.dog;
            return { health, armor, hunger, thirst };
        },
        
        menuContainerClasses() {
            return {
                'sub-menu-open': this.showSubMenu,
                [`menu-${this.menuPosition}`]: true
            }
        },
                
        subMenuClasses() {
            return {}
        },

        statusWindowStyle() {
            if (this.savedStatusPosition) {
                return {
                    position: 'fixed',
                    left: this.savedStatusPosition.x + 'px',
                    top: this.savedStatusPosition.y + 'px',
                    bottom: 'auto',
                    right: 'auto',
                    transform: 'none'
                };
            }
            return {};
        },
    },

    methods: {
        // === UTILITY FUNCTIONS ===
        async postToFiveM(action, data = {}) {
            try {
                await fetch(`https://${GetParentResourceName()}/${action}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data)
                });
            } catch (error) {
                console.error('Failed to communicate with FiveM:', error);
            }
        },

        playSound(soundType) {
            this.postToFiveM('PlaySoundEffect', soundType);
        },

        isDangerValue(value) {
            return value < this.warning;
        },

        // === MENU FUNCTIONS ===
        toggleMenu() {
            this.postToFiveM('SetFocusUI', { bool: this.menuVisible });
            this.menuVisible = !this.menuVisible;
        },

        navigateMenu(direction) {
            const menuCount = this.menus.length;
            if (menuCount === 0) return;

            if (direction === 'left') {
                this.activeMenuIndex = (this.activeMenuIndex - 1 + menuCount) % menuCount;
            } else if (direction === 'right') {
                this.activeMenuIndex = (this.activeMenuIndex + 1) % menuCount;
            } else if (direction === 'up') {
                this.activeMenuIndex = (this.activeMenuIndex - 1 + menuCount) % menuCount;
            } else if (direction === 'down') {
                this.activeMenuIndex = (this.activeMenuIndex + 1) % menuCount;
            }

            this.showSubMenu = false;
            this.activeOptionIndex = 0;
        },

        navigateOptions(direction) {
            const optionCount = this.currentMenuOptions.length;
            if (optionCount === 0) return;

            if (direction === 'up') {
                this.activeOptionIndex = (this.activeOptionIndex - 1 + optionCount) % optionCount;
            } else if (direction === 'down') {
                this.activeOptionIndex = (this.activeOptionIndex + 1) % optionCount;
            }
        },

        cycleOptionValue(direction) {
            const option = this.currentMenuOptions[this.activeOptionIndex];
            if (option?.type === 'selector') {
                const valueCount = option.values.length;
                option.currentIndex = (option.currentIndex + direction + valueCount) % valueCount;
            }
        },

        executeAction() {
            const menu = this.menus[this.activeMenuIndex];
            const option = this.currentMenuOptions[this.activeOptionIndex];
            
            if (!menu || !option) return;

            const actionInfo = {
                menuIndex: this.activeMenuIndex,
                menuName: menu.name,
                optionIndex: this.activeOptionIndex,
                optionName: option.name,
                optionType: option.type
            };

            if (option.type === 'selector') {
                actionInfo.selectedIndex = option.currentIndex;
                actionInfo.selectedValue = option.values[option.currentIndex];
            }

            this.postToFiveM('PerformAction', actionInfo);
        },

        // === KEYBOARD HANDLING ===
        handleArrowLeft() {
            this.playSound('1');
            
            if (this.showSubMenu) {
                const currentOption = this.currentMenuOptions[this.activeOptionIndex];
                if (currentOption?.type === 'selector') {
                    this.cycleOptionValue(-1);
                } else if (this.isVerticalMenu) {
                    this.showSubMenu = false;
                }
            } else if (!this.isVerticalMenu) {
                this.navigateMenu('left');
            }
        },

        handleArrowRight() {
            this.playSound('1');
            
            if (this.showSubMenu) {
                const currentOption = this.currentMenuOptions[this.activeOptionIndex];
                if (currentOption?.type === 'selector') {
                    this.cycleOptionValue(1);
                }
            } else if (this.isVerticalMenu) {
                if (!this.showSubMenu) {
                    this.showSubMenu = true;
                }
            } else {
                this.navigateMenu('right');
            }
        },

        handleArrowUp() {
            this.playSound('1');
            
            if (this.isVerticalMenu) {
                if (this.showSubMenu) {
                    this.navigateOptions('up');
                } else {
                    this.navigateMenu('up');
                }
            } else if (this.showSubMenu) {
                this.navigateOptions('up');
            }
        },

        handleArrowDown() {
            this.playSound('1');
            
            if (this.isVerticalMenu) {
                if (this.showSubMenu) {
                    this.navigateOptions('down');
                } else {
                    this.navigateMenu('down');
                }
            } else if (this.showSubMenu) {
                this.navigateOptions('down');
            } else {
                this.showSubMenu = true;
            }
        },

        handleEnter() {
            this.playSound('3');
            
            if (!this.showSubMenu) {
                this.showSubMenu = true;
            } else {
                this.executeAction();
            }
        },

        handleBackspace() {
            this.playSound('4');
            
            if (this.showSubMenu) {
                this.showSubMenu = false;
                this.activeOptionIndex = 0;
            } else {
                this.toggleMenu();
            }
        },

        handleKeydown(e) {
            if (!this.menuVisible) return;
            
            // Prevent double Enter execution
            if (e.key === 'Enter' && this.isEnterPressed) {
                e.preventDefault();
                return;
            }
            
            e.preventDefault();
            
            if (e.key === 'Enter') {
                this.isEnterPressed = true;
            }

            // Key mapping
            const keyActions = {
                'ArrowLeft': this.handleArrowLeft,
                'ArrowRight': this.handleArrowRight,
                'ArrowUp': this.handleArrowUp,
                'ArrowDown': this.handleArrowDown,
                'Enter': this.handleEnter,
                'Backspace': this.handleBackspace
            };

            const action = keyActions[e.key];
            if (action) action();
        },

        handleKeyup(e) {
            if (!this.menuVisible) return;
            e.preventDefault();
            
            if (e.key === 'Enter') {
                this.isEnterPressed = false;
            }
        },

        // === STATUS FUNCTIONS ===
        updateDogStatus(newData) {
            const oldData = { ...this.dog };
            Object.assign(this.dog, newData);
            
            // Show update animation for changed values
            Object.keys(newData).forEach(key => {
                if (newData[key] !== oldData[key] && this.updatingStatus.hasOwnProperty(key)) {
                    this.updatingStatus[key] = true;
                    setTimeout(() => {
                        this.updatingStatus[key] = false;
                    }, 300);
                }
            });
        },

        toggleVisibility() {
            this.isVisible = !this.isVisible;
        },

        // === CONFIGURATION ===
        updateConfig(config) {
            const updates = {
                menus: () => this.menus = config.menus,
                statusLabels: () => Object.assign(this.statusLabels, config.statusLabels),
                showLevelCategory: () => this.showLevelCategory = config.showLevelCategory,
                menuPosition: () => this.menuPosition = config.menuPosition,
                warning: () => this.warning = config.warning,
                menuIndex: () => {
                    if (this.menus[config.menuIndex]) {
                        this.menus[config.menuIndex].options = config.options;
                    }
                }
            };

            Object.keys(config).forEach(key => {
                if (updates[key]) updates[key]();
            });
        },

        // === DRAG MODE ===
        enableDragMode() {
            this.dragMode = true;
            document.body.style.cursor = 'move';
        },

        disableDragMode() {
            this.dragMode = false;
            this.isDragging = false;
            document.body.style.cursor = 'default';
            this.postToFiveM('DragModeDisabled');
        },

        handleStatusMouseDown(e) {
            if (!this.dragMode) return;
            
            this.isDragging = true;
            const rect = e.target.closest('.k9-status-window').getBoundingClientRect();
            this.dragOffset.x = e.clientX - rect.left;
            this.dragOffset.y = e.clientY - rect.top;
            
            document.addEventListener('mousemove', this.handleMouseMove);
            document.addEventListener('mouseup', this.handleMouseUp);
            e.preventDefault();
        },

        handleMouseMove(e) {
            if (!this.isDragging) return;
            
            const x = e.clientX - this.dragOffset.x;
            const y = e.clientY - this.dragOffset.y;
            
            this.savedStatusPosition = { x, y };
        },

        handleMouseUp() {
            document.removeEventListener('mousemove', this.handleMouseMove);
            document.removeEventListener('mouseup', this.handleMouseUp);
            this.isDragging = false;
        },

        resetStatusPosition() {
            this.savedStatusPosition = null;
            this.$forceUpdate();
            this.postToFiveM('PositionReset');
        },
    },

    mounted() {
        // Request initial configuration from Lua
        this.postToFiveM('MenuReady');

        // Auto-open submenu for left/right positions
        if (this.menuPosition === 'left' || this.menuPosition === 'right') {
            this.showSubMenu = true;
        }
        
        // Setup event listeners
        window.addEventListener('keydown', this.handleKeydown);
        window.addEventListener('keyup', this.handleKeyup);
    },

    beforeUnmount() {
        window.removeEventListener('keydown', this.handleKeydown);
        window.removeEventListener('keyup', this.handleKeyup);
    }
});

// Mount the app
const vm = app.mount('#app');

// Handle messages from FiveM
window.addEventListener("message", (event) => {
    const { action, ...data } = event.data;

    const messageHandlers = {
        ToggleStatus: () => vm.isVisible = data.toggle,
        UpdateStatusUI: () => vm.updateDogStatus(data.status),
        OpenMenuUI: () => vm.toggleMenu(),
        ChangeMenuPos: () => vm.menuPosition = data.pos,
        CloseMenuUI: () => {
            if (vm.menuVisible) {
                vm.postToFiveM('SetFocusUI', { bool: vm.menuVisible });
                vm.menuVisible = false;
            }
        },
        UpdateUI: () => vm.updateConfig(data.config),

        ToggleDragMode: () => {
            if (vm.dragMode) {
                vm.disableDragMode();
            } else {
                vm.enableDragMode();
            }
        },
    };

    const handler = messageHandlers[action];
    if (handler) handler();
});