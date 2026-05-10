let lobbysettingsmenu = false;
let lobbycreated = false;
let inlobby = false;
var closing = false;
var cfg = null;
var Locales;
var setupLocation = null;
window.addEventListener('message', function(event) {
    var data = event.data;
    if(data.event=="open"){
      cfg = data.cfg
      setupLocation = data.setupLocation
      if (!cfg.wagering) {
        var wagerbox = document.getElementById("wage");
        wagerbox.style.pointerEvents = "none";
        wagerbox.value = 0;
      }
      if (closing === false) {
        var paintballui = document.querySelector(".paintballui");
        paintballui.style.display = "flex";
        for (var i = 0; i < data.lobbies.length; i++) {
          var currentItem = data.lobbies[i];
          if(currentItem!="finished"){
            addListItem(currentItem)
          }
        }
      }
    }else if(data.event=="setLobby"){
      finishCreateLobby(data.lobby)
    }else if(data.event=="addLobby"){
      var player = true;
      addListItem(data.lobby)
    }else if(data.event=="addPlayers"){
      addToCount(data)
    }else if(data.event=="deleteLobby"){
      deleteLobby(data.lobby)
    }else if(data.event=="updatePlayerCount"){
      updateplayercount(data)
    }else if(data.event=="updateHTML"){
      updateListItem(data)
    }else if(data.event=="updatePlayerLobby"){
      updatePlayerLobby(data)
    }else if(data.event=="gameStarted"){
      fullCloseMenu()

      var killFeed = document.querySelector(".feedCont")
      var kilList = document.querySelector(".feedList")
      killFeed.style.display = "block";
      kilList.innerHTML = ``;
    }else if(data.event=="cannotStart"){
      startlobbyerror()
    }else if(data.event=="openPopUpHost"){
      closehostui(data.id)
    }else if(data.event=="removeHostUIButtons"){
        removeHostUIButtons(data.id)
    }else if(data.event=="openPopUpPlayer"){
      closeplayerui(data.id)
    }else if(data.event =="lobbyDeleted"){
      quitplayerui(data)
    }else if(data.event == "sendError"){
      sendError(data)
    }else if(data.event == "joinLobby"){
      joinLobby(data)
    }else if(data.event == "updatelobbybutton"){
      updatelobbybutton(data.lobby, data.status)
    }else if(data.event == "ingameHUD"){
      showingameteamui(data.lobby, data.status, data.pid)
    }else if(data.event == "startTimer"){
      startTimer(data.time, data.show)
    }else if(data.event == "playSound"){
      playSound(data.name, data.status)
    }else if(data.event == "updateHealth"){
      updatehealth(data.health)
    }else if(data.event == "leaderboard"){
      if (data.data.mode == "FFA" || data.data.mode == "Gun Game") {
        openLeaderboard(data.data, data.status)
      } else {
        LoadTeamLeaderboard(data.data, data.status)
      }
    }else if(data.event == "addKillfeed"){
      addKillfeed(data.data)
    } else if (data.event == "updateMiniScore") {
      updateMiniScore(data.data)
    } else if(data.event == "showMiniScore"){
      showMiniScore(data)
    }
});

$(document).keyup(function(event) {
  if (event.which == 27){
      closeMenu()
    return
  }
});

function joinLobby(data){
  joinplayerui(data.lobby)
}

function deleteLobby(id){
  var deletelobby = document.querySelector(`li[data-lobby-id="${id}"]`);
  if (deletelobby) {
    deletelobby.remove();
  }
}

function sendError(data){
  if (data.error=="wagerTooHigh"){
    var popup = document.querySelector("#errorpopup3");

    popup.style.display = "flex";
    popup.style.opacity = "1";
    popup.style.textContent = Locales["insuffcient_funds"];
    popup.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
    popup.style.animation = "shake 0.3s ease";
    popup.style.transition = "0.3s ease";

    setTimeout(function() {
      popup.style.opacity = "0";
      popup.style.outline = "";
      popup.style.animation = "";
      popup.style.transition = "";
        setTimeout(function() {
          popup.style.display = "none";
      }, 200);
  }, 4000);
  }
}

function closeMenu() {

  $.post(`https://${GetParentResourceName()}/tryclosemenu`);
}

function fullCloseMenu() {

  $.post(`https://${GetParentResourceName()}/closemenu`);

  var mainmenu = $(".paintballui");
  var popup = $(".popup");

  closing = true;

    mainmenu.hide();
    popup.hide();
    const lobbylist = document.querySelector('.lobbylist');
    while (lobbylist.hasChildNodes()) {
      lobbylist.removeChild(lobbylist.firstChild);
    }
  closing = false;
}

function showingameteamui(data, status, pid) {
  var topleftteams = document.querySelector(".topleftteams");
  var teamlist = document.querySelector(".teamui");
  var teamuilives = document.querySelector(".teamuilives");
  var healthbar = document.querySelector(".health-bar");


  if (status) {

  topleftteams.style.display = "block";
  teamuilives.style.display = "block";
  healthbar.style.display = "block";
  teamlist.innerHTML = "";

      if (data.settings.mode === "Teams") {
        for (var i = 0; i < data.settings.numberOfTeams; i++) {
          
          var newlistitem = document.createElement('li');
          var teamcolor = document.createElement('span');
          var teamlives = document.createElement('span');
          teamcolor.classList.add("teamcolor");
          teamlives.classList.add("teamlives");
      
          teamcolor.style.backgroundColor = `${cfg.teams[i].color}`;
          if (data.teams[i] == null || data.teams[i].teamLives <= 0){
            teamlives.innerHTML = Locales["eliminated"];
          }else{
            teamlives.innerHTML = Locales["teamlives"] + data.teams[i].teamLives;
          }
          
          if(data.teams[i] != null) {
            if(data.teams[i].players != null) {
              if(data.teams[i].players[pid.toString()] != null){
                teamuilives.innerHTML = "";
                for (var j = 0; j < data.teams[i].players[pid.toString()].lives; j++) {
                  var heart = document.createElement('i');
                  heart.classList.add('fa-solid', 'fa-heart');
                  heart.classList.add('lives-heart');
                  teamuilives.appendChild(heart);
                }
              }
            }
          }
    
      
          teamlist.appendChild(newlistitem);
          newlistitem.appendChild(teamcolor);
          newlistitem.appendChild(teamlives);
        }
      } else if (data.settings.mode === "FFA") {
        if(data.unassigned[pid.toString()] != null){
          teamuilives.innerHTML = "";
          for (var j = 0; j < data.unassigned[pid.toString()].lives; j++) {
            var heart = document.createElement('i');
            heart.classList.add('fa-solid', 'fa-heart');
            heart.classList.add('lives-heart');
            teamuilives.appendChild(heart);
          }
        }
      }

  } else {
  
    teamlist.innerHTML = "";
    topleftteams.style.display = "none";
    teamuilives.style.display = "none";
    healthbar.style.display = "none";
  }
}

function showMiniScore(data) {
  var dogTags = document.querySelector(".dogTags");

  if (data.status) {
    dogTags.style.display = "block";

    var firstimage = document.querySelector(".firstImg");
    var secondimage = document.querySelector(".secondImg");
  
    if (data.mode == "CTF") {
      firstimage.src = "images/redflag.png";
      secondimage.src = "images/blueflag.png";
    } else if (data.mode === "Dog Tags") {
      firstimage.src = "images/dogtag.png";
      secondimage.src = "images/dogtag.png";
    } else if (data.mode === "Team Deathmatch") {
      firstimage.src = "";
      secondimage.src = "";
    }
  
  } else {
    dogTags.style.display = "none";
  }
}

let previousData = {
  teams: [
    { points: 0 },
    { points: 0 }
  ]
};


function updateMiniScore(data) {
  var One = document.getElementById("dog-one");
  var Two = document.getElementById("dog-two");

  var teamOneNumber = document.querySelector("#dogcount-red");
  var teamTwoNumber = document.querySelector("#dogcount-blue");

  if (data.teams[0].points !== previousData.teams[0].points) {
    teamOneNumber.classList.add('animate__animated', 'animate__fadeInDown');
    teamOneNumber.addEventListener("animationend", function() {
      teamOneNumber.classList.remove('animate__animated', 'animate__fadeInDown');
    });
  }

  if (data.teams[1].points !== previousData.teams[1].points) {
    teamTwoNumber.classList.add('animate__animated', 'animate__fadeInDown');
    teamTwoNumber.addEventListener("animationend", function() {
      teamTwoNumber.classList.remove('animate__animated', 'animate__fadeInDown');
    });
  }

  previousData.teams[0].points = data.teams[0].points;
  previousData.teams[1].points = data.teams[1].points;
  

  One.innerHTML = cfg.teams[0].name; 
  Two.innerHTML = cfg.teams[1].name;
  

  One.style.color = cfg.teams[0].color;
  Two.style.color = cfg.teams[1].color;
  
  teamOneNumber.innerHTML = data.teams[0].points || 0;
  teamTwoNumber.innerHTML = data.teams[1].points || 0;
}
  

function updatehealth(data) {
  var health = ((data/cfg.defaultHealth)*100)
  var healthbar = document.getElementById("health");

  healthbar.style.width = health + "%";
}

const AudioManager = {
  sounds: {},
  volumes: {
    openingAnimation: 0.2,
    backgroundAmbience: 0.02,
    killSound: 0.02,
    click: 0.05
  },
  
  preloadAudio() {
    // Preload audio files
    const audioFiles = {
      openingAnimation: 'sounds/introsound.mp3',
      backgroundAmbience: 'sounds/stadiumsound.mp3',
      killSound: 'sounds/killsound.mp3',
      click: 'sounds/clicksound.mp3'
    };
    
    for (const [key, path] of Object.entries(audioFiles)) {
      const audio = new Audio(path);
      audio.preload = 'auto';
      this.sounds[key] = audio;
    }
  },
  
  playSound(name, status) {
    if (status) {
      const sound = this.sounds[name];
      if (!sound) return;
      
      sound.volume = this.volumes[name] || 0.1;
      
      if (name === 'backgroundAmbience') {
        sound.loop = true;
      } else {
        sound.loop = false;
      }
      
      // Reset and play
      sound.currentTime = 0;
      sound.play().catch(e => console.warn('Audio play failed:', e));
      
    } else {
      const sound = this.sounds[name];
      if (!sound) return;
      
      sound.pause();
      sound.currentTime = 0;
    }
  },
  
  cleanup() {
    for (const sound of Object.values(this.sounds)) {
      sound.pause();
      sound.currentTime = 0;
      sound.src = '';
    }
    this.sounds = {};
  }
};

