import L from '../vendor/leaflet/leaflet';
import terminator from '../vendor/Leaflet.Terminator';
import dayjs from '../vendor/dayjs/dayjs.min';
import utc from '../vendor/dayjs/plugin/utc';

let Hooks = {};
let map = null;
let markers = [];

Hooks.QsoMap = {
  mounted() {
    this.handleEvent('load_map', (data) => {
      this.doMap(data.map.latitude, data.map.longitude);
      this.doDayLines();
      this.doMarkers();
    });
  },
  doMap(latitude, longitude) {
    map = L.map('world-map').setView([latitude, longitude], 3);
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      minZoom: 4,
      maxZoom: 6,
      maxBoundsViscosity: 1,
      attribution:
        '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    }).addTo(map);

    var bounds = map.getBounds(); // Get the current bounds of the map
    map.setMaxBounds(bounds);
    map.on('drag', function () {
      map.panInsideBounds(bounds, { animate: false });
    });
  },
  doDayLines() {
    var t = terminator({
      fillOpacity: 0.7,
      weight: 30,
      color: 'gray',
      resolution: 1,
    });
    t.addTo(map);

    setInterval(function () {
      t.setTime();
    }, 120000); // Every two minutes
  },
  doMarkers() {
    var band_colors = {
      '160m': '#16a34a',
      '80m': '#84cc16',
      '60m': '#f97316',
      '40m': '#f97316',
      '30m': '#3f6212',
      '20m': '#ef4444',
      '17m': '#14b8a6',
      '15m': '#06b6d4',
      '12m': '#6366f1',
      '10m': '#79C99E',
      '6m': '#97DB4F',
      '2m': '#450a0a',
      '1.25cm': '#1a2e05',
      '70cm': '#083344',
      '33cm': '#1e1b4b',
    };
    this.handleEvent('new_spot', (spot) => {
      var band = spot.spot.band;
      var mode = spot.spot.mode;
      var sender = spot.spot.sender;
      var grid = spot.spot.recv_grid;
      var lat = spot.spot.lat;
      var lon = spot.spot.lon;
      var marker = L.circleMarker([lat, lon], {
        radius: 3,
        width: 3,
        color: band_colors[band],
        fillColor: band_colors[band],
        fillOpacity: 1,
        fill: true,
      }).addTo(map);
      marker.bindPopup(
        '<strong>' +
          sender +
          '</strong><br/>' +
          mode +
          '/' +
          band +
          '<br/> Heard: ' +
          grid,
      );
      markers.push(marker);
      if (markers.length >= 1000) {
        remove = markers.shift();
        map.removeLayer(remove);
      }
    });
  },
};

function setTime() {
  dayjs.extend(utc);
  var current_time = dayjs();
  var utc_time = current_time.utc().format('HH:mm:ss');
  var local_time = current_time.format('MMMM DD, YYYY HH:mm:ss');
  document.getElementById('utc_time').innerHTML = utc_time;
  document.getElementById('local_time').innerHTML = local_time;
}

Hooks.SetTime = {
  mounted() {
    setInterval(setTime, 1000);
  },
};

export default Hooks;
