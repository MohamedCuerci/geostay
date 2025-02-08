// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    markers: Array
  }

  connect() {
    console.log("Map controller connected")
    if (typeof google !== 'undefined' && typeof google.maps !== 'undefined') {
      console.log("aqui");
      this.initializeMap();
    } else {
      window.addEventListener('mapsloaded', () => {
        console.log("aqui 2");
        this.initializeMap();
      });
    }
  }

  async initializeMap() {
    // Primeiro, importe os módulos necessários
    const { Map } = await google.maps.importLibrary("maps");
    const { StyledMapType } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");
    // const MarkerClusterer = new markerClusterer.MarkerClusterer;

    // Cria o estilo customizado do mapa
    console.log('Google Maps API version: ' + google.maps.version);

    const styledMapType = new StyledMapType([
      {
        "featureType": "administrative.land_parcel",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "landscape.natural",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "visibility": "on"
          }
        ]
      },
      {
        "featureType": "poi",
        "elementType": "labels.text",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "poi.business",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road",
        "elementType": "labels.icon",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "road.highway",
        "stylers": [
          {
            "color": "#8ba5c1"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
          {
            "color": "#c1ccd8"
          }
        ]
      },
      {
        "featureType": "road.local",
        "elementType": "geometry.stroke",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      },
      {
        "featureType": "transit",
        "stylers": [
          {
            "visibility": "simplified"
          }
        ]
      }
    ], { name: "Styled Map" });

    // Crie o mapa
    this.map = new Map(this.element, {
      center: { lat: -22.971925, lng: -43.184723 },
      zoom: 13,
      mapId: "6a9f95caa20671ee",
      zoomControl: true,
    });

    this.map.mapTypes.set("styled_map", styledMapType);
    this.map.setMapTypeId("styled_map");

    // console.log("mapa criado: ", this.map);

    // Adiciona os marcadores
    if (this.hasMarkersValue) {
      const markers = [];  // Array para armazenar os marcadores
    
      this.markersValue.forEach(marker => {
        const icon = document.createElement("div");
        icon.innerHTML = '<i class="fa-solid fa-house"></i>';
    
        const pin = new PinElement({
          glyph: icon,
          glyphColor: "#ffffff",
          scale: 1,
          background: "#0055DE",
          borderColor: "#ffffff",
        });
    
        const advancedMarker = new AdvancedMarkerElement({
          position: { 
            lat: parseFloat(marker.lat), 
            lng: parseFloat(marker.lng) 
          },
          map: this.map,
          title: marker.name,
          content: pin.element
        });
    
        markers.push(advancedMarker);  // Adiciona o marcador ao array

        // Adiciona evento de clique
        advancedMarker.addListener("gmp-click", () => {
          // Seu código para lidar com o clique
          console.log(`Clicou no marcador: ${marker.name}`);
        });
      });

      // pra renderizar os marcadores num estilo agrupado
      const renderer = {
        render: ({ count, position }) => {
          const clusterElement = document.createElement("div");
          clusterElement.innerHTML = `
            <div style="
              background: #0055DE;
              color: white;
              border-radius: 50%;
              width: 40px;
              height: 40px;
              display: flex;
              align-items: center;
              justify-content: center;
              font-weight: bold;
              border: 2px solid white;
              box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            ">
              ${count}
            </div>
          `;
  
          return new AdvancedMarkerElement({
            position,
            content: clusterElement,
          });
        }
      };
    
        // Criar o MarkerClusterer
        // new MarkerClusterer({
        //   map: this.map,
        //   markers: markers,
        //   renderer: renderer,
        //   // Configurações do cluster
        //   maxZoom: 14, // Zoom máximo onde os marcadores ainda podem ser agrupados
        //   gridSize: 50, // Tamanho da grade para agrupar marcadores (ajuste conforme necessário)
        // });
        
      new markerClusterer.MarkerClusterer({
        map: this.map,
        markers: markers, // Array de marcadores
        renderer: renderer,
        options: { maxZoom: 14, gridSize: 50 } // Configurações do cluster
      });
    }
  }
}