// Initialize audio on page load
document.addEventListener('DOMContentLoaded', function() {
  AudioManager.preloadAudio();
  
  // Set up click sound for interactive elements
  const soundElements = document.querySelectorAll('*');
  soundElements.forEach(function(element) {
    element.addEventListener('click', function() {
      AudioManager.playSound('click', true);
    });
  });
});

// Replace existing playSound function
function playSound(name, status) {
  AudioManager.playSound(name, status);
}

// Add cleanup on page unload
window.addEventListener('unload', function() {
  AudioManager.cleanup();
});

var timerInterval; // Declare this outside the function to make it shared

function startTimer(time, show) {
  if(typeof(time) == "string") {     
    return
  }
  var timerDisplay = document.getElementById('timer');

  // Clear any existing timer intervals
  clearInterval(timerInterval);

  if (show) {
    var totalSeconds = time;
    var endTime = Date.now() + (totalSeconds * 1000);
    timerDisplay.style.display = "flex";

    timerInterval = setInterval(function() {
      var now = Date.now();
      var remaining = Math.max(0, Math.ceil((endTime - now) / 1000));
      var mins = Math.floor(remaining / 60);
      var secs = remaining % 60;

      var newText = ('' + mins).slice(-2) + ':' + ('0' + secs).slice(-2);
      if (timerDisplay.textContent !== newText) {
        timerDisplay.textContent = newText;
      }

      if (remaining <= 0) {
        clearInterval(timerInterval);
        timerDisplay.textContent = Locales["timesup"];
        timerDisplay.style.color = "Red";
      } else {
        if (remaining <= 30) {
          if (timerDisplay.style.color !== "Red") {
            timerDisplay.style.color = "Red";
          }
        } else if (timerDisplay.style.color === "Red") {
          timerDisplay.style.color = "";
        }
      }
    }, 100); // Update more frequently for better accuracy
  } else {
    timerDisplay.style.display = "none";
    timerDisplay.textContent = "";
  }
}



function closehostui(lobbyid) {
  var popup = document.querySelector(".popup");
  var stay = document.getElementById("stay");
  var leave = document.getElementById("leave");
  var xmark = document.querySelector(".fa-circle-xmark");
  var cancellobby = document.getElementById('cancellobby');
  var createLobbyButton = document.getElementById('createlobby');
  //var optionlistid = document.querySelector(`.options[data-lobby-id="${lobbyid}"]`);
  var optionselem = document.querySelector(".options");
  optionselem.setAttribute('data-lobby-id', lobbyid);
  var optionlistid = document.querySelector(`.options[data-lobby-id="${lobbyid}"]`);
  var creationbuttons = document.querySelector(`.creationbuttons[data-lobby-id="${lobbyid}"]`);
  var indicator = optionlistid.querySelector('.indicator')
  var playerlist = document.querySelector(".players");
  var private = document.getElementById("private");
  var privatetext = document.querySelector(".privatelabel");
  var password = document.querySelector("#password");
  playerlist.setAttribute('data-lobby-id', lobbyid);
  var playerlistid = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  var playerlistinner = playerlistid.querySelector(`.playerlist`);
  var carousel = document.querySelector(".carouselcont");
  //var playerlist = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  inlobby === false;

  popup.style.display = "flex";
  popup.style.opacity = "1";
  leave.innerHTML = Locales["delete"];

  stay.addEventListener('click', function() {
    popup.style.opacity = "0";

    setTimeout(function() {
      popup.style.display = "none";
    }, 300);
  });

  xmark.addEventListener('click', function() {
    popup.style.opacity = "0";

    setTimeout(function() {
      popup.style.display = "none";
    }, 300);
  });

  leave.addEventListener('click', function() {
    popup.style.opacity = "0";

    setTimeout(function() {
      popup.style.display = "none";
    }, 300);

    if (indicator) {
      indicator.removeAttribute('clicked');
      indicator.removeAttribute('mode', 'teams');
      indicator.removeAttribute('mode', 'ffa');
      indicator.removeAttribute('mode', 'arcade');
    }

    
    playerlist.removeAttribute('data-lobby-id', lobbyid);
    playerlistinner.removeAttribute('data-lobby-id', lobbyid);
  
    /*lives.innerHTML = "";
    weaponselector.innerHTML = "";
    timeamount.innerHTML = "";*/

    clearCarousel();
    
    var settingmenu = document.querySelector(".lobbycreator");
    

    settingmenu.style.width = "0px";
    settingmenu.style.opacity = "0";
    private.style.pointerEvents = "auto";
    privatetext.style.pointerEvents = "auto";
    password.style.pointerEvents = "auto";
    carousel.style.pointerEvents = "auto";
    //playerlistinner.innerHTML = "";
    lobbycreated = false;

    /*var allElements = document.querySelectorAll('*');
    allElements.forEach(function(element) {
        element.style.cssText = ''; 
    });*/

    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'deleteLobby',
      id: lobbyid,
    }));

    /*var teamlists = document.querySelector('.teamlist');

    teamlists.innerHTML = "";*/
    var deletbtn = creationbuttons.querySelector(".deletebutton");
    var start = creationbuttons.querySelector(".startlobbybtn");

    if (deletbtn && start) {
      creationbuttons.removeChild(deletbtn);
      creationbuttons.removeChild(start);
    }
    creationbuttons.appendChild(createLobbyButton);
    creationbuttons.appendChild(cancellobby);

    const lobbylist = document.querySelector('.lobbylist');
    while (lobbylist.hasChildNodes()) {
      lobbylist.removeChild(lobbylist.firstChild);
    }

    $.post(`https://${GetParentResourceName()}/getLobbies`, JSON.stringify({}), function(data) {
      var paintballui = document.querySelector(".paintballui");
        paintballui.style.display = "flex";
        for (var i = 0; i < data.length; i++) {
          var currentItem = data[i];
          if(currentItem!="finished"){
            if(currentItem.id!=lobbyid){
              addListItem(currentItem)
            }
          }
        }
    });
  });
}

function removeHostUIButtons(lobbyid){
  var creationbuttons = document.querySelector(`.creationbuttons[data-lobby-id="${lobbyid}"]`);
  var cancellobby = document.getElementById('cancellobby');
  var createLobbyButton = document.getElementById('createlobby');


  var deletbtn = creationbuttons.querySelector(".deletebutton");
  var start = creationbuttons.querySelector(".startlobbybtn");

  if (deletbtn && start) {
    creationbuttons.removeChild(deletbtn);
    creationbuttons.removeChild(start);
  }
  creationbuttons.appendChild(createLobbyButton);
  creationbuttons.appendChild(cancellobby);
}


function quitplayerui(data) {
  var lobbyid = data.id;
  var settingsmenu = document.querySelector(`.lobbycreator`);
  var leavelobby = document.querySelector(`.leavelobby[data-lobby-id="${lobbyid}"]`);
  var creationbuttons = document.querySelector(`.creationbuttons`);
  var playerlist = document.querySelector(".players");
  playerlist.setAttribute('data-lobby-id', lobbyid);
  var playerlistid = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  var playerlistinner = playerlistid.querySelector(`.playerlist`);
  var carouselcont =  document.querySelector(`.carouselcont[data-lobby-id="${lobbyid}"]`);
  inlobby === false;

  settingsmenu.style.width = "0px";
  settingsmenu.style.opacity = "0";
  playerlist.style.height = "0px";
  playerlistinner.innerHTML = "";
  playerlist.style.opacity = "0";

  if (creationbuttons && leavelobby) {
    creationbuttons.removeChild(leavelobby);
  }

  
  var elementsToDisable = [
    "#wage",
    "#lives",
    "#time",
    ".teamamount",
    ".indicator",
    "#teams",
    "#weaponselect",
    ".spectating",
    "#arcademodes",
    "#score",
  ];

  elementsToDisable.forEach(function(elementSelector) {
      var elements = document.querySelectorAll(elementSelector);
      elements.forEach(function(element) {
          element.style.pointerEvents = 'auto';
      });
  });
  carouselcont.style.pointerEvents = 'auto';

  lobbysettingsmenu = false;
  lobbycreated = false;

  const lobbylist = document.querySelector('.lobbylist');
    while (lobbylist.hasChildNodes()) {
      lobbylist.removeChild(lobbylist.firstChild);
    }

  /*$.post(`https://${GetParentResourceName()}/getLobbies`, JSON.stringify({}), function(data) {
      var paintballui = document.querySelector(".paintballui");
        paintballui.style.display = "flex";
        for (var i = 0; i < data.length; i++) {
          var currentItem = data[i];
          if(currentItem!="finished"){
            addListItem(currentItem)
          }
        }
    });*/
}


