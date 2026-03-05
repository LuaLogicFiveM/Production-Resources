const CENTER_X = 117.3;
const CENTER_Y = 172.5;
const SCALE_X = 0.02072;
const SCALE_Y = 0.0205;
let mymap = null;
let playerMarker = null;
let playerPosition = { x: 0, y: 0 };
let rotAngle = 90.0

CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
    projection: L.Projection.LonLat,
    scale: zoom => Math.pow(2, zoom),
    zoom: scale => Math.log(scale) / 0.6931471805599453,
    distance: (pos1, pos2) => {
        var dx = pos2.lng - pos1.lng;
        var dy = pos2.lat - pos1.lat;
        return Math.sqrt(dx * dx + dy * dy);
    },
    transformation: new L.Transformation(SCALE_X, CENTER_X, -SCALE_Y, CENTER_Y),
    infinite: true
});

function createCustomIcon(icon, size, rotationAngle) {

    if (icon == 'arrow') {
        rotationAngle = (360 - rotationAngle) % 360

        return L.divIcon({
            html: `<img src="assets/blips/${icon}.png" style="transform: rotate(${rotationAngle}deg); width: ${size}px; height: ${size}px;">`,
            iconSize: [size, size],
            className: ''
        });
    } else {
        return L.icon({
            iconUrl: `assets/blips/${icon}.png`,
            iconSize: [size, size],
            iconAnchor: [size/2, size/2],
            popupAnchor: [-10, -27]
        });
    }g
}

function setWaypoint(x, y) {
    nui.post('mapUI-set-waypoint', {x: x, y: y})
}

function calculateDistance(point1, point2) {
    const dx = point2.x - point1.x;
    const dy = point2.y - point1.y;
    return Math.sqrt(dx * dx + dy * dy);
}

function addLegendToMap() {
    const legend = L.control();

    legend.onAdd = function () {
        const div = L.DomUtil.create('div', 'legend-container');

        div.innerHTML = `
            <div class="legend-item">
                <img src="assets/blips/arrow.png" class="legend-icon" alt="Player Icon"> Your Location
            </div>
            <div class="legend-item">
                <img src="assets/blips/ukhy.png" class="legend-icon" alt="Hydrant Icon"> Hydrant
            </div>
        `;

        return div;
    };

    legend.addTo(mymap);
}

let displayedMarkers = [];
let updateTimeout;

function debounceDisplayVisibleHydrants() {
    clearTimeout(updateTimeout);
    updateTimeout = setTimeout(displayVisibleHydrants, 300);
}

function displayVisibleHydrants() {
    if (!mymap) return;

    const bounds = mymap.getBounds();
    const visibleHydrants = hydrantPositions.filter(hydrant => bounds.contains([hydrant.y, hydrant.x]));

    adjustMarkerCount(visibleHydrants.length);

    visibleHydrants.forEach((hydrant, index) => {
        const marker = displayedMarkers[index];
        marker.setLatLng([hydrant.y, hydrant.x]);
        marker.bindPopup(createPopupContent(index, hydrant));
    });
}

function adjustMarkerCount(targetCount) {
    while (displayedMarkers.length < targetCount) {
        const marker = L.marker([0, 0], { icon: createCustomIcon('ukhy', 25, 35) });
        displayedMarkers.push(marker.addTo(mymap));
    }

    while (displayedMarkers.length > targetCount) {
        const marker = displayedMarkers.pop();
        mymap.removeLayer(marker);
    }
}

function createPopupContent(index, hydrant) {
    return `
        <div class="modern-popup">
            <h4>Hydrant #${index + 1}</h4>
            <button class="waypoint-btn" onclick="setWaypoint(${hydrant.x}, ${hydrant.y})">Set Route</button>
        </div>
    `;
}

function showMap(type) {
    if (mymap) {
        return;
    }

	const atlasLayer = L.tileLayer('https://raw.githubusercontent.com/Zea-Development/AtlastMap/main/{z}/{x}-{y}.jpg', {
        minZoom: 4,
        maxZoom: 6,
        noWrap: true,
        continuousWorld: false,
        id: 'styleAtlas'
    });

    mymap = L.map(type, {
        crs: CUSTOM_CRS,
        minZoom: 5,
        maxZoom: 6,
        zoom: 5,
        maxNativeZoom: 6,
        preferCanvas: true,
        layers: [atlasLayer],
        center: [0, 0]
    }).setView([playerPosition.y, playerPosition.x], 5)

    if (!mymap) {
        return
    }

    playerMarker = L.marker([playerPosition.y, playerPosition.x], {
        icon: createCustomIcon('arrow', 20, rotAngle),
        keyboard: true,
        riseOnHover: true
    }).addTo(mymap);

    addLegendToMap()

    setTimeout(function () {
        if (mymap) {
            mymap.invalidateSize();
        }
        window.dispatchEvent(new Event('resize'));
    }, 500);

    displayVisibleHydrants();
    mymap.on('moveend', displayVisibleHydrants);
    mymap.on('zoomend', displayVisibleHydrants);
}

function deleteMap() {
    if (mymap) {
        mymap.remove();
        mymap = null;
    }
}
