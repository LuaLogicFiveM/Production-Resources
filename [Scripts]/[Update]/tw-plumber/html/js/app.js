let audioPlayer = null;
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
            },
            languageTitle: [],
            defaultLogo: 'https://r2.fivemanage.com/biv23I9cFWICSObhZsr4C/LogoNEW.png',
            serverName: 'TWORST',
            scriptName: "Plumber",
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
                    notificationDiv: { top: '40.48vh', left: '81.54vw' }
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
        valveGame: {
            isActive: false,
            isDragging: false,
            lastX: 0,
            currentRotation: 0,
            pressure: 0,
            gameActive: true,
            maxPressure: 100,
            failPressure: 85,
            rotationSpeed: 0.3,
            pressureChangeThreshold: 5,
            totalMovement: 0,
            valveCenter: { x: 0, y: 0 },
            lastAngle: 0,
            currentAngle: 0,
            targetPressureMin: 75,
            targetPressureMax: 84,
            pressureTolerance: 2,
            successHoldTime: 3000,
            successStartTime: null,
            successTimeout: null,
            missionData: null,
            initialResistance: 15,
            normalResistance: 3,
            resistanceThreshold: 60,
            currentResistance: 15,
            isStuck: true
        },
        pipeGame: {
            isActive: false,
            pressure: 0,
            maxPressure: 100,
            targetPressureMin: 75,
            targetPressureMax: 80,
            gameMode: 'close',
            missionData: null,
            successTimeout: null,
            successStartTime: null,
            successHoldTime: 3000
        },
        switchGame: {
            isActive: false,
            notification: {
                message: '',
                show: false
            },
            switchStates: {
                1: false,
                2: false,
                3: false,
                4: false,
                5: false,
                6: false
            },
            correctPositions: {
                1: false,
                2: false,
                3: false,
                4: false,
                5: false,
                6: false
            },
            lightBoxes: [
                { number: 1, isGreen: false },
                { number: 2, isGreen: false },
                { number: 3, isGreen: false },
                { number: 4, isGreen: false },
                { number: 5, isGreen: false },
                { number: 6, isGreen: false }
            ],
            missionData: false
        }
    }),

    watch: {
    },

    beforeDestroy() {
        document.removeEventListener("click", this.handleClickOutside);
        const valve = document.querySelector('.valveBox');
        valve.removeEventListener('mousedown', this.valveMouseDown);
        document.removeEventListener('mousemove', this.valveMouseMove);
        document.removeEventListener('mouseup', this.valveMouseUp);
    },
    mounted() {
        window.addEventListener("keyup", this.keyHandler);
        window.addEventListener("message", this.eventHandler);
        document.addEventListener("click", this.handleClickOutside);

        this.checkInterval = setInterval(() => {
            if (this.notifications.length > 0 && !this.state.settings.moveUI) {
                this.notifications = this.notifications.filter((notification, index, self) =>
                    index === self.findIndex(n => n.message === notification.message)
                );

                this.notifyShow = true;
                let delays = [];
                this.notifications.slice(0, 3).forEach((notification, index) => {
                    const duration = notification.duration || 5000;
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

        const valve = document.querySelector('.valveBox');
        valve.style.cursor = 'grab';
        valve.style.transition = 'transform 0.1s';

        valve.addEventListener('mousedown', this.valveMouseDown);
        document.addEventListener('mousemove', this.valveMouseMove);
        document.addEventListener('mouseup', this.valveMouseUp);

        this.updateValveUI();
    },

    methods: {
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
            if (this.state.selectedRegion) {
                if (this.state.jobIsActive) {
                    clicksound("click.wav", this.playerData.soundEffect);
                    postNUI("resetJob");
                } else {
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
                if (this.state.tutoMenuShow) {
                    this.state.tutoMenuShow = false;
                    postNUI("closeTutoNUI");
                } else if (this.switchGame.isActive) {
                    this.closeSwitchGame();

                }
                else if (this.valveGame.isActive) {
                    this.closeValveGame();
                }
                else {
                    if (!this.state.settings.moveUI) {
                        this.closeNUI();
                    } else {
                        this.state.settings.moveUI = false;
                        this.state.teamShow = false;
                        this.state.requestData.show = false;
                        this.state.mainShow = true;
                        this.state.currentPage = 'settings';
                        $(".newTeamList, .allScoreList, .newInviteSide, .notifyList").removeClass("movable");
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
                this.state.mainShow = true;
                this.state.currentPage = 'settings';
                $(".newTeamList, .allScoreList, .newInviteSide, .notifyList").removeClass("movable");
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

                if (this.notifications.length === 0) {
                    this.notifications.push({
                        message: "You can move the notification",
                        type: "info",
                        duration: 10000
                    });
                }

                this.$nextTick(() => {
                    this.applyUIPositions();
                    this.makeAllUIDraggable();
                });
            }
        },
        applyUIPositions() {
            $(".newTeamList").css(this.state.settings.uiPositions.teamList);
            $(".allScoreList").css(this.state.settings.uiPositions.scoreList);
            $(".newInviteSide").css(this.state.settings.uiPositions.inviteSide);
            $(".notifyList").css(this.state.settings.uiPositions.notificationDiv);

            if (this.state.settings.moveUI) {
                $(".newTeamList, .allScoreList, .newInviteSide, .notifyList").css({
                    'position': 'absolute',
                    'z-index': '999'
                });
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
            }
        },
        makeElementDraggable(selector, positionKey) {
            try {
                $(selector).draggable("instance") && $(selector).draggable("destroy");
            } catch (e) {
                //console.log("Draggable henüz başlatılmamış");
            }

            $(selector).addClass("movable");

            $(selector).draggable({
                containment: "body",
                scroll: false,
                stop: (event, ui) => {
                    const windowWidth = window.innerWidth;
                    const windowHeight = window.innerHeight;

                    const topVh = (ui.position.top / windowHeight * 100).toFixed(2) + 'vh';
                    const leftVw = (ui.position.left / windowWidth * 100).toFixed(2) + 'vw';

                    this.state.settings.uiPositions[positionKey] = { top: topVh, left: leftVw };
                }
            });
        },
        makeAllUIDraggable() {
            this.makeElementDraggable(".newTeamList", "teamList");
            this.makeElementDraggable(".allScoreList", "scoreList");
            this.makeElementDraggable(".newInviteSide", "inviteSide");
            this.makeElementDraggable(".notifyList", "notificationDiv");
        },
        saveSettings() {
            clicksound("click.wav", this.playerData.soundEffect);
            this.state.settings.moveUI = false;
            postNUI("saveSettings", {
                uiPositions: this.state.settings.uiPositions,
                soundEffect: this.playerData.soundEffect,
                locale: this.playerData.locale,
            });

            $(".newTeamList, .allScoreList, .newInviteSide, .notifyList").removeClass("movable");
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
                notificationDiv: { top: '20vh', left: '1vw' }
            };

            this.applyUIPositions()
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


                    this.state.languageTitle.forEach(item => {
                        if (item.value == this.playerData.locale) {
                            this.localeValue = item.label;
                        }
                    });

                    break;
                case "LOAD_LOBBY":
                    this.playerListData = event.data.payload;
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
                case "REFRESH_JOBTASK":
                    this.state.missionScoreData = event.data.payload;
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
                case "CLEAR_COOP_DATA":
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
                case "OPEN_VALVE_GAME":
                    this.valveGame.isActive = true;
                    this.valveGame.gameActive = true;
                    this.valveGame.missionData = event.data.payload;
                    this.resetValveGame();
                    break;
                case "OPEN_SWITCH_GAME":
                    this.switchGame.missionData = event.data.payload;
                    this.initSwitchGame();
                    break;
                case "OPEN_PIPE_GAME":
                    this.pipeGame.missionData = event.data.payload;
                    if (event.data.payload.mode === 'close') {
                        this.closeValve();
                    } else {
                        this.openValve();
                    }
                    break;
                case "UPDATE_PIPE_PRESSURE":
                    if (!this.pipeGame.isActive) return;

                    if (this.pipeGame.gameMode === 'close') {
                        this.pipeGame.pressure -= event.data.payload.change;
                    } else {
                        this.pipeGame.pressure += event.data.payload.change;
                    }

                    this.pipeGame.pressure = Math.max(0, Math.min(this.pipeGame.pressure, this.pipeGame.maxPressure));
                    this.updatePipeUI();

                    if (this.pipeGame.pressure >= this.pipeGame.targetPressureMin &&
                        this.pipeGame.pressure <= this.pipeGame.targetPressureMax) {
                        if (!this.pipeGame.successStartTime) {
                            this.pipeGame.successStartTime = Date.now();
                            this.pipeGame.successTimeout = setTimeout(() => {
                                this.pipeGameSuccess();
                            }, this.pipeGame.successHoldTime);
                        }
                    } else {
                        if (this.pipeGame.successStartTime) {
                            this.pipeGame.successStartTime = null;
                            if (this.pipeGame.successTimeout) {
                                clearTimeout(this.pipeGame.successTimeout);
                                this.pipeGame.successTimeout = null;
                            }
                        }
                    }
                    break;
                case "SET_PIPE_PRESSURE":
                    if (!this.pipeGame.isActive) return;
                    this.pipeGame.pressure = event.data.payload.pressure;
                    this.pipeGame.pressure = Math.max(0, Math.min(this.pipeGame.pressure, this.pipeGame.maxPressure));
                    this.updatePipeUI();

                    if (this.pipeGame.pressure >= this.pipeGame.targetPressureMin &&
                        this.pipeGame.pressure <= this.pipeGame.targetPressureMax) {
                        if (!this.pipeGame.successStartTime) {
                            this.pipeGame.successStartTime = Date.now();
                            this.pipeGame.successTimeout = setTimeout(() => {
                                this.pipeGameSuccess();
                            }, this.pipeGame.successHoldTime);
                        }
                    } else {
                        if (this.pipeGame.successStartTime) {
                            this.pipeGame.successStartTime = null;
                            if (this.pipeGame.successTimeout) {
                                clearTimeout(this.pipeGame.successTimeout);
                                this.pipeGame.successTimeout = null;
                            }
                        }
                    }
                    break;
                case "CLOSE_PIPE_GAME":
                    this.pipeGame.isActive = false;
                    this.resetPipeGame();
                    break;
                default:
                    break;
            }
        },
        valveMouseDown(e) {
            if (!this.valveGame.gameActive) return;
            this.valveGame.isDragging = true;
            const valve = document.querySelector('.valveBox');
            valve.style.cursor = 'grabbing';

            const valveRect = valve.getBoundingClientRect();
            this.valveGame.valveCenter = {
                x: valveRect.left + valveRect.width / 2,
                y: valveRect.top + valveRect.height / 2
            };

            this.valveGame.lastAngle = this.getAngle(e.clientX, e.clientY);
        },
        valveMouseMove(e) {
            if (!this.valveGame.isDragging || !this.valveGame.gameActive) return;

            const newAngle = this.getAngle(e.clientX, e.clientY);
            let deltaAngle = newAngle - this.valveGame.lastAngle;

            if (deltaAngle > 180) deltaAngle -= 360;
            if (deltaAngle < -180) deltaAngle += 360;

            if (this.valveGame.isStuck) {
                deltaAngle = deltaAngle / this.valveGame.currentResistance;

                if (Math.abs(this.valveGame.currentRotation) >= this.valveGame.resistanceThreshold) {
                    this.valveGame.isStuck = false;
                    this.valveGame.currentResistance = this.valveGame.normalResistance;

                    const valve = document.querySelector('.valveBox');
                    valve.style.transition = 'transform 0.1s';
                    const currentRotation = this.valveGame.currentRotation;

                    valve.style.transform = `rotate(${currentRotation + 5}deg)`;
                    setTimeout(() => {
                        valve.style.transform = `rotate(${currentRotation}deg)`;
                        valve.style.transition = 'transform 0s';
                    }, 100);

                    clicksound("click.wav", this.playerData.soundEffect);
                }
            } else {
                deltaAngle = deltaAngle / this.valveGame.normalResistance;
            }

            this.valveGame.currentRotation += deltaAngle;
            const valve = document.querySelector('.valveBox');
            valve.style.transform = `rotate(${this.valveGame.currentRotation}deg)`;

            this.valveGame.pressure += (deltaAngle * this.valveGame.rotationSpeed / 10);
            this.valveGame.pressure = Math.max(0, Math.min(this.valveGame.pressure, this.valveGame.maxPressure));

            this.updateValveUI();

            if (this.valveGame.pressure >= this.valveGame.failPressure) {
                this.gameFailed();
            } else if (this.valveGame.pressure >= this.valveGame.targetPressureMin && this.valveGame.pressure <= this.valveGame.targetPressureMax) {
                if (!this.valveGame.successStartTime) {
                    this.valveGame.successStartTime = Date.now();
                    const pressureBar = document.querySelector('.rangeBarIn');
                    pressureBar.style.backgroundColor = '#2ecc71';

                    const progressBar = document.createElement('div');
                    progressBar.style.position = 'fixed';
                    progressBar.style.top = '10px';
                    progressBar.style.left = '50%';
                    progressBar.style.transform = 'translateX(-50%)';
                    progressBar.style.width = '200px';
                    progressBar.style.height = '5px';
                    progressBar.style.backgroundColor = '#34495e';
                    progressBar.className = 'progress-bar';
                    document.body.appendChild(progressBar);

                    const progress = document.createElement('div');
                    progress.style.width = '0%';
                    progress.style.height = '100%';
                    progress.style.backgroundColor = '#2ecc71';
                    progress.style.transition = 'width 3s linear';
                    progressBar.appendChild(progress);

                    setTimeout(() => {
                        progress.style.width = '100%';
                    }, 50);

                    this.valveGame.successTimeout = setTimeout(() => {
                        this.gameSuccess();
                        document.body.removeChild(progressBar);
                    }, this.valveGame.successHoldTime);
                }
            } else {
                if (this.valveGame.successStartTime) {
                    this.valveGame.successStartTime = null;
                    if (this.valveGame.successTimeout) {
                        clearTimeout(this.valveGame.successTimeout);
                        this.valveGame.successTimeout = null;
                    }
                    const progressBar = document.querySelector('.progress-bar');
                    if (progressBar) {
                        document.body.removeChild(progressBar);
                    }
                    const pressureBar = document.querySelector('.rangeBarIn');
                    pressureBar.style.backgroundColor = '#3498db';
                }
            }

            this.valveGame.lastAngle = newAngle;
        },
        valveMouseUp() {
            this.valveGame.isDragging = false;
            const valve = document.querySelector('.valveBox');
            valve.style.cursor = 'grab';
        },
        updateValveUI() {
            const pressureBar = document.querySelector('.rangeBarIn');
            const speedoLine = document.querySelector('.speedoLine');

            pressureBar.style.height = `${this.valveGame.pressure}%`;
            pressureBar.style.backgroundColor = this.valveGame.pressure >= this.valveGame.failPressure ? 'red' : '#3498db';
            speedoLine.style.transform = `rotate(${(this.valveGame.pressure / this.valveGame.maxPressure) * 180}deg)`;
        },
        gameFailed() {
            this.valveGame.gameActive = false;
            postNUI("valveGameResult", { success: false, id: this.valveGame.missionData });
            this.valveGame.isActive = false;
            setTimeout(() => {
                this.resetValveGame();
            }, 1000);
        },
        gameSuccess() {
            this.valveGame.gameActive = false;
            postNUI("valveGameResult", { success: true, id: this.valveGame.missionData });
            this.valveGame.isActive = false;
            setTimeout(() => {
                this.resetValveGame();

            }, 1000);
        },
        resetValveGame() {
            this.valveGame.gameActive = true;
            this.valveGame.pressure = 0;
            this.valveGame.currentRotation = 0;
            this.valveGame.currentAngle = 0;
            this.valveGame.lastAngle = 0;
            this.valveGame.successStartTime = null;
            this.valveGame.isStuck = true;
            this.valveGame.currentResistance = this.valveGame.initialResistance;

            if (this.valveGame.successTimeout) {
                clearTimeout(this.valveGame.successTimeout);
                this.valveGame.successTimeout = null;
            }
            const valve = document.querySelector('.valveBox');
            valve.style.transform = `rotate(0deg)`;
            valve.style.transition = 'transform 0s';
            const pressureBar = document.querySelector('.rangeBarIn');
            pressureBar.style.backgroundColor = '#3498db';

            const progressBar = document.querySelector('.progress-bar');
            if (progressBar) {
                document.body.removeChild(progressBar);
            }

            this.updateValveUI();
        },
        getAngle(x, y) {
            const deltaX = x - this.valveGame.valveCenter.x;
            const deltaY = y - this.valveGame.valveCenter.y;

            let angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI;

            if (angle < 0) {
                angle += 360;
            }

            return angle;
        },
        toggleSwitch(switchNumber) {
            clicksound("switch.mp3", this.playerData.soundEffect);
            this.switchGame.switchStates[switchNumber] = !this.switchGame.switchStates[switchNumber];
            this.updateSwitchLight(switchNumber);
            this.checkSwitchWin();
        },

        updateSwitchLight(lightNumber) {
            const lightIndex = this.switchGame.lightBoxes.findIndex(light => light.number === lightNumber);
            if (lightIndex !== -1) {
                const isCorrectPosition = (this.switchGame.switchStates[lightNumber] === this.switchGame.correctPositions[lightNumber]);
                this.switchGame.lightBoxes[lightIndex].isGreen = isCorrectPosition;
            }
        },

        showSwitchNotification(message, duration = 1500) {
            this.switchGame.notification.message = message;
            this.switchGame.notification.show = true;

            setTimeout(() => {
                this.switchGame.notification.show = false;
            }, duration);
        },

        getRandomInt(min, max) {
            return Math.floor(Math.random() * (max - min + 1)) + min;
        },

        shuffleSwitchLights() {
            const numbers = [1, 2, 3, 4, 5, 6];
            for (let i = numbers.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [numbers[i], numbers[j]] = [numbers[j], numbers[i]];
            }

            for (let i = 1; i <= 6; i++) {
                this.switchGame.correctPositions[i] = true;
            }

            const greenLightCount = this.getRandomInt(1, 3);
            const selectedLights = new Set();

            while (selectedLights.size < greenLightCount) {
                const randomNumber = Math.floor(Math.random() * 6) + 1;
                if (!selectedLights.has(randomNumber)) {
                    selectedLights.add(randomNumber);
                    this.switchGame.correctPositions[randomNumber] = false;
                }
            }

            this.switchGame.lightBoxes = numbers.map(number => {
                const isGreen = this.switchGame.correctPositions[number] === false;
                return {
                    number: number,
                    isGreen: isGreen
                };
            });
        },

        initSwitchGame() {
            this.switchGame.isActive = true;

            for (let i = 1; i <= 6; i++) {
                this.switchGame.switchStates[i] = false;
            }

            this.shuffleSwitchLights();
        },

        checkSwitchWin() {
            const allGreen = this.switchGame.lightBoxes.every(light => light.isGreen);

            if (allGreen) {
                this.showSwitchNotification('GÖREV TAMAMLANDI!');

                setTimeout(() => {
                    this.switchGame.isActive = false;
                    postNUI("minigameClose", { success: true, switchData: this.switchGame.missionData });
                }, 1500);
            }
        },

        closeSwitchGame() {
            this.switchGame.isActive = false;
            postNUI("minigameClose", { success: false, switchData: this.switchGame.missionData });
        },

        closeValveGame() {
            this.valveGame.isActive = false;
            postNUI("valveGameResult", { success: false, id: this.valveGame.missionData });
        },

        openValve() {
            this.pipeGame.isActive = true;
            this.pipeGame.gameMode = 'open';
            this.pipeGame.pressure = 0;
            this.updatePipeUI();
        },

        closeValve() {
            this.pipeGame.isActive = true;
            this.pipeGame.gameMode = 'close';
            this.pipeGame.pressure = 50;
            this.updatePipeUI();
        },

        updatePipeUI() {
            const pressureBar = document.querySelector('.minigame3 .rangeBarIn');
            if (!pressureBar) return;

            pressureBar.style.height = `${this.pipeGame.pressure}%`;
            pressureBar.style.backgroundColor =
                (this.pipeGame.pressure >= this.pipeGame.targetPressureMin &&
                    this.pipeGame.pressure <= this.pipeGame.targetPressureMax) ?
                    '#2ecc71' : '#3498db';
        },

        pipeGameSuccess() {
        },

        resetPipeGame() {
            this.pipeGame.pressure = this.pipeGame.gameMode === 'close' ? 50 : 0;
            if (this.pipeGame.successTimeout) {
                clearTimeout(this.pipeGame.successTimeout);
                this.pipeGame.successTimeout = null;
            }
            this.pipeGame.successStartTime = null;
            this.updatePipeUI();
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
    }
});

app.use(store).mount("#app");
var resourceName = "tworst-plumber";

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