function closeplayerui(lobbyid) {
  var popup = document.querySelector(".popup");
  var text = document.querySelector(".inner-text p");
  var stay = document.getElementById("stay");
  var leave = document.getElementById("leave");
  var xmark = document.querySelector(".fa-circle-xmark");
  var leavelobby = document.querySelector(`.leavelobby[data-lobby-id="${lobbyid}"]`);
  var createbutton = document.querySelector(`#createlobby`);
  var cancelbutton = document.querySelector(`#cancellobby`);
  var creationbuttons = document.querySelector(`.creationbuttons`);
  var playerlist = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  var mapcont = document.querySelector(`.carouselcont[data-lobby-id="${lobbyid}"]`);
  var settingsmenu = document.querySelector(`.lobbycreator`);
  inlobby === false;

  text.innerHTML = Locales["leavelobby"]; 
  leave.innerHTML = Locales["popup_leave"]
  popup.style.display = "flex";
  popup.style.opacity = "1";

  stay.addEventListener('click', function() {
    popup.style.opacity = "0";

    setTimeout(function() {
      popup.style.display = "none";
    }, 300);
  });

  xmark.addEventListener('click', function() {
    popup.style.opacity = "0";

    setTimeout(function() {
      popup.style.display = "none";
    }, 300);
  });

  leave.addEventListener('click', function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'leaveGame',
      id: lobbyid,
    }));

    leavelobby.removeEventListener('click', joinplayerui);
    
    settingsmenu.style.width = "0px";
    settingsmenu.style.opacity = "0";
    playerlist.style.height = "0";
    playerlist.style.opacity = "0";
    mapcont.style.display = "none";
    popup.style.display = "none";
    if (creationbuttons && leavelobby && creationbuttons.contains(leavelobby)) {
      creationbuttons.removeChild(leavelobby);
  }
    
    var joinbutton = document.querySelector(`.joinbutton[data-lobby-id="${lobbyid}"]`);

    if (joinbutton) {
      joinbutton.textContent = Locales["join"];
    }

    var elementsToDisable = [
        "#wage",
        "#lives",
        "#time",
        ".teamamount",
        ".indicator",
        "#teams",
        "#weaponselect",
        ".spectating",
        "#arcademodes",
        ".carouselcont",
        "#score",
    ];
    
    elementsToDisable.forEach(function(elementSelector) {
        var elements = document.querySelectorAll(elementSelector);
        elements.forEach(function(element) {
            element.style.pointerEvents = 'auto';
        });
    });
    mapcont.style.pointerEvents = 'auto';

    lobbycreated = false;
    lobbysettingsmenu = false;

    const lobbylist = document.querySelector('.lobbylist');
    while (lobbylist.hasChildNodes()) {
      lobbylist.removeChild(lobbylist.firstChild);
    }

    $.post(`https://${GetParentResourceName()}/getLobbies`, JSON.stringify({}), function(data) {
      var paintballui = document.querySelector(".paintballui");
        paintballui.style.display = "flex";
        for (var i = 0; i < data.length; i++) {
          var currentItem = data[i];
          if(currentItem!="finished"){
            addListItem(currentItem)
          }
        }
    });

    createbutton.style.display = "block";
    cancelbutton.style.display = "block";
  });
}


function finishCreateLobby(data){
  lobbysettingsmenu = false;
  var lobbyopencheck = true;
  var lobbyid = data.id;
  var cancellobby = document.getElementById('cancellobby');
  var createLobbyButton = document.getElementById('createlobby');
  var deletebutton = document.createElement('button');
  var startlobby = document.createElement('button');
  var playerlist = document.querySelector('.players');
  var playerlistinner = document.querySelector('.playerlist');
  var optionlist = document.querySelector('.options');
  var creationbuttons = document.querySelector('.creationbuttons');


  playerlist.style.height = "300px";
  playerlist.style.opacity = "1";
  
  optionlist.setAttribute('data-lobby-id', lobbyid);
  playerlistinner.setAttribute('data-lobby-id', lobbyid);
  playerlist.setAttribute('data-lobby-id', lobbyid);
  var optionlistid = document.querySelector(`.options[data-lobby-id="${lobbyid}"]`);
  creationbuttons.setAttribute('data-lobby-id', lobbyid);

  deletebutton.setAttribute('data-lobby-id', lobbyid);
  
  deletebutton.innerHTML = Locales["delete"];
  startlobby.innerHTML = Locales["startlobby"];

  createLobbyButton.style.display = "none";
  cancellobby.style.display = "none";

  /*creationbuttons.removeChild(createLobbyButton);
  creationbuttons.removeChild(cancellobby);*/

  deletebutton.classList.add("deletebutton");
  startlobby.classList.add("startlobbybtn");

  creationbuttons.appendChild(startlobby);
  creationbuttons.appendChild(deletebutton);

  var private = optionlist.querySelector("#private");
  var privatetext = optionlist.querySelector(".privatelabel");
  var password = optionlist.querySelector("#password");

  private.style.pointerEvents = "none";
  privatetext.style.pointerEvents = "none";
  password.style.pointerEvents = "none";


  var teamlist = playerlist.querySelector('.teamlist');
  var teams = optionlist.querySelector("#teams").value;
  var setteamvalue = optionlist.querySelector("#teams");

  teamlist.innerHTML = "";
  teamlist.style.display = "block";

  
  for (var i = 0; i < teams; i++) {
      var newteam = document.createElement('li');
      var button = document.createElement('button');
  
      button.innerHTML = cfg.teams[i].name;
      button.style.backgroundColor = `${cfg.teams[i].color}`;

      if (cfg.teams[i].color === "white") {
        button.style.color = "black";
      } else if (cfg.teams[i].color === "yellow") {
        button.style.color = "black";
      }

      newteam.appendChild(button);
      teamlist.appendChild(newteam);

  }
  


  const buttons = document.querySelectorAll('.switch-button');
  var gamemode = cfg.defaultSettings.mode;
  const indicator = optionlistid.querySelector('.indicator');
  var indicatorcheck = indicator.getAttribute(`clicked`, true);
  var mode = indicator.getAttribute('mode');
  var arcade = optionlistid.querySelector("#arcademodes").value;
  var arcadeBox = optionlistid.querySelector("#arcademodes");

  var lobbywageamount = optionlist.querySelector("#wage");
  var lives = optionlist.querySelector("#lives");
  var teamamount = optionlist.querySelector("#teams");
  var spectate = optionlist.querySelector("#spectating");
  var timeamount = optionlist.querySelector("#time");
  var weaponselector = optionlist.querySelector("#weaponselect");
  var dogTagSelector = optionlist.querySelector("#score");

  
  if (mode === 'teams') {
    indicator.style.left = '0';
    teamlist.style.display = "block";
    weaponselector.style.display = "flex";
    lives.style.display = "flex";
    arcadeBox.style.display = "none";
  } else if (mode === 'ffa') {
    indicator.style.left = '33%';
    teamlist.style.display = "none";
    weaponselector.style.display = "flex";
    lives.style.display = "flex";
    arcadeBox.style.display = "none";
  } else {
    indicator.style.left = '67%';
    teamlist.style.display = "none";
    arcadeBox.style.display = "flex";
  }


  buttons.forEach(button => {
    button.addEventListener('click', function() {
      const option = button.classList.contains('teams') ? 'teams' : (button.classList.contains('ffa') ? 'ffa' : 'arcade');

  
      buttons.forEach(btn => btn.classList.remove('active'));
  

      button.classList.add('active');
  

      if (option === 'teams') {
        indicator.style.left = '0';
        teamlist.style.display = "block";
        gamemode = "Teams";
        setteamvalue.value = cfg.defaultSettings.numberOfTeams;
        teamlist.innerHTML = "";
        if (lobbyopencheck) {
          //appendteams();
        }

        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'updateSetting',
          id : lobbyid,
          setting: 'numberOfTeams',
          numOfTeams : setteamvalue.value,
        }));

      } else if (option === 'ffa') {
        indicator.style.left = '33%';
        teamlist.style.display = "none";
        gamemode = "FFA";
        teamlist.innerHTML = "";
      } else if (option === 'arcade'){
        indicator.style.left = '67%';
        teamlist.style.display = "none";
        gamemode = arcade;
        arcadeBox.style.display = "flex";
        teamlist.innerHTML = "";
      }
      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'updateSetting',
        id : lobbyid,
        setting: 'mode',
        mode: gamemode,
      }));
    });
    if (!indicatorcheck) {
      if (gamemode === 'Teams') {
        indicator.style.left = '0';
        teamlist.style.display = "block";
        arcadeBox.style.display = "none";
        setteamvalue.value = cfg.defaultSettings.numberOfTeams;
      } else if (gamemode === 'FFA') {
        indicator.style.left = '33%';
        teamlist.style.display = "none";
        arcadeBox.style.display = "none";
      } else {
        indicator.style.left = '67%';
        arcadeBox.style.display = "flex";
        teamlist.style.display = "none";
      }
    }
  });

  function appendteams() {
    for (var i = 0; i < setteamvalue.value; i++) {
      var newteam = document.createElement('li');
      var button = document.createElement('button');
  
      button.innerHTML = colors[i].name;
      button.style.backgroundColor = `${colors[i].name}`;

      if (colors[i].name === "White") {
        button.style.color = "black";
      } else if (colors[i].name === "Yellow") {
        button.style.color = "black";
      }
  
      newteam.appendChild(button);
      teamlist.appendChild(newteam);
    }
  }

    const currentmap = $('.item.active .mapthumb').parent().find('h3').text();

    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'updateSetting',
      setting: 'map',
      mapName: currentmap,
      id: lobbyid,
    }));

  const carousel = document.querySelector('#myCarousel');
  carousel.setAttribute('data-lobby-id', lobbyid);

  $(carousel).on('slid.bs.carousel', function () {
      let selectedmap = $('.item.active .mapthumb').parent().find('h3').text();
      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'updateSetting',
        setting: 'map',
        mapName: selectedmap,
        id: lobbyid,
      }));
  });
  

        
  lobbywageamount.addEventListener('blur', function() {
    var wagevalue = lobbywageamount.value;
    if (/^\d+$/.test(wagevalue) && parseFloat(wagevalue) >= 0) {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'updateSetting',
      setting: 'wager',
      wager: wagevalue,
      id: lobbyid,
    }));
  } else {
    var wagebox = optionlist.querySelector("#wage");
    var popup = optionlist.querySelector("#errorpopup");
    popup.style.display = "flex";
    popup.style.opacity = "1";
    wagebox.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
    wagebox.style.animation = "shake 0.3s ease";
    wagebox.style.transition = "0.3s ease";

    setTimeout(function() {
      popup.style.opacity = "0";
      wagebox.style.outline = "";
      wagebox.style.animation = "";
      wagebox.style.transition = "";
        setTimeout(function() {
        popup.style.display = "none";
      }, 200);
  }, 4000);
  }
  });

  lives.addEventListener('change', function() {
    var liveoption = lives.value;

    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'updateSetting',
      setting: 'lives',
      lives: liveoption,
      id: lobbyid,
    }));
  });

  spectate.addEventListener('change', function() {

    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'updateSetting',
      setting: "allowSpectate",
      allowSpectate: spectate.checked,
      id: lobbyid,
    }));
  });


  weaponselector.addEventListener('change', function() {
      var lobbyItem = document.querySelector(`li[data-lobby-id="${lobbyid}"]`);
      if (lobbyItem) {
        var weapon = weaponselector.value;
        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'updateSetting',
          id : lobbyid,
          setting: 'weapon',
          weapon: weapon,
        }));
        
      }
  });

  timeamount.addEventListener('change', function() {
    var lobbyItem = document.querySelector(`li[data-lobby-id="${lobbyid}"]`);
    if (lobbyItem) {
      var timevalue = timeamount.value;
      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'updateSetting',
        id : lobbyid,
        setting: 'timeLimit',
        timeLimit : timevalue,
      }));
      
    }
  });

  dogTagSelector.addEventListener('change', function() {
    var lobbyItem = document.querySelector(`li[data-lobby-id="${lobbyid}"]`);
    if (lobbyItem) {
      var dogtags = dogTagSelector.value;
      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'updateSetting',
        id : lobbyid,
        setting: 'maxScore',
        score: dogtags,
      }));
      
    }
  });

  
  var arcadeMode = document.getElementById("arcademodes");

  arcadeMode.addEventListener("change", function() {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'updateSetting',
      id : lobbyid,
      setting: 'mode',
      mode: arcadeMode.value,
    }));
  });


  teamamount.addEventListener('change', function() {
      var teamcount = setteamvalue.value;

      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'updateSetting',
        id : lobbyid,
        setting: 'numberOfTeams',
        numOfTeams : teamcount,
      }));
      

    teamlist.innerHTML = "";

    if (lobbyopencheck) {

      for (var i = 0; i < setteamvalue.value; i++) {
        var newteam = document.createElement('li');
        var button = document.createElement('button');

        button.innerHTML = cfg.teams[i].name;
        button.style.backgroundColor = `${cfg.teams[i].color}`;

        newteam.appendChild(button);
        teamlist.appendChild(newteam);
      }
    }
  });

  var iscreator = true;

  addListItem(data, iscreator);

  deletebutton.addEventListener('click', function() {
    closehostui(lobbyid)
  });


  let clickAllowed = true; 

  startlobby.addEventListener('click', function() {
    if (clickAllowed) {
      clickAllowed = false;
  
      $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
        event: 'startGame',
        id: lobbyid,
      }));
  
      setTimeout(() => {
        clickAllowed = true; 
      }, 500);
    }
  });

}

