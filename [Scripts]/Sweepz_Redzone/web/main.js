const { createApp } = Vue;

window.postNUI = async (name, data) => {
  try {
    const response = await fetch(`https://Sweepz_Redzone/${name}`, {
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
    return await response.json()
  } catch (error) {
    return null;
  }
};

const app = createApp({
  data() {
    return {
      isFlex: false,
      isFlex2: false,
      myKilledPlayers: "0",
      tottalkkills: "0",
      thisleaderkills: "0",
      thiszone: {},
      thiszone2: {},
      mysiralama: 1,
    };
  },
  watch: {},
  methods: {
    messageHandler(event) {
      switch (event.data.action) {
        case "open2":
          if (!this.isFlex2) {
            this.isFlex2 = true;
          }
          this.thiszone2 = event.data.zone;
          break;
        case "open":
          this.thiszone = event.data.zone;
          if (!this.isFlex) {
            this.isFlex = true;
          }
        
          if (event.data.zone.kills) {
            this.tottalkkills = Object.values(event.data.zone.kills).reduce((total, kills) => total + kills, 0);
        
            const killsArray = Object.entries(event.data.zone.kills).map(([id, kills]) => ({ id, kills }));
        
            killsArray.sort((a, b) => b.kills - a.kills);
        
            const myIndex = killsArray.findIndex(entry => entry.id === String(event.data.myId));
        
            this.mysiralama = myIndex !== -1 ? myIndex + 1 : null;
          }

          if (event.data.zone.leadersrc) {
            this.thisleaderkills = event.data.zone.kills[event.data.zone.leadersrc]
          }
        
          if (String(event.data.zone.leadersrc) && event.data.zone.kills[String(event.data.zone.leadersrc)]) {
            this.leaderkills = event.data.zone.kills[String(event.data.zone.leadersrc)];
          }
        
          if (String(event.data.myId) && event.data.zone.kills[String(event.data.myId)]) {
            this.myKilledPlayers = event.data.zone.kills[String(event.data.myId)];
          }
          break;
        case "close":
          if (this.isFlex) {
            this.isFlex = false;
          }
          break;
        case "close2":
          if (this.isFlex2) {
            this.isFlex2 = false;
          }
          break;
        default: break;
      };
    }
  },
  computed: {},
  mounted() {
    window.addEventListener("message", this.messageHandler);
    window.addEventListener("keyup", this.keyHandler);
    postNUI("uiLoaded");
  },
  beforeDestroy() {
    window.removeEventListener("message", this.messageHandler);
    window.removeEventListener("keyup", this.keyHandler);
  },
});


app.mount("#app");