let audioPlayer = null;

var resourceName = "tworst-scrapyard";
if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });

        if (!response.ok) {
            console.error(`HTTP Hatası: ${response.status}`);
            return null;
        }

        const text = await response.text();
        if (!text) {
            return null;
        }

        try {
            return JSON.parse(text);
        } catch (error) {
            console.error("Geçersiz JSON formatı:", text);
            return null;
        }
    } catch (error) {
        return null;
    }
};

const store = Vuex.createStore({
    components: {},
    getters: {},
    mutations: {},
    actions: {}
});

const app = Vue.createApp({
    components: {},
    data: () => ({
        isActive: false,
        notifyShow: false,
        infoPanelVisible: false,
        keyInfoVisible: false,
        hidePagination: false,  // Pg Down/Up kontrolü için
        hideArrows: false,      // Arrow keys kontrolü için
        hideConfirm: false,     // E (Confirm) tuşu kontrolü için
        trunkOpen: true,  // Bagaj durumu (true = açık, false = kapalı)
        notifications: [],

        progressbar: 0,
        progressbarLabel: "",
        localeValue: 'English',
        state: {
            mainShow: false,
            teamShow: false,
            finishShow: false,
            jobIsActive: false,
            tutoMenuShow: false,
            illegalSellShow: false,
            sellShow: false,
            craftWeaponEnabled: true, // Illegal craft enabled (Will be loaded from config)
            craftLegalEnabled: false, // Legal craft enabled (Will be loaded from config)
            currentPage: 'home',
            missionScoreData: {
                "Players": [
                    {
                        "scoreAmount": 0,
                        "playerName": "Player 1",
                        "playerLevel": 1,
                        "playerIdentifier": "ID001",
                        "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                        "bonusScoreAmount": 0,
                        "source": 1
                    },
                ],
                "regionJobTask": [
                    {
                        "jobLabel": "Test Job 1",
                        "madeAmount": 0,
                        "finish": false,
                        "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                        "jobName": "lawnmowing",
                        "invisible": false,
                        "jobCount": 2
                    },
                ],
                "vehicleInfo": []
            },
            languageTitle: [],
            defaultLogo: 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png',
            serverName: 'TWORST',
            scriptName: "Scrapyard",
            serverMoneyType: '$',
            selectedRegion: false,
            invitePlayerModal: false,
            displayedRegions: [],
            displayedDailyMission: [],
            currentRegionIndex: 0,
            regionsPerPage: 2,
            currentDailyMissionIndex: 0,
            dailyMissionsPerPage: 2,
            slideDirection: 'right',
            settings: {
                Sounds: true,
                Language: 'en',
                moveUI: false,
                uiPositions: {
                    teamList: { top: '77.22vh', left: '85.94vw' },
                    scoreList: { top: '2.64vh', left: '1.61vw' },
                    inviteSide: { top: '2.85vh', left: '73.07vw' },
                    notificationDiv: { top: '40.48vh', left: '81.54vw' },
                    keyInfoSide: { top: '50%', right: '2.0833vw' },
                    dumpsterInfo: { top: '1.3542vw', left: '50%' }
                },
            },
            nearbyPlayers: [],
            requestData: {
                show: false,
                hostIdentifier: '',
                hostName: '',
            },
            finishJobData: false,
            locales: {},
            tutorialList: []
        },
        playerData: {
            playerLevel: 1,
            playerXp: 1000,
            playerNextXp: 2000,
            playerIdentifier: '1234567890',
            owner: false,
            dailymission: [],
            playerDailyMission: [],
            soundEffect: true,
            locale: 'en',
        },
        playerListData: [
            {
                playerName: 'Brenden Randall',
                playerLevel: 1,
                playerIdentifier: '1234567890',
                playerImage: './img/regionBg.png',
                playerOwner: true,
            },
        ],
        regionData: [
            {
                regionName: 'Los santos Department',
                regionID: 1,
                regionImage: 'region.png',
                regionLevel: 1,
                regionXP: 1000,
                regionMoney: 1000,
            },
        ],
        historyData: [
            {
                historyRegionID: 1,
                historyTaskCount: 16,
                historyRewardMoney: 56000,
                historyRewardXP: 2500,
                historyTime: '01-01-1999 16:50',
                historyPlayer: [
                    'Brenden Randall',
                    'Brenden Randall 2',
                    'Brenden Randall 3',
                ]
            }
        ],
        dailyMission: false,


        playerInventory: [],

        // Inventory image path (from config)
        inventoryImagePath: 'nui://qb-inventory/html/images/',
        defaultItemImage: 'nui://tw-scrapyard/html/img/gun.png',

        // Sellable items lists (contains name, label, image, price)
        legalSellableItems: [],
        illegalSellableItems: [],

        // Current active sell prices (extracted from items list)
        sellPrices: {},

        // NPC Rental Menu
        npcRentalShow: false,
        npcRentalData: {
            title: '',
            options: []
        },

        // Craft data - will be loaded from config
        craftData: [
            {
                output: 'weapon_pistol',
                outputAmount: 1,
                craftTime: 300,
                craftCost: 500,
                successChance: 85,
                requiredItems: [
                    { name: 'pistol_part1', amount: 1 },
                    { name: 'pistol_part2', amount: 1 },
                    { name: 'pistol_part3', amount: 1 },
                    { name: 'pistol_part4', amount: 1 }
                ]
            },
            {
                output: 'weapon_pistol',
                outputAmount: 1,
                craftTime: 300,
                craftCost: 500,
                successChance: 85,
                requiredItems: [
                    { name: 'pistol_part1', amount: 1 },
                    { name: 'pistol_part2', amount: 1 },
                    { name: 'pistol_part3', amount: 1 },
                    { name: 'pistol_part4', amount: 1 }
                ]
            }
        ], // Legacy (illegal)
        illegalCraftRecipes: [],
        legalCraftRecipes: [
            {
                output: 'lockpick',
                outputAmount: 1,
                craftTime: 180,
                craftCost: 250,
                successChance: 95,
                requiredItems: [
                    { name: 'iron', amount: 2 },
                    { name: 'steel', amount: 1 }
                ]
            },
            {
                output: 'lockpick',
                outputAmount: 1,
                craftTime: 180,
                craftCost: 250,
                successChance: 95,
                requiredItems: [
                    { name: 'iron', amount: 2 },
                    { name: 'steel', amount: 1 }
                ]
            }
        ],

        illegalCraftHistory: [],
        legalCraftHistory: [],

        // Recipe navigation indexes
        currentIllegalRecipeIndex: 0,
        currentLegalRecipeIndex: 0,

        // Cooldown tracking
        craftCooldown: false,
        lastCraftTime: 0,
        collectCooldown: false,
        lastCollectTime: 0,
        sellCooldown: false,
        lastSellTime: 0,

        // TextUI System
        textUIItems: [],
    }),

    watch: {
    },

    beforeDestroy() {
        document.removeEventListener("click", this.handleClickOutside);
        if (this.progressUpdateInterval) {
            clearInterval(this.progressUpdateInterval);
        }
    },
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);
        document.addEventListener("click", this.handleClickOutside);

        this.progressUpdateInterval = setInterval(() => {
            if (!this.state.mainShow && !this.state.illegalSellShow && !this.state.sellShow) return;

            const hasActiveCrafts = this.illegalCraftHistory.some(craft => craft.status === 'pending') ||
                this.legalCraftHistory.some(craft => craft.status === 'pending');

            if (hasActiveCrafts) {
                this.loadCraftHistory();
            }
            this.$forceUpdate();
        }, 5000);

        this.checkInterval = setInterval(() => {
            if (this.notifications.length > 0 && !this.state.settings.moveUI) {
                this.notifications = this.notifications.filter((notification, index, self) =>
                    index === self.findIndex(n => n.message === notification.message)
                );

                this.notifyShow = true;
                let delays = [];
                this.notifications.slice(0, 3).forEach((notification, index) => {
                    const duration = 10000;
                    let delay = setTimeout(() => {
                        const indexToRemove = this.notifications.indexOf(notification);
                        if (indexToRemove !== -1) {
                            this.notifications.splice(indexToRemove, 1);
                            if (this.notifications.length === 0) {
                                this.notifyShow = false;
                            }
                        }
                        clearTimeout(delays[indexToRemove]);
                    }, duration * (index + 1) / 3);

                    delays.push(delay);
                });
            }
        }, 0);
    },

    methods: {
        // Recipe navigation methods
        prevIllegalRecipe() {
            if (this.currentIllegalRecipeIndex > 0) {
                this.currentIllegalRecipeIndex--;
            }
        },
        nextIllegalRecipe() {
            if (this.currentIllegalRecipeIndex < this.craftData.length - 1) {
                this.currentIllegalRecipeIndex++;
            }
        },
        prevLegalRecipe() {
            if (this.currentLegalRecipeIndex > 0) {
                this.currentLegalRecipeIndex--;
            }
        },
        nextLegalRecipe() {
            if (this.currentLegalRecipeIndex < this.legalCraftRecipes.length - 1) {
                this.currentLegalRecipeIndex++;
            }
        },
        toggleDropdown() {
            this.isActive = !this.isActive;
        },
        toggleBox(index) {
            this.state.tutorialList[index].isOpen = !this.state.tutorialList[index].isOpen;
        },
        selectOption(option) {
            this.isActive = false;
            this.playerData.locale = option.value;
            this.localeValue = option.label
        },
        handleClickOutside(event) {
            if (!this.$el.contains(event.target)) {
                this.isActive = false;
            }
        },
        prevRegion() {
            if (this.state.currentRegionIndex > 0) {
                clicksound("click.wav", this.playerData.soundEffect);
                this.state.slideDirection = 'left';
                this.state.currentRegionIndex -= this.state.regionsPerPage;
            }
        },
        nextRegion() {
            if (this.state.currentRegionIndex + this.state.regionsPerPage < this.regionData.length) {
                clicksound("click.wav", this.playerData.soundEffect);
                this.state.slideDirection = 'right';
                this.state.currentRegionIndex += this.state.regionsPerPage;
            }
        },
        prevDailyMission() {
            if (this.state.currentDailyMissionIndex > 0) {
                clicksound("click.wav", this.playerData.soundEffect);
                this.state.currentDailyMissionIndex -= this.state.dailyMissionsPerPage;
            }
        },
        nextDailyMission() {
            if (this.state.currentDailyMissionIndex + this.state.dailyMissionsPerPage < this.playerData.playerDailyMission.length) {
                clicksound("click.wav", this.playerData.soundEffect);
                this.state.currentDailyMissionIndex += this.state.dailyMissionsPerPage;
            }
        },
        invitePlayer(playerID) {
            if (playerID == null || playerID < 0) return;
            clicksound("click.wav", this.playerData.soundEffect);
            postNUI("invitePlayer", playerID);
        },
        changePage(page) {
            if (this.state.currentPage == page) return;
            clicksound("click.wav", this.playerData.soundEffect);
            this.state.currentPage = page;
        },
        requestActionButton(action) {
            if (action == "accept") {
                clicksound("click.wav", this.playerData.soundEffect);
                postNUI("acceptInvite", this.state.requestData.identifier);
                this.state.requestData.show = false;
            } else if (action == "deny") {
                this.closeNUI();
                this.state.requestData.show = false;
            }
        },
        acceptInvite() {
            clicksound("click.wav", this.playerData.soundEffect);
            postNUI("acceptInvite", this.state.requestData.identifier);
            this.state.requestData.show = false;
        },
        denyInvite() {
            clicksound("click.wav", this.playerData.soundEffect);
            this.state.requestData.show = false;
        },
        kickPlayer(playerIdentifier) {
            if (!playerIdentifier) {
                return;
            }

            const targetPlayer = this.playerListData.find(x => x.playerIdentifier === playerIdentifier);
            const ownerPlayer = this.playerListData.find(x => x.playerOwner === true);

            if (!targetPlayer || !ownerPlayer) {
                return;
            }


            if (playerIdentifier === this.playerData.playerIdentifier) {
                postNUI("leaveLobby", ownerPlayer.playerIdentifier);
                return;
            }

            if (targetPlayer.playerIdentifier === ownerPlayer.playerIdentifier) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            clicksound("click.wav", this.playerData.soundEffect);
            postNUI("kickPlayer", {
                lobbyID: ownerPlayer.playerIdentifier,
                identifier: playerIdentifier,
                targetID: targetPlayer.source
            });
        },
        selectRegion(regionValue) {
            if (regionValue == null || this.playerData.playerIdentifier == null) return;
            const identifierData = this.playerListData.findIndex(x => x.playerIdentifier == this.playerData.playerIdentifier);
            const playerOwner = this.playerListData.findIndex(x => x.playerOwner == true)
            if (this.playerListData[identifierData].playerIdentifier === this.playerListData[playerOwner].playerIdentifier) {
                if (this.state.selectedRegion != false && this.state.selectedRegion != null) {
                    if (regionValue.regionID == this.state.selectedRegion.regionID) {
                        clicksound("click.wav", this.playerData.soundEffect);
                        postNUI("selectRegion", false);
                        return;
                    }
                }
                if (regionValue && regionValue.regionID) {
                    const regionID = regionValue.regionID;

                    if (regionID == -1) return;
                    if (regionValue.regionInfo.regionMinimumLevel > this.playerData.playerLevel) {
                        clicksound("errorclick.mp3", this.playerData.soundEffect);
                        return;
                    }
                    clicksound("click.wav", this.playerData.soundEffect);
                    postNUI("selectRegion", regionValue);
                }
            }

        },
        startJob() {
            if (this.state.jobIsActive) {
                clicksound("click.wav", this.playerData.soundEffect);

                // If player is member (not owner), leave lobby
                if (!this.isPlayerOwner) {
                    const ownerPlayer = this.playerListData.find(x => x.playerOwner === true);
                    if (ownerPlayer) {
                        postNUI("leaveLobby", ownerPlayer.playerIdentifier);
                    }
                } else {
                    // If player is owner, reset job
                    postNUI("resetJob");
                }
            } else {
                // Start new job
                if (this.state.selectedRegion) {
                    clicksound("click.wav", this.playerData.soundEffect);
                    postNUI("startJob", this.state.selectedRegion);
                }
            }
        },
        closeNUI() {
            this.state.mainShow = false;
            postNUI("closeNUI");
        },
        closeInviteNUI() {
            this.state.mainShow = false;
            this.state.requestData.show = false;
            postNUI("closeInviteNUI");
        },
        keyHandler(event) {
            if (event.keyCode == 27) {
                if (this.npcRentalShow) {
                    this.closeNPCRentalMenu();
                } else if (this.state.tutoMenuShow) {
                    this.state.tutoMenuShow = false;
                    postNUI("closeTutoNUI");
                } else if (this.state.illegalSellShow) {
                    this.state.illegalSellShow = false;
                    this.closeNUI();
                } else if (this.state.sellShow) {
                    this.state.sellShow = false
                    this.closeNUI();
                } else {
                    if (!this.state.settings.moveUI) {
                        this.closeNUI();
                    } else {
                        this.state.settings.moveUI = false;
                        this.state.teamShow = false;
                        this.state.requestData.show = false;
                        this.keyInfoVisible = false; // Hide key info when exiting move mode
                        this.infoPanelVisible = false; // Hide dumpster info when exiting move mode
                        this.state.mainShow = true;
                        this.state.currentPage = 'settings';
                        $(".newTeamList, .allScoreList, .newInviteSide, .notifyList, .keyInfoSide, .dumpsterInfo").removeClass("movable");
                        $("body").find(".ui-moving-info").remove();

                        if (this.notifications.length === 1 && this.notifications[0].message === "You can move the notification") {
                            this.notifications = [];
                            this.notifyShow = false;
                        }
                    }
                }
            }

            if (event.keyCode == 13 && this.state.settings.moveUI) {
                this.state.settings.moveUI = false;
                this.state.teamShow = false;
                this.state.requestData.show = false;
                this.keyInfoVisible = false; // Hide key info when exiting move mode
                this.infoPanelVisible = false; // Hide dumpster info when exiting move mode
                this.state.mainShow = true;
                this.state.currentPage = 'settings';
                $(".newTeamList, .allScoreList, .newInviteSide, .notifyList, .keyInfoSide, .dumpsterInfo").removeClass("movable");
                $("body").find(".ui-moving-info").remove();

                if (this.notifications.length === 1 && this.notifications[0].message === "You can move the notification") {
                    this.notifications = [];
                    this.notifyShow = false;
                }
            }
        },
        formatNumber(number) {
            if (number == null) return 0;
            return number.toLocaleString("tr-TR");
        },
        calculateProgress(mission, complete) {
            return (mission / complete) * 100;
        },
        mergeData(sqlData, configData) {
            if (sqlData == null || configData == null) return;
            const mergedData = configData.map(mission => {
                const sqlMissionData = sqlData[mission.name];
                return {
                    ...mission,
                    complete: sqlMissionData ? sqlMissionData.complete : false,
                    currentCount: sqlMissionData ? sqlMissionData.count : 0,
                    progressbar: sqlMissionData ? this.calculateProgress(sqlMissionData.count, mission.count) : 0
                };
            });
            this.totalCompleted = mergedData.filter(mission => mission.complete).length;
            this.playerData.playerDailyMission = mergedData;
        },
        moveUI() {
            if (!this.state.jobIsActive) {
                clicksound("click.wav", this.playerData.soundEffect);
                this.state.settings.moveUI = true;
                this.state.mainShow = false;
                this.state.teamShow = true;
                this.state.requestData.show = true;
                this.state.requestData.lobbyOwner = "Brenden Randall";

                this.notifyShow = true;
                this.keyInfoVisible = true; // Show key info for moving
                this.infoPanelVisible = true; // Show dumpster info for moving

                if (this.notifications.length === 0) {
                    this.notifications.push({
                        message: "You can move the notification",
                        type: "info",
                        duration: 10000
                    });
                }

                this.$nextTick(() => {
                    this.applyUIPositions();

                    setTimeout(() => {
                        this.makeAllUIDraggable();
                    }, 100);
                });
            }
        },
        applyUIPositions() {

            // Apply positions with validation
            if (this.state.settings.uiPositions.teamList) {
                $(".newTeamList").css(this.state.settings.uiPositions.teamList);
            }
            if (this.state.settings.uiPositions.scoreList) {
                $(".allScoreList").css(this.state.settings.uiPositions.scoreList);
            }
            if (this.state.settings.uiPositions.inviteSide) {
                $(".newInviteSide").css(this.state.settings.uiPositions.inviteSide);
            }
            if (this.state.settings.uiPositions.notificationDiv) {
                $(".notifyList").css(this.state.settings.uiPositions.notificationDiv);
            }
            if (this.state.settings.uiPositions.keyInfoSide) {
                $(".keyInfoSide").css(this.state.settings.uiPositions.keyInfoSide);
            } else {
                this.state.settings.uiPositions.keyInfoSide = { top: '50%', right: '2.0833vw' };
                $(".keyInfoSide").css(this.state.settings.uiPositions.keyInfoSide);
            }
            if (this.state.settings.uiPositions.dumpsterInfo) {
                $(".dumpsterInfo").css(this.state.settings.uiPositions.dumpsterInfo);
            } else {
                this.state.settings.uiPositions.dumpsterInfo = { top: '1.3542vw', left: '50%' };
                $(".dumpsterInfo").css(this.state.settings.uiPositions.dumpsterInfo);
            }



            if (this.state.settings.moveUI) {
                $(".newTeamList, .allScoreList, .newInviteSide, .notifyList, .keyInfoSide, .dumpsterInfo").css({
                    'position': 'absolute',
                    'z-index': '999'
                });

                // Remove CSS transforms that conflict with jQuery draggable
                $(".keyInfoSide").css('transform', 'none');
                $(".dumpsterInfo").css('transform', 'none');
            } else {
                $(".newTeamList").css({
                    'position': '',
                    'z-index': ''
                });
                $(".allScoreList").css({
                    'position': '',
                    'z-index': ''
                });
                $(".newInviteSide").css({
                    'position': '',
                    'z-index': ''
                });
                $(".notifyList").css({
                    'position': '',
                    'z-index': ''
                });
                $(".keyInfoSide").css({
                    'position': '',
                    'z-index': '',
                    'transform': '' // Restore original transform
                });
                $(".dumpsterInfo").css({
                    'position': '',
                    'z-index': '',
                    'transform': '' // Restore original transform
                });
            }
        },
        makeElementDraggable(selector, positionKey) {

            try {
                $(selector).draggable("instance") && $(selector).draggable("destroy");
            } catch (e) {
                console.log('[Draggable] No previous instance:', selector);
            }

            $(selector).addClass("movable");

            const $elem = $(selector);

            // Check if element exists
            if ($elem.length === 0) {
                console.error('[Draggable] Element not found:', selector);
                return;
            }

            const currentPos = this.state.settings.uiPositions[positionKey];
            const usesRight = currentPos && currentPos.right !== undefined;
            const usesCenterX = currentPos && currentPos.left === '50%';
            // Convert right or center positioning to left for dragging
            if (usesRight || usesCenterX) {
                const elemRect = $elem[0].getBoundingClientRect();
                const windowWidth = window.innerWidth;

                let leftPos;
                if (usesRight) {
                    // Calculate left position from right
                    leftPos = windowWidth - elemRect.right;
                } else if (usesCenterX) {
                    // Calculate left position from centered element
                    leftPos = elemRect.left;
                }


                $elem.css({
                    'left': leftPos + 'px',
                    'right': 'auto'
                });
            }

            try {
                $(selector).draggable({
                    containment: "body",
                    scroll: false,
                    start: (event, ui) => {
                        // console.log('[Draggable] Drag started:', selector);
                    },
                    stop: (event, ui) => {
                        const windowWidth = window.innerWidth;
                        const windowHeight = window.innerHeight;

                        const topVh = (ui.position.top / windowHeight * 100).toFixed(2) + 'vh';

                        // Convert back to original positioning scheme
                        if (usesRight) {
                            const elemWidth = $(selector).outerWidth();
                            const rightPx = windowWidth - (ui.position.left + elemWidth);
                            const rightVw = (rightPx / windowWidth * 100).toFixed(4) + 'vw';

                            this.state.settings.uiPositions[positionKey] = { top: topVh, right: rightVw };
                        } else if (usesCenterX) {
                            // For center-positioned elements, keep left as percentage
                            const leftVw = (ui.position.left / windowWidth * 100).toFixed(2) + '%';
                            this.state.settings.uiPositions[positionKey] = { top: topVh, left: leftVw };
                        } else {
                            const leftVw = (ui.position.left / windowWidth * 100).toFixed(2) + 'vw';
                            this.state.settings.uiPositions[positionKey] = { top: topVh, left: leftVw };
                        }
                    }
                });
            } catch (e) {
                console.error('[Draggable] Failed to initialize:', selector, e);
            }
        },
        makeAllUIDraggable() {
            this.makeElementDraggable(".newTeamList", "teamList");
            this.makeElementDraggable(".allScoreList", "scoreList");
            this.makeElementDraggable(".newInviteSide", "inviteSide");
            this.makeElementDraggable(".notifyList", "notificationDiv");
            this.makeElementDraggable(".keyInfoSide", "keyInfoSide");
            this.makeElementDraggable(".dumpsterInfo", "dumpsterInfo");
        },
        saveSettings() {
            clicksound("click.wav", this.playerData.soundEffect);
            this.state.settings.moveUI = false;
            postNUI("saveSettings", {
                uiPositions: this.state.settings.uiPositions,
                soundEffect: this.playerData.soundEffect,
                locale: this.playerData.locale,
            });

            $(".newTeamList, .allScoreList, .newInviteSide, .notifyList, .keyInfoSide, .dumpsterInfo").removeClass("movable");
            $("body").find(".ui-moving-info").remove();

            if (this.notifications.length === 1 && this.notifications[0].message === "You can move the notification") {
                this.notifications = [];
                this.notifyShow = false;
            }
        },
        resetSettings() {
            clicksound("click.wav", this.playerData.soundEffect);
            this.state.settings.uiPositions = {
                teamList: { top: '77.22vh', left: '85.94vw' },
                scoreList: { top: '0vh', left: '1.30vw' },
                inviteSide: { top: '0vh', left: '74.48vw' },
                notificationDiv: { top: '20vh', left: '1vw' },
                keyInfoSide: { top: '50%', right: '2.0833vw' },
                dumpsterInfo: { top: '1.3542vw', left: '50%' }
            };

            this.applyUIPositions()
        },
        async loadCraftHistory() {
            // Load illegal crafts
            const illegalResult = await postNUI("getActiveCrafts", { filterType: 'illegal' });
            if (illegalResult) {
                this.illegalCraftHistory = illegalResult;
            }

            // Load legal crafts
            const legalResult = await postNUI("getActiveCrafts", { filterType: 'legal' });
            if (legalResult) {
                this.legalCraftHistory = legalResult;
            }
        },
        async craftPistol() {
            // Check cooldown (prevent spam clicking/macro)
            const now = Date.now();
            if (this.craftCooldown && (now - this.lastCraftTime) < 2000) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.notifications.push({
                    message: "Please wait before crafting again",
                    type: "error",
                    duration: 3000
                });
                return;
            }

            // Reset cooldown if more than 2 seconds passed
            if ((now - this.lastCraftTime) >= 2000) {
                this.craftCooldown = false;
            }

            if (!this.canCraft) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.notifications.push({
                    message: "You don't have the required items",
                    type: "error",
                    duration: 3000
                });
                return;
            }

            // Set cooldown
            this.craftCooldown = true;
            this.lastCraftTime = now;

            clicksound("click.wav", this.playerData.soundEffect);

            // Get current recipe
            const recipe = this.craftData[this.currentIllegalRecipeIndex];
            if (!recipe || !recipe.id) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.craftCooldown = false;
                return;
            }

            // Send craft request to server
            const result = await postNUI("craftPistol", {
                recipeId: recipe.id
            });

            if (result && result.success) {
                // Reload craft history from server
                await this.loadCraftHistory();

                // Refresh inventory
                const inventoryResult = await postNUI("getInventory");
                if (inventoryResult) {
                    this.playerInventory = inventoryResult;
                }

                // Show notification
                this.notifications.push({
                    message: "Craft started successfully!",
                    type: "success",
                    duration: 5000
                });

                // Reset cooldown after 2 seconds
                setTimeout(() => {
                    this.craftCooldown = false;
                }, 2000);
            } else {
                this.notifications.push({
                    message: result?.message || "Failed to start craft",
                    type: "error",
                    duration: 5000
                });

                // Reset cooldown immediately on failure
                this.craftCooldown = false;
            }
        },
        isItemAvailable(itemName, requiredCount) {
            const item = this.playerInventory.find(i => i.name === itemName);
            return item && item.amount >= requiredCount;
        },
        getItemLabel(itemName) {
            // First check player inventory
            const inventoryItem = this.playerInventory.find(i => i.name === itemName);
            if (inventoryItem && inventoryItem.label) {
                return inventoryItem.label;
            }

            // If not in inventory, check illegal sellable items config
            const illegalItem = this.illegalSellableItems.find(i => i.name === itemName);
            if (illegalItem && illegalItem.label) {
                return illegalItem.label;
            }

            // If not in illegal items, check legal sellable items config
            const legalItem = this.legalSellableItems.find(i => i.name === itemName);
            if (legalItem && legalItem.label) {
                return legalItem.label;
            }

            // Fallback to item name
            return itemName;
        },
        getItemImage(itemName) {
            // First check player inventory
            const inventoryItem = this.playerInventory.find(i => i.name === itemName);
            if (inventoryItem && inventoryItem.image) {
                return `${this.inventoryImagePath}${inventoryItem.image}`;
            }

            // If not in inventory, check illegal sellable items config
            const illegalItem = this.illegalSellableItems.find(i => i.name === itemName);
            if (illegalItem && illegalItem.image) {
                return `${this.inventoryImagePath}${illegalItem.image}`;
            }

            // If not in illegal items, check legal sellable items config
            const legalItem = this.legalSellableItems.find(i => i.name === itemName);
            if (legalItem && legalItem.image) {
                return `${this.inventoryImagePath}${legalItem.image}`;
            }

            // Fallback to default
            return this.defaultItemImage;
        },
        getCraftProgress(historyItem) {
            if (historyItem.status === 'completed') return 100;
            // Use elapsed_time from server if available (OnlineOnly mode), otherwise calculate from start_time
            const elapsed = (historyItem.elapsed_time !== undefined && historyItem.elapsed_time !== null)
                ? historyItem.elapsed_time
                : (Date.now() - historyItem.start_time);
            const progress = (elapsed / historyItem.duration) * 100;
            return Math.min(progress, 100);
        },
        getRemainingTime(historyItem) {
            if (historyItem.status === 'completed') return this.state.locales['status_completed'] || 'Completed';
            // Use elapsed_time from server if available (OnlineOnly mode), otherwise calculate from start_time
            const elapsed = (historyItem.elapsed_time !== undefined && historyItem.elapsed_time !== null)
                ? historyItem.elapsed_time
                : (Date.now() - historyItem.start_time);
            const remaining = historyItem.duration - elapsed;

            // If time is up, show completed
            if (remaining <= 0) {
                return this.state.locales['status_completed'] || 'Completed';
            }

            const minutes = Math.ceil(remaining / 60000);
            const minuteText = minutes !== 1 ? (this.state.locales['time_minutes'] || 'Minutes') : (this.state.locales['time_minute'] || 'Minute');
            return `${minutes} ${minuteText}`;
        },
        getCraftTimeText() {
            const defaultMinute = this.state.locales['time_minute'] || 'Minute';
            if (!this.craftData || this.craftData.length === 0) return `0 ${defaultMinute}`;
            const recipe = this.craftData[this.currentIllegalRecipeIndex];
            if (!recipe || !recipe.craftTime) return `0 ${defaultMinute}`;

            // Convert seconds to minutes (craftTime is in seconds)
            const minutes = Math.round(recipe.craftTime / 60);
            const minuteText = minutes !== 1 ? (this.state.locales['time_minutes'] || 'Minutes') : defaultMinute;
            return `${minutes} ${minuteText}`;
        },
        getCraftSuccessChance() {
            const chanceText = this.state.locales['craft_chance'] || 'Chance';
            if (!this.craftData || this.craftData.length === 0) return `0% ${chanceText}`;
            const recipe = this.craftData[this.currentIllegalRecipeIndex];
            if (!recipe || recipe.successChance === undefined) return `0% ${chanceText}`;

            return `${recipe.successChance}% ${chanceText}`;
        },
        getCraftCostText() {
            if (!this.craftData || this.craftData.length === 0) return `0 ${this.state.serverMoneyType}`;
            const recipe = this.craftData[this.currentIllegalRecipeIndex];
            if (!recipe || !recipe.craftCost) return `0 ${this.state.serverMoneyType}`;

            // Format money with commas
            const formattedCost = recipe.craftCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            return `${formattedCost} ${this.state.serverMoneyType}`;
        },
        // Legal craft helper functions
        getLegalCraftTimeText() {
            const defaultMinute = this.state.locales['time_minute'] || 'Minute';
            if (!this.legalCraftRecipes || this.legalCraftRecipes.length === 0) return `0 ${defaultMinute}`;
            const recipe = this.legalCraftRecipes[this.currentLegalRecipeIndex];
            if (!recipe || !recipe.craftTime) return `0 ${defaultMinute}`;

            const minutes = Math.round(recipe.craftTime / 60);
            const minuteText = minutes !== 1 ? (this.state.locales['time_minutes'] || 'Minutes') : defaultMinute;
            return `${minutes} ${minuteText}`;
        },
        getLegalCraftSuccessChance() {
            const chanceText = this.state.locales['craft_chance'] || 'Chance';
            if (!this.legalCraftRecipes || this.legalCraftRecipes.length === 0) return `0% ${chanceText}`;
            const recipe = this.legalCraftRecipes[this.currentLegalRecipeIndex];
            if (!recipe || recipe.successChance === undefined) return `0% ${chanceText}`;

            return `${recipe.successChance}% ${chanceText}`;
        },
        getLegalCraftCostText() {
            if (!this.legalCraftRecipes || this.legalCraftRecipes.length === 0) return `0 ${this.state.serverMoneyType}`;
            const recipe = this.legalCraftRecipes[this.currentLegalRecipeIndex];
            if (!recipe || !recipe.craftCost) return `0 ${this.state.serverMoneyType}`;

            // Format money with commas
            const formattedCost = recipe.craftCost.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            return `${formattedCost} ${this.state.serverMoneyType}`;
        },
        async craftLegalItem() {
            const now = Date.now();
            if (this.craftCooldown && (now - this.lastCraftTime) < 2000) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.notifications.push({
                    message: "Please wait before crafting again",
                    type: "error",
                    duration: 3000
                });
                return;
            }

            // Reset cooldown if more than 2 seconds passed
            if ((now - this.lastCraftTime) >= 2000) {
                this.craftCooldown = false;
            }

            if (!this.canCraftLegal) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.notifications.push({
                    message: "You don't have the required items",
                    type: "error",
                    duration: 3000
                });
                return;
            }

            this.craftCooldown = true;
            this.lastCraftTime = now;

            clicksound("click.wav", this.playerData.soundEffect);

            // Get current recipe
            const recipe = this.legalCraftRecipes[this.currentLegalRecipeIndex];
            if (!recipe || !recipe.id) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                this.craftCooldown = false;
                return;
            }

            const result = await postNUI("craftLegalItem", {
                recipeId: recipe.id
            });

            if (result && result.success) {
                await this.loadCraftHistory();

                if (result.inventory) {
                    this.playerInventory = result.inventory;
                }

                this.notifications.push({
                    message: result.message || "Legal craft started!",
                    type: "success",
                    duration: 5000
                });
            } else {
                this.notifications.push({
                    message: result?.message || "Craft failed",
                    type: "error",
                    duration: 5000
                });
            }

            setTimeout(() => {
                this.craftCooldown = false;
            }, 2000);
        },
        async collectCraft(historyItem) {
            // Check cooldown (prevent spam clicking/macro)
            const now = Date.now();
            if (this.collectCooldown || (now - this.lastCollectTime) < 1000) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            if (historyItem.status !== 'completed') {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            // Set cooldown
            this.collectCooldown = true;
            this.lastCollectTime = now;

            clicksound("click.wav", this.playerData.soundEffect);

            // Send collect request to server
            const result = await postNUI("collectCraft", {
                id: historyItem.id,
                craft_name: historyItem.craft_name,
                success: historyItem.success
            });

            if (result && result.success) {
                // Reload craft history to reflect changes
                await this.loadCraftHistory();

                // Update inventory if provided
                if (result.inventory) {
                    this.playerInventory = result.inventory;
                }

                // Show notification based on craft success
                if (result.craft_success) {
                    this.notifications.push({
                        message: "Craft collected successfully!",
                        type: "success",
                        duration: 5000
                    });
                } else {
                    this.notifications.push({
                        message: "Craft failed - No items received",
                        type: "error",
                        duration: 5000
                    });
                }

                // Reset cooldown after 1 second
                setTimeout(() => {
                    this.collectCooldown = false;
                }, 1000);
            } else {
                this.notifications.push({
                    message: result?.message || "Failed to collect craft",
                    type: "error",
                    duration: 5000
                });

                // Reset cooldown immediately on failure
                this.collectCooldown = false;
            }
        },
        async sellItem(itemName, amount, price) {
            // Check cooldown (prevent spam clicking/macro)
            const now = Date.now();
            if (this.sellCooldown || (now - this.lastSellTime) < 500) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            if (amount < 1) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            // Set cooldown
            this.sellCooldown = true;
            this.lastSellTime = now;

            clicksound("click.wav", this.playerData.soundEffect);

            // Send sell request to server
            const result = await postNUI("sellScrapItem", {
                itemName: itemName,
                amount: 1, // Sell one at a time
                price: price
            });

            if (result && result.success) {
                // Update inventory
                this.playerInventory = result.inventory;

                // Show notification
                this.notifications.push({
                    message: `Sold 1x item for $${price}`,
                    type: "success",
                    duration: 5000
                });

                // Reset cooldown after 500ms
                setTimeout(() => {
                    this.sellCooldown = false;
                }, 500);
            } else {
                this.notifications.push({
                    message: result?.message || "Failed to sell item",
                    type: "error",
                    duration: 5000
                });

                // Reset cooldown immediately on failure
                this.sellCooldown = false;
            }
        },
        async sellAllItems() {
            // Check cooldown (prevent spam clicking/macro)
            const now = Date.now();
            if (this.sellCooldown || (now - this.lastSellTime) < 1000) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            const totalPrice = this.totalSellPrice;
            if (totalPrice <= 0) {
                clicksound("errorclick.mp3", this.playerData.soundEffect);
                return;
            }

            // Set cooldown
            this.sellCooldown = true;
            this.lastSellTime = now;

            clicksound("click.wav", this.playerData.soundEffect);

            // Prepare items to sell (only items with amount > 0)
            const itemsToSell = this.visibleInventory
                .filter(item => item.amount > 0 && this.sellPrices[item.name])
                .map(item => ({
                    name: item.name,
                    amount: item.amount,
                    price: this.sellPrices[item.name]
                }));

            // Send sell all request to server
            const result = await postNUI("sellAllScrapItems", {
                items: itemsToSell,
                totalPrice: totalPrice
            });

            if (result && result.success) {
                // Update inventory
                this.playerInventory = result.inventory;

                // Show notification
                this.notifications.push({
                    message: `Sold all items for $${result.moneyReceived}`,
                    type: "success",
                    duration: 5000
                });

                // Reset cooldown after 1 second
                setTimeout(() => {
                    this.sellCooldown = false;
                }, 1000);
            } else {
                this.notifications.push({
                    message: result?.message || "Failed to sell items",
                    type: "error",
                    duration: 5000
                });

                // Reset cooldown immediately on failure
                this.sellCooldown = false;
            }
        },
        // Helper function to extract prices from items array
        extractPricesFromItems(items) {
            if (!items || items.length === 0) return {};

            const prices = {};
            items.forEach(item => {
                if (item.name && item.price) {
                    prices[item.name] = item.price;
                }
            });
            return prices;
        },
        startProgress(label, time) {
            this.progressbarLabel = label;
            this.progressbar = 0;
            const duration = time * 1000;
            let startTime = null;

            const animate = (timestamp) => {
                if (!startTime) startTime = timestamp;
                const elapsed = timestamp - startTime;
                this.progressbar = Math.min((elapsed / duration) * 100, 100);

                if (elapsed < duration) {
                    requestAnimationFrame(animate);
                } else {
                    setTimeout(() => {
                        stopsound();
                        this.progressbar = 0;
                        this.progressbarLabel = "";
                    }, 100);
                }
            };

            requestAnimationFrame(animate);
        },
        eventHandler(event) {
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("checkNUI");
                    break;
                case "CLOSENUI":
                    this.closeNUI();
                    break;
                case "OPEN_MENU":
                    this.state.mainShow = true;
                    this.playerData = event.data.payload;
                    if (event.data.payload.uiSettings) {
                        if (event.data.payload.uiSettings.uiPositions) {
                            this.state.settings.uiPositions = event.data.payload.uiSettings.uiPositions;
                        }
                        this.$nextTick(() => {
                            this.applyUIPositions();
                        });
                    }
                    this.mergeData(this.playerData.dailymission, this.dailyMission);

                    // Craft history'yi sadece menü açıldığında yükle
                    this.loadCraftHistory();

                    this.state.languageTitle.forEach(item => {
                        if (item.value == this.playerData.locale) {
                            this.localeValue = item.label;
                        }
                    });

                    break;
                case "LOAD_LOBBY":
                    // Force Vue reactivity by creating new array reference
                    this.playerListData = [...event.data.payload];
                    break;
                case "LOAD_HISTORY":
                    this.historyData = event.data.payload;
                    break;
                case "JOB_IS_ACTIVE":
                    this.state.jobIsActive = event.data.payload;
                    break;
                case "REFRESH_LOBBY":
                    if (!event.data.payload) {
                        this.state.selectedRegion = false;
                    } else {
                        this.state.selectedRegion = event.data.payload;
                    }
                    break;
                case "STATE":
                    this.state.serverName = event.data.payload.serverName;
                    this.state.serverMoneyType = event.data.payload.serverMoneyType;
                    this.state.tebexAccess = event.data.payload.tebexAccess;
                    this.dailyMission = event.data.payload.dailyMission;
                    this.regionData = event.data.payload.regionData;
                    this.state.tutorialList = event.data.payload.tutorialList
                    this.state.locales = event.data.payload.locales;
                    this.state.settings.uiPositions = event.data.payload.uiPositions;
                    if (event.data.payload.uiPositions && event.data.payload.uiPositions) {
                        this.state.settings.uiPositions = event.data.payload.uiPositions;
                        this.$nextTick(() => {
                            this.applyUIPositions();
                        });
                    }
                    this.state.languageTitle = event.data.payload.languageTitle;
                    this.state.defaultLogo = event.data.payload.defaultLogo;

                    // Load inventory image path from config
                    if (event.data.payload.inventoryImagePath) {
                        this.inventoryImagePath = event.data.payload.inventoryImagePath;
                    }
                    if (event.data.payload.defaultItemImage) {
                        this.defaultItemImage = event.data.payload.defaultItemImage;
                    }

                    // Load config-driven sell items and craft data
                    if (event.data.payload.legalSellableItems) {
                        this.legalSellableItems = event.data.payload.legalSellableItems;
                    }
                    if (event.data.payload.illegalSellableItems) {
                        this.illegalSellableItems = event.data.payload.illegalSellableItems;
                    }
                    if (event.data.payload.craftRecipes) {
                        this.craftData = event.data.payload.craftRecipes; // Legacy backward compatibility
                    }
                    if (event.data.payload.illegalCraftRecipes) {
                        this.illegalCraftRecipes = event.data.payload.illegalCraftRecipes;
                        this.craftData = event.data.payload.illegalCraftRecipes; // Use illegal recipes for craftData
                    }
                    if (event.data.payload.legalCraftRecipes) {
                        this.legalCraftRecipes = event.data.payload.legalCraftRecipes;
                    }

                    // Load craft enabled settings
                    if (event.data.payload.craftWeaponEnabled !== undefined) {
                        this.state.craftWeaponEnabled = event.data.payload.craftWeaponEnabled;
                    }
                    if (event.data.payload.craftLegalEnabled !== undefined) {
                        this.state.craftLegalEnabled = event.data.payload.craftLegalEnabled;
                    }

                    // Extract prices from legal items list and set as initial prices
                    this.sellPrices = this.extractPricesFromItems(this.legalSellableItems);
                    break;
                case "UPDATE_LOCALES":
                    this.state.locales = event.data.payload
                    break;
                case "NEARBY_PLAYERS":
                    this.state.nearbyPlayers = event.data.payload;
                    break;
                case "INVITE_MENU":
                    this.state.requestData = event.data.payload
                    this.state.requestData.show = true;
                    break;
                case "START_JOB":
                    this.state.mainShow = false;
                    this.state.missionScoreData = event.data.payload;
                    this.state.teamShow = true;
                    break;
                case "RECONNECT_TO_JOB":
                    // Reconnection: Show mission UI without opening menu
                    this.state.mainShow = false;
                    this.state.missionScoreData = event.data.payload.jobTask;
                    this.state.teamShow = true;
                    this.state.jobIsActive = true;
                    break;
                case "REFRESH_JOBTASK":
                    this.state.missionScoreData = event.data.payload;
                    break;
                case "UPDATE_VEHICLE_INFO":
                    // Lightweight vehicle info update (only updates vehicleInfo array)
                    if (this.state.missionScoreData) {
                        this.state.missionScoreData.vehicleInfo = event.data.payload;
                    }
                    break;
                case "FINISH_JOB":
                    this.state.finishJobData = event.data.payload;
                    this.state.finishShow = true;
                    this.state.teamShow = false;
                    this.state.mainShow = false;
                    this.state.selectedRegion = false;
                    this.state.jobIsActive = false;
                    this.state.currentPage = 'home';
                    this.state.missionScoreData = {
                        "Players": [
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 1",
                                "playerLevel": 1,
                                "playerIdentifier": "ID001",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 2",
                                "playerLevel": 2,
                                "playerIdentifier": "ID002",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 3",
                                "playerLevel": 3,
                                "playerIdentifier": "ID003",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 4",
                                "playerLevel": 4,
                                "playerIdentifier": "ID004",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            }
                        ],
                        "regionJobTask": [
                            {
                                "jobLabel": "Test Job 1",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "lawnmowing",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 2",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "prunegrass",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 3",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "branch",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 4",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "plantflower",
                                "invisible": false,
                                "jobCount": 2
                            }
                        ],
                    }
                    break;
                case "RESET_JOB":
                    this.state.finishJobData = false;
                    this.state.finishShow = true;
                    this.state.teamShow = false;
                    this.state.mainShow = false;
                    this.state.selectedRegion = false;
                    this.state.jobIsActive = false;
                    this.state.currentPage = 'home';

                    this.state.missionScoreData = {
                        "Players": [
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 1",
                                "playerLevel": 1,
                                "playerIdentifier": "ID001",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 2",
                                "playerLevel": 2,
                                "playerIdentifier": "ID002",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 3",
                                "playerLevel": 3,
                                "playerIdentifier": "ID003",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            },
                            {
                                "scoreAmount": 0,
                                "playerName": "Player 4",
                                "playerLevel": 4,
                                "playerIdentifier": "ID004",
                                "playerImage": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "bonusScoreAmount": 0,
                                "source": 1
                            }
                        ],
                        "regionJobTask": [
                            {
                                "jobLabel": "Test Job 1",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "lawnmowing",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 2",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "prunegrass",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 3",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "branch",
                                "invisible": false,
                                "jobCount": 2
                            },
                            {
                                "jobLabel": "Test Job 4",
                                "madeAmount": 0,
                                "finish": false,
                                "img": "https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png",
                                "jobName": "plantflower",
                                "invisible": false,
                                "jobCount": 2
                            }
                        ],
                    }
                    this.closeNUI();
                    break;
                case "CLOSE_INVITE_MENU":
                    clicksound("click.wav", this.playerData.soundEffect);
                    this.closeInviteNUI();
                    this.state.requestData.show = false;
                    break;
                case "CLOSE_FINISH_JOB":
                    this.state.finishShow = false;
                    this.state.finishJobData = false;
                    break;
                case "LOAD_SETTINGS":
                    this.state.settings.uiPositions = event.data.payload.uiPositions;
                    this.$nextTick(() => {
                        this.applyUIPositions();
                    });
                    break;
                case "EDIT_SETTINGS":
                    this.state.settings.moveUI = true;
                    this.state.mainShow = false;
                    this.state.teamShow = true;

                    this.$nextTick(() => {
                        this.applyUIPositions();
                        this.makeAllUIDraggable();
                    });
                    break;
                case "NOTIFICATION":
                    this.notifications.push(event.data.payload);
                    this.notifyShow = true;
                    break;
                case "showProgressBar":
                    this.startProgress(event.data.payload.label, event.data.payload.time);
                    break;
                case "playSound":
                    clicksound(event.data.payload.sound, this.playerData.soundEffect);
                    break;
                case "OPEN_TUTORIAL":
                    if (this.state.mainShow || this.state.moveUI) {
                        return;
                    }

                    if (this.state.tutoMenuShow) {
                        this.state.tutoMenuShow = false;
                    } else {
                        this.state.tutoMenuShow = true;
                        this.state.tutorialList.forEach(item => {
                            item.isOpen = false;
                        });
                    }
                    break;
                case "SET_INVENTORY":
                    this.playerInventory = event.data.payload;
                    break;
                case "SHOW_INFO_PANEL":
                    if (typeof event.data.payload === 'object') {
                        this.infoPanelVisible = event.data.payload.visible;
                        this.hidePagination = event.data.payload.hidePagination || false;
                        this.trunkOpen = event.data.payload.trunkOpen !== undefined ? event.data.payload.trunkOpen : true;
                    } else {
                        this.infoPanelVisible = event.data.payload;
                        this.hidePagination = false;
                        this.trunkOpen = true;
                    }
                    break;
                case "SHOW_KEY_INFO":
                    if (typeof event.data.payload === 'object') {
                        this.keyInfoVisible = event.data.payload.visible;
                        this.hidePagination = event.data.payload.hidePagination || false;
                        this.hideArrows = event.data.payload.hideArrows || false;
                        this.hideConfirm = event.data.payload.hideConfirm || false;
                    } else {
                        this.keyInfoVisible = event.data.payload;
                        this.hidePagination = false;
                        this.hideArrows = false;
                        this.hideConfirm = false;
                    }
                    break;
                case "OPEN_ILLEGAL":
                    this.state.illegalSellShow = event.data.payload;

                    if (event.data.payload) {
                        this.sellPrices = this.extractPricesFromItems(this.illegalSellableItems);
                        this.loadCraftHistory();
                    } else {
                        this.sellPrices = this.extractPricesFromItems(this.legalSellableItems);
                    }
                    break;
                case "OPEN_LEGAL_SELL":
                    this.state.sellShow = event.data.payload;

                    // Switch to legal sell prices
                    if (event.data.payload) {
                        this.sellPrices = this.extractPricesFromItems(this.legalSellableItems);
                        this.loadCraftHistory();
                    }
                    break;
                case "TEXTUI_SHOW":
                    this.textUIItems = event.data.payload;
                    break;
                case "TEXTUI_HIDE":
                    this.textUIItems = [];
                    break;
                case "openNPCRentalMenu":
                    this.openNPCRentalMenu(event.data);
                    break;
                default:
                    break;
            }
        },
        openNPCRentalMenu(eventData) {
            const data = eventData.data || eventData;
            const depositFormat = data.depositFormat || this.state.locales['npcRentalDeposit'] || 'Deposit: $%s (refundable)';
            this.npcRentalData = {
                title: data.title || this.state.locales['npcRentalTitle'] || 'Vehicle Rental',
                options: (data.options || []).map(opt => ({
                    key: opt.tier,
                    label: opt.label,
                    price: opt.price ? `$${opt.price}` : '',
                    deposit: opt.deposit ? depositFormat.replace('%s', opt.deposit) : '',
                    description: opt.description
                }))
            };
            this.npcRentalShow = true;
        },
        selectTier(tierKey) {
            this.npcRentalShow = false;
            window.postNUI('selectNPCTier', { tier: tierKey });
        },
        closeNPCRentalMenu() {
            this.npcRentalShow = false;
            window.postNUI('closeNPCRentalMenu', {});
        },

    },
    computed: {
        getRegionAwards(region) {
            if (region && region.regionAwards) {
                return region.regionAwards.newMoney || region.regionAwards.money;
            }
            return 0;
        },
        progressPercentage() {
            if (this.playerData.playerXp == null || this.playerData.playerNextXp == null) return 0;
            let percentage = (this.playerData.playerXp / this.playerData.playerNextXp) * 100;
            if (percentage > 100) {
                return 100;
            }
            return percentage;
        },
        displayedRegions() {
            return this.regionData.slice(
                this.state.currentRegionIndex,
                this.state.currentRegionIndex + this.state.regionsPerPage
            );
        },
        displayedDailyMission() {
            return this.playerData.playerDailyMission.slice(
                this.state.currentDailyMissionIndex,
                this.state.currentDailyMissionIndex + this.state.dailyMissionsPerPage
            );
        },
        canGoNext() {
            return this.state.currentRegionIndex + this.state.regionsPerPage < this.regionData.length;
        },
        canGoPrev() {
            return this.state.currentRegionIndex > 0;
        },
        canGoNextDailyMission() {
            return this.state.currentDailyMissionIndex + this.state.dailyMissionsPerPage < this.playerData.playerDailyMission.length;
        },
        canGoPrevDailyMission() {
            return this.state.currentDailyMissionIndex > 0;
        },
        inviteSlots() {
            const totalPlayers = this.playerListData.length + Object.values(this.state.nearbyPlayers).length;
            const missing = 4 - totalPlayers;
            return missing > 0 ? missing : 0;
        },
        visibleInventory() {
            // Determine which items list to use (legal or illegal)
            const activeItemsList = this.state.illegalSellShow
                ? this.illegalSellableItems
                : this.legalSellableItems;

            // Create a list of all sellable items with data from config and inventory
            const sellableItems = activeItemsList.map(configItem => {
                // Find item in player inventory
                const playerItem = this.playerInventory.find(item => item.name === configItem.name);

                // Build image path from config (this will always show the item image from config)
                const imagePath = `${this.inventoryImagePath}${configItem.image}`;

                // Return item with config data and inventory amount
                return {
                    name: configItem.name,
                    label: configItem.label,
                    image: imagePath, // Always use config image, regardless of inventory
                    amount: playerItem ? playerItem.amount : 0,
                    price: configItem.price
                };
            });

            return sellableItems;
        },
        totalSellPrice() {
            if (!this.playerInventory || this.playerInventory.length === 0) return 0;
            return this.playerInventory.reduce((total, item) => {
                const price = this.sellPrices[item.name] || 0;
                return total + (item.amount * price);
            }, 0);
        },
        isPlayerOwner() {
            const ownerPlayer = this.playerListData.find(x => x.playerOwner === true);
            if (!ownerPlayer) return false;
            return this.playerData.playerIdentifier === ownerPlayer.playerIdentifier;
        },
        startButtonText() {
            if (this.state.jobIsActive) {
                // If job is active and player is member (not owner), show leave button
                if (!this.isPlayerOwner) {
                    return this.state.locales['leaveLobby'] || 'Leave Lobby';
                }
                // If job is active and player is owner, show reset button
                return this.state.locales['jobReset'];
            }
            // If job is not active, show start button
            return this.state.locales['jobStart'];
        },
        canCraft() {
            if (!this.craftData || this.craftData.length === 0) return false;

            // Check current recipe index
            const recipe = this.craftData[this.currentIllegalRecipeIndex];
            if (!recipe || !recipe.requiredItems) return false;

            // Check if player has all required items with sufficient count
            return recipe.requiredItems.every(required => {
                const playerItem = this.playerInventory.find(item => item.name === required.name);
                return playerItem && playerItem.amount >= required.amount;
            });
        },
        canCraftLegal() {
            if (!this.legalCraftRecipes || this.legalCraftRecipes.length === 0) return false;

            const recipe = this.legalCraftRecipes[this.currentLegalRecipeIndex];
            if (!recipe || !recipe.requiredItems) return false;

            return recipe.requiredItems.every(required => {
                const playerItem = this.playerInventory.find(item => item.name === required.name);
                return playerItem && playerItem.amount >= required.amount;
            });
        },
        // Illegal craft history
        illegalCompletedHistory() {
            return this.illegalCraftHistory.filter(item => item.status === 'completed');
        },
        illegalPendingHistory() {
            return this.illegalCraftHistory.filter(item => item.status === 'pending');
        },
        // Legal craft history
        legalCompletedHistory() {
            return this.legalCraftHistory.filter(item => item.status === 'completed');
        },
        legalPendingHistory() {
            return this.legalCraftHistory.filter(item => item.status === 'pending');
        },
    }
});

app.use(store).mount("#app");

function clicksound(val, soundEffect) {
    if (soundEffect == false || soundEffect == null) {
        return;
    }
    let audioPath = `./sounds/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}

function stopsound() {
    if (audioPlayer) {
        audioPlayer.stop();
    }
}

// NPC rental menu handled by Vue component in index.html