function startlobbyerror() {
        var wagebox = document.querySelector(".startlobbybtn");
        var popup = document.getElementById("errorpopup2");
        popup.style.display = "flex";
        popup.style.opacity = "1";
        wagebox.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
        wagebox.style.animation = "shake 0.3s ease";
        wagebox.style.transition = "0.3s ease";

        setTimeout(function() {
          popup.style.opacity = "0";
          wagebox.style.outline = "";
          wagebox.style.animation = "";
          wagebox.style.transition = "";
            setTimeout(function() {
            popup.style.display = "none";
          }, 200);
      }, 4000);

}

function joinplayerui(data) {
  inlobby = true;
  var lobbyid = data.id;
  //var playerlist = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  var playerlistid = document.querySelector(".players");
  playerlistid.setAttribute('data-lobby-id', lobbyid);
  var playerlist = document.querySelector(`.players[data-lobby-id="${lobbyid}"]`);
  //var playerlistinner = playerlistid.querySelector(`.playerlist`);
  var mapcontid = document.querySelector(".carouselcont");
  mapcontid.setAttribute('data-lobby-id', lobbyid);
  var mapcont = document.querySelector(`.carouselcont[data-lobby-id="${lobbyid}"]`);

  var settingsmenuid = document.querySelector(".lobbycreator");
  settingsmenuid.setAttribute('data-lobby-id', lobbyid);
  var settingsmenu = document.querySelector(`.lobbycreator[data-lobby-id="${lobbyid}"]`);
  var optionselem = document.querySelector(".options");
  optionselem.setAttribute('data-lobby-id', lobbyid);
  var options = document.querySelector(`.options[data-lobby-id="${lobbyid}"]`);

  var creationbuttons = document.querySelector('.creationbuttons');
  var createbutton = document.querySelector(`#createlobby`);
  var cancelbutton = document.querySelector(`#cancellobby`);

  lobbysettingsmenu = true;
  lobbycreated = true;

  createbutton.style.display = "none";
  cancelbutton.style.display = "none";

  var leavelobby = document.createElement('button');
  leavelobby.setAttribute('data-lobby-id', lobbyid);
  leavelobby.classList.add("leavelobby");
  leavelobby.innerHTML = Locales["leavelobbybtn"];
  creationbuttons.appendChild(leavelobby);

  var joinbutton = document.querySelector(`.joinbutton[data-lobby-id="${lobbyid}"]`);
  joinbutton.innerHTML = Locales["current"];

  var password = options.querySelector("#password");
  password.style.display = "none";

  leavelobby.addEventListener('click', function() {
    closeplayerui(lobbyid)
    lobbysettingsmenu = false;
    lobbycreated = false;
  });



  var wageamount = options.querySelector("#wage");
  var lifesetting = options.querySelector("#lives");
  var lobbytime = options.querySelector("#time");
  var teamcount = options.querySelector("#teams");
  var indicator = options.querySelector('.indicator');
  var teamlist = playerlist.querySelector('.teamlist');
  var weaponselector = options.querySelector('#weaponselect');
  var scoreBox = options.querySelector('#score');

  scoreBox.innerHTML = "";

  settingsmenu.style.width = "500px";
  settingsmenu.style.opacity = "1";
  playerlist.style.height = "300px";
  playerlist.style.opacity = "1";
  mapcont.style.display = "flex";

  clearCarousel();

  for (const key in cfg.maps) {
    if (cfg.maps.hasOwnProperty(key)) {
      const value = cfg.maps[key];
      addCarouselItem("images/"+value.image, key)
    }
  }



  var elementsToDisable = [
    "#wage",
    "#lives",
    "#time",
    ".teamamount",
    ".indicator",
    "#teams",
    "#weaponselect",
    ".spectating",
    "#arcademodes",
    "#score",
  ];

  mapcont.style.pointerEvents = 'none';

  elementsToDisable.forEach(function(selector) {
    var element = options.querySelector(selector);
    if (element) {
        element.style.pointerEvents = 'none';
    }
  });

  for (const key in cfg.weapons) {
    if (cfg.weapons.hasOwnProperty(key)) {
        var option = document.createElement("option");
        option.value = key;
        option.textContent = cfg.weapons[key].label;
        weaponselector.appendChild(option);
    }
  }

  for (const key in cfg.timeLimits) {
    if (cfg.timeLimits.hasOwnProperty(key)) {
        var option = document.createElement("option");  
        if(typeof(cfg.timeLimits[key]) == "string") {     
          option.textContent = cfg.timeLimits[key];
        } else {
          option.textContent = cfg.timeLimits[key] + Locales["minutes"];
        }

        //option.textContent = cfg.timeLimits[key] + Locales["minutes"];
        lobbytime.appendChild(option);
    }
  }

  for (const key in cfg.lives) {
    if (cfg.lives.hasOwnProperty(key)) {
        var option = document.createElement("option");
        option.value = cfg.lives[key];
        /*if (cfg.lives[key] === "Unlimited") {
          option.textContent = cfg.lives[key];
        } else {
          option.textContent = cfg.lives[key] + " Lives";
        }*/
        option.textContent = cfg.lives[key] + Locales["lives"];

        lifesetting.appendChild(option);
    }
  }

  for (const key in cfg.scores) {
    if (cfg.scores.hasOwnProperty(key)) {
        var option = document.createElement("option");
        option.value = cfg.scores[key];
        /*if (cfg.lives[key] === "Unlimited") {
          option.textContent = cfg.lives[key];
        } else {
          option.textContent = cfg.lives[key] + " Lives";
        }*/

      if (data.settings.mode == "Dog Tags") {
        option.textContent = cfg.scores[key] + Locales["dogTags"];
      } else if (data.settings.mode == "CTF") {
        option.textContent = cfg.scores[key] + Locales["ctfScore"];
      }  else if (data.settings.mode == "Team Deathmatch") {
        option.textContent = cfg.scores[key] + Locales["teamKills"];
      }
        scoreBox.appendChild(option);
    }
  }

  if (data.settings.mode == "Gun Game") {
    weaponselector.style.display = "none";
    lifesetting.style.display = "none";
  } else if (data.settings.mode == "Dog Tags" || data.settings.mode == "CTF" || data.settings.mode == "Team Deathmatch") {
    scoreBox.style.display = "flex";
    scoreBox.value = data.settings.maxScore;
    lifesetting.style.display = "none";
  } else {
    weaponselector.style.display = "flex";
    lifesetting.style.display = "flex";
    scoreBox.style.display = "none";
  }
  
  wageamount.value = data.settings.wager;
  lifesetting.value = data.settings.lives;
  if(typeof(data.settings.timeLimit) == "string") {    
    lobbytime.value = data.settings.timeLimit;
  }else{
    lobbytime.value = (data.settings.timeLimit)/60 + Locales["minutes"];
  }
  teamcount.value = data.settings.numberOfTeams;
  weaponselector.value = data.settings.weapon;

  if (data.settings.mode === "Teams") {
    indicator.style.left = '0';
    teamlist.style.display = "block";
    weaponselector.style.display = "flex";
    lifesetting.style.display = "flex";
  } else if (data.settings.mode === "FFA") {
    indicator.style.left = '33%';
    teamlist.style.display = "none";
    weaponselector.style.display = "flex";
    lifesetting.style.display = "flex";
  } else {
    var arcade = options.querySelector("#arcademodes");
    arcade.value = data.settings.mode;
    indicator.style.left = '67%';
    teamlist.style.display = "none";
    arcade.style.display = "flex";

    if (data.settings.mode == "Gun Game") {
      weaponselector.style.display = "none";
      lifesetting.style.display = "none";
    } else {
      weaponselector.style.display = "flex";
      lifesetting.style.display = "flex";
    }
  
  }


 
}

function updatelobbybutton(data, status) {
  var joinbutton = document.querySelector(`.joinbutton[data-lobby-id="${data.id}"]`);


  if (status) {
    if (cfg.spectate.enabled && data.settings.allowSpectate) {
        joinbutton.innerHTML = Locales["spectate"];
        joinbutton.removeEventListener('click', addListItem);
        joinbutton.style.width = "80px";

        joinbutton.addEventListener('click', function() {

            $.post(`https://${GetParentResourceName()}/spectate`, JSON.stringify({
              id : data.id,
            }));

        });
      } else {
        joinbutton.innerHTML = "In Progress";
        joinbutton.style.width = "100px";
      }
  } else {
    joinbutton.innerHTML = Locales["join"];
    joinbutton.addEventListener('click', function() {
      joinbutton.style.width = "70px";
      if(data.settings.privateLobby){
        openInputBox(data)
          
      }else{
        
        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'joinLobby',
          id : data.id,
          setupLocation : setupLocation,
        }));
        
      }
    });
  }
}

function updatePlayerLobby(data) {
  var lobbyid = data.lobby.id
  var optionselem = document.querySelector(".options");
  optionselem.setAttribute('data-lobby-id', data.lobby.id);
  var options = document.querySelector(`.options[data-lobby-id="${data.lobby.id}"]`);
  //var carouselcont = document.querySelector(`.carouselcont[data-lobby-id="${data.lobby.id}"]`);
  var playerlist = document.querySelector(".players");
  playerlist.setAttribute('data-lobby-id', data.lobby.id);
  var playerlistid = document.querySelector(`.players[data-lobby-id="${data.lobby.id}"]`);
  var playerlistinner = playerlistid.querySelector(".playerlist");
  var arcade = options.querySelector("#arcademodes");
  var scoreBox = options.querySelector("#score");
  //var spectatebox = document.querySelector(`#spectate[data-lobby-id="${data.lobby.id}"]`);


  
  //Wager Value
  var wageamount = options.querySelector("#wage");
  wageamount.value = `${data.lobby.settings.wager}`;
  //numberOfTeams
  var teams = options.querySelector("#teams");
  teams.value = `${data.lobby.settings.numberOfTeams}`

  var arcade = options.querySelector("#arcademodes");
  arcade.value = `${data.lobby.settings.mode}`

  //lives
  var lives = options.querySelector("#lives");
  lives.value = `${data.lobby.settings.lives}`;
  //map

  // score 
  scoreBox.value = data.lobby.settings.maxScore;

  if (!data.isHost){
    $('#myCarousel').carousel($('#' + data.lobby.settings.map).index());
  }


  //timeLimit
  var lobbyduration = options.querySelector("#time");
  if(typeof(data.lobby.settings.timeLimit) == "string") {    
    lobbyduration.value = `${(data.lobby.settings.timeLimit)}`;
  }else{
    lobbyduration.value = `${(data.lobby.settings.timeLimit/60) + Locales["minutes"]}`;
  }
  

  //weapon

  var weapon = options.querySelector("#weaponselect");
  var lives = options.querySelector("#lives");
  weapon.value = `${data.lobby.settings.weapon}`;

  // spectate 
  if (data.lobby.settings.allowSpectate) {
    options.querySelector("#spectating").checked = true;
  } else {
    options.querySelector("#spectating").checked = false;
  }


  //mode
if (playerlist) {
  var indicator = options.querySelector(".indicator");
  var teamlist = playerlist.querySelector(".teamlist");
  var teams = options.querySelector("#teams");
    if (data.lobby.settings.mode === 'Teams') {
      indicator.style.left = '0';
      teamlist.style.display = "block";
      teams.style.display = "flex";
      playerlistinner.style.width = "70%";

      weapon.style.display = "flex";
      lives.style.display = "flex";

      arcade.style.display = "none";
    } else if (data.lobby.settings.mode === 'FFA') {
      indicator.style.left = '33%';
      teamlist.style.display = "none";
      teams.style.display = "none";
      arcade.style.display = "none";

      loadPlayerlist()

      weapon.style.display = "flex";
      lives.style.display = "flex";
        
    } else {
      indicator.style.left = '67%';
      teamlist.style.display = "none";
      teams.style.display = "none";

      arcade.style.display = "flex";
      arcade.value = data.lobby.settings.mode;

      if (data.lobby.settings.mode == "Gun Game") {
        weapon.style.display = "none";
        lives.style.display = "none";
      } else if (data.lobby.settings.mode == "Dog Tags" || data.lobby.settings.mode  == "CTF" || data.lobby.settings.mode  == "Team Deathmatch") {
        teamlist.style.display = "block";
        playerlistinner.style.width = "70%";
        scoreBox.style.display = "flex";
        lives.style.display = "none";
      } else {
        weapon.style.display = "flex";
        lives.style.display = "flex";
        scoreBox.style.display = "none";
      }

      loadPlayerlist()
      
    }

    function loadPlayerlist() {
      playerlistinner.innerHTML = "";
      playerlistinner.style.width = "90%";
      var playerul = document.createElement('ul');
      playerul.classList.add("ffalist");
      playerlistinner.appendChild(playerul);

        Object.values(data.lobby.players).forEach(function(key) {
            var player = document.createElement('li');
      
            player.innerHTML = `${key.name}`;
        
            playerul.appendChild(player);
        });
    }

    teamlist.innerHTML = "";


    for (var i = 0; i < teams.value; i++) {
      var newteam = document.createElement('li');
      var button = document.createElement('button');
  
      button.innerHTML = cfg.teams[i].name;
      button.style.backgroundColor = `${cfg.teams[i].color}`;

      if (cfg.teams[i].color === "white") {
        button.style.color = "black";
      } else if (cfg.teams[i].color === "yellow") {
        button.style.color = "black";
      }
  
      newteam.appendChild(button);
      teamlist.appendChild(newteam);

      button.addEventListener('click', function() {

        var buttonColor = this.style.backgroundColor;

        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'joinTeam',
          id : lobbyid,
          team : buttonColor,
        }));
      });

  }

  if (data.lobby.settings.mode === 'Teams' || data.lobby.settings.mode === 'Dog Tags' || data.lobby.settings.mode === 'CTF' || data.lobby.settings.mode === 'Team Deathmatch') {
    playerlistinner.innerHTML = "";

    for (var i = 0; i < data.lobby.settings.numberOfTeams; i++) {
      var teamdivider = document.createElement('ul');
      var currTeam = data.lobby.teams[i].players;
      var teamName = cfg.teams[i].name;
      var teamColor = cfg.teams[i].color;

      teamdivider.innerHTML = teamName;
      teamdivider.style.color = `${teamColor}`;
      teamdivider.classList.add("teamdivider");
  
      teamdivider.setAttribute('divider-color', teamColor);

  
      playerlistinner.appendChild(teamdivider);

      Object.values(currTeam).forEach(function(key) {
        var player = document.createElement('li');

        player.innerHTML = `${key.name}`;
  
        teamdivider.appendChild(player);
      });
    }
  }
}
}

function updateplayercount(data) {
    
  var lobbyupdate = document.querySelector(`li[data-lobby-id="${data.lobby.id}"]`);
  if (lobbyupdate) {
    var playercount = lobbyupdate.querySelector(".playercount");
    var players = Object.keys(data.lobby.players).length;

    playercount.innerHTML = `${players}/${data.lobby.settings.maxPlayers}`;

  }

}

function updateListItem(data){
  var lobbyItem = document.querySelector(`li[data-lobby-id="${data.lobby.id}"]`);
  if (lobbyItem) {
    if(data.setting == "wager"){
      var wageamount = lobbyItem.querySelector(".wageamounttext");
      wageamount.innerHTML = `$${data.lobby.settings.wager}`;
    }else if(data.setting == "numberOfTeams"){
      var teams = lobbyItem.querySelector("#teamtext");
      teams.innerHTML = `${data.lobby.settings.numberOfTeams}`;
    }else if(data.setting == "lives"){
      var lives = lobbyItem.querySelector("#livetext");
      if (data.lobby.settings.mode == "Gun Game" || data.lobby.settings.mode == "CTF" || data.lobby.settings.mode == "Dog Tags" || data.lobby.settings.mode == "Team Deathmatch") {
        lives.style.display = "none";
      } else {
        lives.style.display = "inline-flex";
      }
    }else if(data.setting == "map"){
      var mapsel = lobbyItem.querySelector(".map");
      mapsel.innerHTML = `${data.lobby.settings.map}`;
    }else if(data.setting == "timeLimit"){
      var lobbyduration = lobbyItem.querySelector("#lobbyduration");
      if(typeof(data.lobby.settings.timeLimit) == "string") {    
        lobbyduration.innerHTML = `${(data.lobby.settings.timeLimit)}`;
      }else{
        lobbyduration.innerHTML = `${(data.lobby.settings.timeLimit/60) + Locales["minutes"]}`;
      }
    }else if(data.setting == "weapon"){
      var weapon = lobbyItem.querySelector("#weapontext");
      weapon.innerHTML = `${cfg.weapons[data.lobby.settings.weapon].label}`;
    }else if(data.setting == "mode"){
      var gamemode = lobbyItem.querySelector(".lobbytype");
      //var modeText = data.lobby.settings.mode.charAt(0).toUpperCase() + data.lobby.settings.mode.slice(1)
      //gamemode.innerHTML = `${(modeText)}`;
      var teams = lobbyItem.querySelector("#teamtext");
      var lives = lobbyItem.querySelector("#livetext");
      if (data.lobby.settings.mode === 'FFA') {
        teams.innerHTML = Locales["n/a"];
        gamemode.innerHTML = Locales["ffa"];
        lives.innerHTML = `${data.lobby.settings.lives}`;
      } else if (data.lobby.settings.mode === 'Teams') {
        teams.innerHTML = `${data.lobby.settings.numberOfTeams}`;
        gamemode.innerHTML = Locales["teams"];
        lives.innerHTML = `${data.lobby.settings.lives}`;
      } else {
        teams.innerHTML = `${data.lobby.settings.numberOfTeams}`;
        gamemode.innerHTML = data.lobby.settings.mode;

        if (data.lobby.settings.mode == "Gun Game" || data.lobby.settings.mode == "CTF" || data.lobby.settings.mode == "Dog Tags" || data.lobby.settings.mode == "Team Deathmatch") {
          lives.style.display = "none";
        } else {
          lives.style.display = "inline-flex";
        }
      }
    }else if(data.setting == "playercount"){
      var playercount = lobbyItem.querySelector(".playercount");
      var players = Object.keys(data.lobby.players).length;
      playercount.innerHTMLt = `${players}/${data.lobby.settings.maxPlayers}`;
    }
  }
}


function addListItem(data, iscreator) {
    var lobbyid = data.id;

    var lobbylist = document.getElementById('lobbylist');
    var newlobby = document.createElement('li');
    var textContainer = document.createElement('span');
    textContainer.classList.add("textcontainerspan");

    newlobby.setAttribute('data-lobby-id', lobbyid);
    textContainer.setAttribute('data-lobby-id', lobbyid);

    var carousel = document.querySelector(".carouselcont");
    var settingmenu = document.querySelector(".lobbycreator");
    var optionlist = document.querySelector('.options');


    var playerlist = document.querySelector('.players');
    var playerlistinner = document.querySelector('.playerlist');
    playerlist.setAttribute('data-lobby-id', lobbyid);
    playerlistinner.setAttribute('data-lobby-id', lobbyid);
  
    optionlist.setAttribute('data-lobby-id', lobbyid);
    var optionid = document.querySelector(`.options[data-lobby-id="${lobbyid}"]`);
    var teamvalue = optionid.querySelector("#teams");
    
    carousel.setAttribute('data-lobby-id', lobbyid);
    settingmenu.setAttribute('data-lobby-id', lobbyid);

    var modeText = data.settings.mode.charAt(0).toUpperCase() + data.settings.mode.slice(1)
    textContainer.innerHTML = `<span class="hostname" maxlength="15">${data.name}</span><span class="map">${data.settings["map"]}</span><span class="playercount">${Object.keys(data.players).length}/${data.settings.maxPlayers}</span></span><span class="lobbytype">${modeText}</span></span>`;
    newlobby.appendChild(textContainer);
    var playercount = textContainer.querySelector('.playercount');

    var joinbutton = document.createElement('button');
    joinbutton.setAttribute('data-lobby-id', lobbyid);
    joinbutton.classList.add("joinbutton");
    joinbutton.innerHTML = Locales["join"];

    if(data.gameStarted){
      if (cfg.spectate.enabled && data.settings.allowSpectate) {
        joinbutton.innerHTML = Locales["spectate"];
        joinbutton.style.width = "80px";
        textContainer.appendChild(joinbutton);

        joinbutton.addEventListener('click', function() {

            $.post(`https://${GetParentResourceName()}/spectate`, JSON.stringify({
              id : data.id,
            }));

        });
      } else {
        textContainer.appendChild(joinbutton);
        joinbutton.innerHTML = Locales["inprogress"];
        joinbutton.style.width = "100px";
      }

    } else if (!iscreator) {
    textContainer.appendChild(joinbutton);
    joinbutton.innerHTML = Locales["join"];
    joinbutton.style.width = "70px";

        
    joinbutton.addEventListener('click', function() {
      if(data.settings.privateLobby){
        openInputBox(data)
          
      }else{
        
        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'joinLobby',
          id : data.id,
          setupLocation : setupLocation,
        }));
        
      }
    });
  } else {
    textContainer.appendChild(joinbutton);
    joinbutton.innerHTML = Locales["current"];
  }

  if (data.settings.privateLobby) {
    var lock = document.createElement('span');
    lock.innerHTML = `<i class="fa-solid fa-lock"></i>`

    textContainer.appendChild(lock);
  }

    newlobby.addEventListener('mouseover', function() {
        playercount.style.backgroundColor = "rgba(96, 238, 96, 0.178)";
    });

    newlobby.addEventListener('mouseout', function() {
        if (this.classList.contains('clicked'))         {
        playercount.style.backgroundColor = "rgba(96, 238, 96, 0.178)";
        } else {
        playercount.style.backgroundColor = "rgba(32, 29, 192, 0.178)";
        }
    });
    var lobbyduration
    if(typeof(data.settings.timeLimit) == "string") {    
      lobbyduration = data.settings.timeLimit;
    }else{
      lobbyduration = data.settings.timeLimit / 60 + Locales["minutes"];
    }

    var lives = data.settings.lives;
    var weapon = cfg.weapons[data.settings.weapon].label;
    
    const indicator = optionid.querySelector('.indicator');
    var mode = data.settings.mode;
    var gamemode = textContainer.querySelector('.lobbytype');

    if (mode === 'Teams') {
      //indicator.style.left = '0';
      gamemode.innerHTML = Locales["teams"];
      var teamcountval = teamvalue.value;
    } else if (mode === 'FFA') {
      //indicator.style.left = '50%';
      gamemode.innerHTML = Locales["ffa"];
      var teamcountval = "N/A";
    } else {
      gamemode.innerHTML = data.settings.mode;
      var teamcountval = "N/A";
    }

    var moretextcont = document.createElement('span');
    moretextcont.innerHTML = `<span class="moretext">${Locales["duration"]}<span class="highlight" id="lobbyduration">${lobbyduration}</span></span><span class="moretext">${Locales["teamlives"]} <span class="highlight" id="livetext">${lives}</span></span> <span class="moretext">${Locales["teamcount"]} <span class="highlight" id="teamtext">${teamcountval}</span><br><span class="weapontype">${Locales["weapon"]} <span class="highlight" id="weapontext">${weapon}</span></span><span class="wageamounttext">${Locales["wager"]} <span class="highlight">$${data.settings.wager}</span></span></span>`;
    moretextcont.classList.add("moretextcont");
    var wageAmountText = moretextcont.querySelector('.wageamounttext');
    newlobby.appendChild(moretextcont);
    moretextcont.style.visibility = "hidden";
    var liveCountText = moretextcont.querySelector('#livetext'); 

    if (data.settings.mode == "Gun Game" || data.settings.mode == "CTF") {
      liveCountText.style.display = "none";
    } else {
      liveCountText.style.display = "inline-flex";
    }

    if (data.settings.wager >= 100000000) {
      wageAmountText.style.fontSize = '10px';
  } else {
      wageAmountText.style.fontSize = '';
  }
    

    newlobby.addEventListener('click', function() {
        if (lobbysettingsmenu === false) {
            if (this.classList.contains('clicked')) {
                this.classList.remove('clicked');
                this.style.border = "solid 4px rgba(58, 61, 236, 0.1)";
                this.style.height = "70px";
                joinbutton.style.backgroundColor = "rgba(32, 29, 192, 0.178)";
                playercount.style.backgroundColor = "rgba(32, 29, 192, 0.578)";
                moretextcont.style.opacity = "0";
                moretextcont.style.visibility = "hidden";
            } else {
                this.classList.add('clicked');
                this.style.border = "solid 4px rgba(96, 238, 96, 0.2)";
                this.style.height = "140px"; 
                playercount.style.backgroundColor = "rgba(96, 238, 96, 0.178)";
                joinbutton.style.backgroundColor = "rgba(96, 238, 96, 0.578)";
                moretextcont.style.opacity = "1";
                moretextcont.style.visibility = "visible";
            }
        } 
    });

    lobbylist.appendChild(newlobby);
}

function openInputBox(data){
  var passwordpopup = document.querySelector(".passwordpopup");
  var submitbutton = document.querySelector("#submitpassword");
  var inputbox = document.querySelector(".passwordinput");
  var closepassword = document.querySelector("#closepassword");

  passwordpopup.style.display = "block";

  submitbutton.addEventListener('click', function() {

    if (inputbox.value == data.settings.password) {
    $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
      event: 'joinLobby',
      id : data.id,
      setupLocation : setupLocation,
    }));
    passwordpopup.style.display = "none";
   }else {
      inputbox.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
      inputbox.style.animation = "shake 0.3s ease";
      inputbox.style.transition = "0.3s ease";

        setTimeout(function() {
          inputbox.style.outline = "";
          inputbox.style.animation = "";
      }, 4000);
   }
  });

  closepassword.addEventListener('click', function() {
    passwordpopup.style.display = "none";
  });

}


function toggleSwitch(option) {
    const buttons = document.querySelectorAll('.switch-button');
    buttons.forEach(button => {
      button.classList.remove('active')
    });
    document.querySelector(`.${option}`).classList.add('active');
    const indicator = document.querySelector('.indicator');
    indicator.setAttribute('clicked', true);
    var teamdiv = document.getElementById('teams');
    var arcade = document.getElementById('arcademodes');
    var Scores = document.getElementById("score")
    var Lives = document.getElementById("lives")
    if (option === 'teams') {
        indicator.style.left = '0';
        teamdiv.style.display = "flex";
        arcade.style.display = "none";
        indicator.setAttribute('mode', 'teams');
        Scores.style.display = "none";
        Lives.style.display = "flex";
    } else if (option === 'ffa') {
        indicator.style.left = '33%';
        teamdiv.style.display = "none";
        arcade.style.display = "none";
        Lives.style.display = "flex";
        Scores.style.display = "none";
        indicator.setAttribute('mode', 'ffa');
    } else {
      indicator.style.left = '67%';
      teamdiv.style.display = "none";
      arcade.style.display = "flex";
      indicator.setAttribute('mode', 'arcade');

      var arcadeValue = document.getElementById("arcademodes").value;
      var weaponSelector = document.getElementById("weaponselect");
      var liveSelector = document.getElementById("lives");
      if (arcadeValue == "Gun Game") {
        weaponSelector.style.display = "none";
        liveSelector.style.display = "none";
      } else if (arcadeValue == "CTF" || arcadeValue == "Team Deathmatch") {
        liveSelector.style.display = "none";
        Scores.style.display = "flex";
        weaponSelector.style.display = "flex";
      } else {
        weaponSelector.style.display = "flex";
        liveSelector.style.display = "flex";
      }
    }

}

document.addEventListener('DOMContentLoaded', function(data) {
  var settingscont = document.querySelector(".lobbycreator");
  var cancellobby = document.getElementById('cancellobby');
  var createLobbyButton = document.getElementById('createlobby');
  var privatelobbycheck = document.getElementById('private');
  var passwordbox = document.getElementById('password');

  $.post(`https://${GetParentResourceName()}/getlocale`, JSON.stringify({}), function(data) {
    Locales = data
    $("#title").html(data["paintball_title"]);
    $("#titleselector").html(data["lobby_selector"]);
    $(".createlobby").html(data["create_lobby"]);
    $("#switchteams").html(data["switch_teams"]);
    $("#switchffa").html(data["switch_ffa"]);
    $(".speclabel").html(data["allow_spectating"]);
    $(".privatelabel").html(data["private_lobby"]);
    $("#createlobby").html(data["create"]);
    $("#cancellobby").html(data["cancel_lobby"]);
    $("#errorpopup").html(data["invalid_wageramount"]);
    $("#errorpopup2").html(data["invalid_amount"]);
    $("#warning").html(data["popup_warning_title"]);
    $("#warning_p").html(data["popup_warning_p"]);
    $("#errorpopup2").html(data["invalid_amount"]);
    $("#errorpopup3").html(data["insuffcient_funds"]);
    $("#stay").html(data["popup_stay"]);
    $("#leave").html(data["popup_leave"]);
    $("#enterpass").html(data["enter_password"]);
    $("#submitpassword").html(data["submit_password"]);
    $("#enterpass").attr('placeholder', data["enter_password"])
    $("#wage").attr('placeholder', data["wager_amount"])
    $("#password").attr('placeholder', data["set_password"])
  });

  var soundElements = document.querySelectorAll('*');

  var audioElement = new Audio('sounds/clicksound.mp3');

  soundElements.forEach(function(element) {
    element.addEventListener('click', function() {
        audioElement.volume = 0.05;
        audioElement.play();
    });
  });

  privatelobbycheck.addEventListener('click', function() {
    if (privatelobbycheck.checked) {
      passwordbox.style.display = "flex";
    } else {
      passwordbox.style.display = "none";
    }
  });

  cancellobby.addEventListener('click', function() {
      lobbysettingsmenu = false;
      lobbycreated = false;
      settingscont.style.width = "0px";
      settingscont.style.opacity = "0";
  });

    createLobbyButton.addEventListener('click', function() {
      var wageamount = document.getElementById("wage").value;
      var teams = document.getElementById("teams").value;
      var weaponsel = document.getElementById("weaponselect").value;
      var lives = document.getElementById("lives");
      var time = document.getElementById("time").value;
      var arcade = document.getElementById("arcademodes").value;
      var spectatecheck = document.getElementById("spectating").checked;
      var privatelobby = document.getElementById("private").checked;
      var password = document.querySelector("#password");
      var scoreBoxValue = document.getElementById("score");


      const indicator = document.querySelector('.indicator');
      var indicatorcheck = indicator.getAttribute(`clicked`, true);
      var mode = indicator.getAttribute('mode');
      var gamemode = cfg.defaultSettings.mode;
      var teamlist = document.querySelector('.teamlist');
      
      if (!indicatorcheck) {
        if (gamemode === 'Teams') {
          indicator.style.left = '0';
          teamlist.style.display = "block";
          scoreBoxValue.style.display = "none";
        } else if (gamemode === 'FFA') {
          indicator.style.left = '33%';
          teamlist.style.display = "none";
          scoreBoxValue.style.display = "none";
        } else {
          indicator.style.left = '67%';
          gamemode = arcade;
          teamlist.style.display = "none";
        }
      } else {
        if (mode === 'teams') {
          indicator.style.left = '0';
          teamlist.style.display = "block";
          gamemode = "Teams";
          scoreBoxValue.style.display = "none";
          lives.style.display = "flex";
        } else if (mode === 'ffa') {
          indicator.style.left = '33%';
          teamlist.style.display = "none";
          gamemode = "FFA";
          scoreBoxValue.style.display = "none";
          lives.style.display = "flex";
        } else {
          indicator.style.left = '67%';
          teamlist.style.display = "none";
          gamemode = arcade;
        }
      }
      if (privatelobby){
        if(!(password.value.trim().length > 0)) {

          password.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
          password.style.animation = "shake 0.3s ease";
          password.style.transition = "0.3s ease";
        
                setTimeout(function() {
                  password.style.outline = "";
                  password.style.animation = "";
              }, 4000);
          return
        }
      }

      if (/^\d+$/.test(wageamount) && parseFloat(wageamount) >= 0) {
        lobbycreated = true
        $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({
          event: 'createLobby',
          wager: wageamount,
          mode: gamemode,
          numOfTeams: teams,
          weapon: weaponsel,
          lives: lives.value,
          timeLimit: time,
          password: password.value,
          privateLobby: privatelobby,
          allowSpectate: spectatecheck,
          maxScore: scoreBoxValue.value,
          setupLocation: setupLocation,
        }));
      } else {
          var wagebox = document.getElementById("wage");
          var popup = document.getElementById("errorpopup");
          popup.style.display = "flex";
          popup.style.opacity = "1";
          wagebox.style.outline = "solid 3px rgba(239, 36, 36, 0.405)";
          wagebox.style.animation = "shake 0.3s ease";
          wagebox.style.transition = "0.3s ease";

          setTimeout(function() {
            popup.style.opacity = "0";
            wagebox.style.outline = "";
            wagebox.style.animation = "";
            wagebox.style.transition = "";
              setTimeout(function() {
              popup.style.display = "none";
            }, 200);
        }, 4000);
      }
  });
});

function lobbysettings() {

  var lobbycreationbtn = document.querySelector(".createlobby");
  var carousel = document.querySelector(".carouselcont");
  var settingsmenu = document.querySelector(".lobbycreator");
  var password = document.querySelector("#password");
  var spectate = document.getElementById('spectating');
  var spectatelabel = document.querySelector('.speclabel');
  var privelem = document.getElementById('private');
  var createbutton = document.querySelector(`#createlobby`);
  var cancelbutton = document.querySelector(`#cancellobby`);
  var settingsmenuWidth = window.getComputedStyle(settingsmenu).getPropertyValue('width');

  


  if (lobbycreated === false && settingsmenuWidth == "0px") {

      lobbycreated = true;
      lobbysettingsmenu = true;
      createbutton.style.display = "block";
      cancelbutton.style.display = "block";
      carousel.style.pointerEvents = 'auto !important';

      var gamemode = cfg.defaultSettings.mode;

      if (cfg.defaultSettings.allowSpectate === true) {
        document.getElementById("spectating").checked = true;
      } else if (cfg.defaultSettings.allowSpectate === false) {
        document.getElementById("spectating").checked = false;
      }
      if (cfg.defaultSettings.privateLobby === true) {
        document.getElementById("private").checked = true;
        password.style.display = "flex";
      } else if (cfg.defaultSettings.privateLobby === false) {
        document.getElementById("private").checked = false;
        password.style.display = "none";
      }


      if (!cfg.spectate.enabled) {
        spectate.style.display = "none";
        spectatelabel.style.display = "none";
        privelem.style.marginLeft = "0px";
      }

      settingsmenu.style.width = "500px";
      settingsmenu.style.opacity = "1";
      carousel.style.display = "flex";
      carousel.style.height = "250px";

      clearCarousel()

      for (const key in cfg.maps) {
        if (cfg.maps.hasOwnProperty(key)) {
          const value = cfg.maps[key];
          addCarouselItem("images/"+value.image, key)
        }
      }
      
      $('myCarousel').carousel({
        interval: false,
      });
  

      $('#myCarousel').carousel($(`#${cfg.defaultSettings["map"]}`).index());


      const indicator = document.querySelector('.indicator');
      var teamcount = document.getElementById('teams');

      var wageamount = document.querySelector("#wage");
      var lifesetting = document.querySelector("#lives");
      var lobbytime = document.querySelector("#time");
      var teamcount = document.querySelector("#teams");
      var weaponselector = document.querySelector('#weaponselect');
      var scoreBox = document.querySelector("#score");

      weaponselector.innerHTML = "";
      lobbytime.innerHTML = "";
      lifesetting.innerHTML = "";
      
      
      var arcadeMode = document.getElementById("arcademodes")


      for (const key in cfg.weapons) {
        if (cfg.weapons.hasOwnProperty(key)) {
            var option = document.createElement("option");
            option.value = key;
            option.textContent = cfg.weapons[key].label;
            weaponselector.appendChild(option);
        }
    }

      for (const key in cfg.timeLimits) {
        if (cfg.timeLimits.hasOwnProperty(key)) {
            var option = document.createElement("option");      
            if(typeof(cfg.timeLimits[key]) == "string") {    
              option.textContent = cfg.timeLimits[key];
            }else{
              option.textContent = cfg.timeLimits[key] + Locales["minutes"];
            }

            //option.textContent = cfg.timeLimits[key] + Locales["minutes"]";
            lobbytime.appendChild(option);
        }
    }

    for (const key in cfg.lives) {
      if (cfg.lives.hasOwnProperty(key)) {
          var option = document.createElement("option");
          option.value = cfg.lives[key];
          /*if (cfg.lives[key] === "Unlimited") {
            option.textContent = cfg.lives[key];
          } else {
            option.textContent = cfg.lives[key] + " Lives";
          }*/

          option.textContent = cfg.lives[key] + Locales["lives"];
          lifesetting.appendChild(option);
      }
  }

  runScoreLoop()
  function runScoreLoop() {
    scoreBox.innerHTML = "";
    for (const key in cfg.scores) {
      if (cfg.scores.hasOwnProperty(key)) {
          var option = document.createElement("option");
          option.value = cfg.scores[key];
          /*if (cfg.lives[key] === "Unlimited") {
            option.textContent = cfg.lives[key];
          } else {
            option.textContent = cfg.lives[key] + " Lives";
          }*/
  
          if (arcadeMode.value == "Dog Tags") {
            option.textContent = cfg.scores[key] + Locales["dogTags"];
          } else if (arcadeMode.value == "CTF") {
            option.textContent = cfg.scores[key] + Locales["ctfScore"];
          } else if (arcadeMode.value == "Team Deathmatch") {
            option.textContent = cfg.scores[key] + Locales["teamKills"];
          }
          scoreBox.appendChild(option);
      }
    }
  }

  
      scoreBox.value = cfg.defaultSettings.maxScore;


        // remove weapon selector for mode gun game

        arcadeMode.addEventListener("change", function() {
          if (arcadeMode.value == "Gun Game") {
            weaponselector.style.display = "none";
            scoreBox.style.display = "none";
          } else if (arcadeMode.value == "Dog Tags" || arcadeMode.value == "CTF" || arcadeMode.value == "Team Deathmatch") {
            scoreBox.style.display = "flex";
            runScoreLoop()
            lifesetting.style.display = "none";
            weaponselector.style.display = "flex";
          } else {
            weaponselector.style.display = "flex";
            scoreBox.style.display = "none";
            lifesetting.style.display = "none";
          }
        });
  
  
    
      if (cfg.wagering) {
        wageamount.value = cfg.defaultSettings.wager;
      }
      lifesetting.value = cfg.defaultSettings.lives;
      if(typeof(cfg.defaultSettings.timeLimit) == "string") {    
        lobbytime.value = cfg.defaultSettings.timeLimit;
      }else{
        lobbytime.value = cfg.defaultSettings.timeLimit + Locales["minutes"];
      }
      teamcount.value = cfg.defaultSettings.numberOfTeams;
      weaponselector.value = cfg.defaultSettings.weapon;

      var weaponselector = document.getElementById('weaponselect');

  

      if (gamemode === 'Teams') {
        indicator.style.left = '0';
        teamcount.style.display = "flex";
        lifesetting.style.display = "flex";
        weaponselector.style.display = "flex";
        scoreBox.style.display = "none";
      } else if (gamemode === 'FFA') {
        indicator.style.left = '33%';
        teamcount.style.display = "none";
        lifesetting.style.display = "flex";
        weaponselector.style.display = "flex";
        scoreBox.style.display = "none";
      } else {
        indicator.style.left = '67%';
        teamcount.style.display = "none";
        var arcadeValue = document.getElementById("arcademodes").value;
        arcadeMode.style.display = "flex";
        lifesetting.style.display = "none";
        scoreBox.style.display = "none";
        if (arcadeValue == "Gun Game") {
          weaponselector.style.display = "none";
        } else if (arcadeValue == "Dog Tags" || arcadeValue == "CTF") {
          scoreBox.style.display = "flex"
        } else {
          weaponselector.style.display = "flex";
          scoreBox.style.display = "none";
        }
      
      }


  } else {
      lobbycreationbtn.style.animation = "shake 0.5s ease-in-out";
      lobbycreationbtn.style.background = "linear-gradient(0.25turn, rgb(219, 22, 22) 0%, rgb(236, 81, 81) 80%)";
      lobbycreationbtn.innerHTML = Locales["created_lobby"];

      setTimeout(function() {
          lobbycreationbtn.style.animation = "";
          lobbycreationbtn.style.background = "";
          lobbycreationbtn.innerHTML = Locales["create_lobby"];
      }, 1000);

  }
}

var itemCount = 0; 
  
function addCarouselItem(imageSrc, captionText) {

    var newItemHTML = `
    <div class="item" id="${captionText}">
        <img class="mapthumb" src="${imageSrc}">
        <div class="carousel-caption">
            <h3>${captionText}</h3>
        </div>
    </div>`;

    $('.carousel-inner').append(newItemHTML);
    
    var indicators = $('.carousel-indicators');

    indicators.append(`<li data-target="#myCarousel" data-slide-to="${itemCount}"></li>`);
    indicators.find('li').removeClass('active');
    indicators.find(`li[data-slide-to="${itemCount}"]`).addClass('active');


    $('.carousel-inner .item').removeClass('active');
    $('.carousel-inner .item:last').addClass('active');

    itemCount++; 
}

function clearCarousel() {
  $('.carousel-inner').empty();

  $('.carousel-indicators').empty();

  itemCount = 0;
}

function openLeaderboard(data, status) {
  var Leaderboard = document.querySelector(".leaderboard")
  var Leaderboardtitles = document.querySelector(".leaderboard-titles") 
  var leaderBoardList = document.querySelector(".boardPlayerlist");

  // clear leaderboard
  leaderBoardList.innerHTML = "";


  if (status) {
    Object.values(data.players).sort((a, b) => b.elims - a.elims);
    let position = 0;

    Object.values(data.players).forEach((player) => {
      position++
      var listItem = document.createElement('li');
      var kd;
      if (player.deaths == 0) {
        kd = (player.elims).toFixed(2);
      } else {
        kd = (player.elims / player.deaths).toFixed(2);
      }
      var weapon = cfg.weapons[data.weapon].label
      if(data.mode == "Gun Game"){
        weapon = cfg.weapons[cfg.gunGameWeapons[player.elims]].label
      }
      listItem.innerHTML = `<span id="leadrank">${position}</span><span id="leadName">${player.name}</span><span id="leadKills">${player.elims}</span><span id="leadDeaths">${player.deaths}</span><span id="leadWeapon">${weapon}</span><span id="leadKD">${kd}</span>`

      leaderBoardList.appendChild(listItem)
    });
    Leaderboard.style.display = "block";
    Leaderboardtitles.style.display = "flex";
  } else {
    Leaderboard.style.display = "none";
    Leaderboardtitles.style.display = "none";
  }
}

function addKillfeed(data) {
  var feedlist = document.querySelector(".feedList");

  var listItem = document.createElement("li");
  listItem.innerHTML = `<span id="killer">${data.killer}</span> <img id="weaponIcon" src="weapon-img/${data.weapon}.png"><span id="killed"> ${data.victim}</span>`;


  feedlist.appendChild(listItem);

  if (data.mode == "Teams") {
    var killer = listItem.querySelector("#killer");
    if (killer != null) {
      killer.style.color = cfg.teams[data.killerTeam - 1].color;
    }
    
    var victim = listItem.querySelector("#killed");
    if (victim != null) {
      victim.style.color = cfg.teams[data.victimTeam - 1].color;
    }
  }
  

  setTimeout(function() {
      listItem.classList.add("fade-out");
  }, 5000); 

  setTimeout(function() {
      listItem.remove();
  }, 6000); 
}


function LoadTeamLeaderboard(data, status) {
  var teamBoard = document.querySelector(".teamleaderboardList");
  var teamCont = document.querySelector(".teamleaderboard")
  teamBoard.innerHTML = "";

  if (status) {
    teamCont.style.display = "block";
    for (const team in data.players) {

      var list = document.querySelector(".teamleaderboardList")
      var teamList = document.createElement('div');
      var teamcolor = cfg.teams[team].color;
      var teamname = cfg.teams[team].name;

      teamList.innerHTML = `<div class="teamListHeader">${teamname}</div><div class="teamListStats"><span id="statsName">Name</span><span id="statsKills">Kills</span><span id="statsDeaths">Deaths</span><span id="statsKD">K/D</span></div><ul class="teamListPlayers"></ul>`

      var teamListHeader = teamList.querySelector(".teamListHeader");
      teamListHeader.style.backgroundColor = teamcolor;

      /*if (teamlist == "white" || teamlist == "yellow") {
        teamListHeader.style.color = "black";
      }*/

      list.appendChild(teamList)
      var teamListPlayers = teamList.querySelector(".teamListPlayers");

      Object.keys(data.players[team].players).forEach(playerIDX => {
        
        var player = data.players[team].players[playerIDX]
        const playerItem = document.createElement('li');
        const playerstats = document.createElement('div');
        playerstats.classList.add("playerstats");

        var kd;
        if (player.deaths == 0) {
          kd = (player.elims).toFixed(2);
        } else {
          kd = (player.elims / player.deaths).toFixed(2);
        }

        playerstats.innerHTML = `<span id="playerItemKills">${player.elims}</span><span id="playerItemDeaths">${player.deaths}</span><span id="playerItemKD">${kd}</span>`
        playerItem.innerHTML = `<span style="color: white;">${player.name}</span>`;

        teamListPlayers.appendChild(playerItem);
        teamListPlayers.appendChild(playerstats);
      });
   }
  } else {
    teamCont.style.display = "none";
  }
}