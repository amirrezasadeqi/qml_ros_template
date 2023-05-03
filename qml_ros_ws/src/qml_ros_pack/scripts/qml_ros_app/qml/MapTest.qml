import QtLocation 5.15
import QtPositioning 5.15
import QtQuick 2.15
import QtQuick.Controls 2.15


Item {
    id: mapWindow
//    implicitWidth: 1000
//    implicitHeight: 500
//    anchors.fill: parent
    Rectangle{
        id: map_bg
        anchors.fill: parent

        Rectangle{
            id: bottom_container
            height: 40
            color: "#5a8d91"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0

            Slider {
                id: slider
                from: 0.1
                value: 0.1
                to: 1.0
            }

        }

        Map {
            id: map
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 40
            anchors.topMargin: 0

            plugin: Plugin {
                name: "mapboxgl"

                PluginParameter {
                    name: "mapboxgl.mapping.items.insert_before"
                    value: "road-label-small"
                }

                PluginParameter {
                    name: "mapboxgl.access_token"
                    value: "pk.eyJ1IjoiYW1pci1yZXphLXNhZGVnaGkiLCJhIjoiY2xoN2RnMXhhMGY5MDNlbnNlanI0eW45cCJ9.cEA2Vl46PcY5rfWFgURHaA"
                }

                PluginParameter {
                    name: "mapboxgl.mapping.additional_style_urls"
                    value: "mapbox://styles/mapbox/satellite-streets-v12,mapbox://styles/mapbox/navigation-night-v1,mapbox://styles/mapbox/satellite-v9,mapbox://styles/mapbox/navigation-day-v1"
                }
            }



            center: QtPositioning.coordinate((35.7471 + slider.value), 51.603)
            zoomLevel: 15
            minimumZoomLevel: 0
            maximumZoomLevel: 20
            tilt: 0

            copyrightsVisible: false

            MapParameter {
                type: "layer"

                property var name: "3d-buildings"
                property var source: "composite"
                property var sourceLayer: "building"
                property var layerType: "fill-extrusion"
                property var minzoom: 15.0
            }

            MapParameter {
                type: "filter"

                property var layer: "3d-buildings"
                property var filter: [ "==", "extrude", "true" ]
            }

            MapParameter {
                type: "paint"

                property var layer: "3d-buildings"
                property var fillExtrusionColor: "#00617f"
                property var fillExtrusionOpacity: .6
                property var fillExtrusionHeight: { return { type: "identity", property: "height" } }
                property var fillExtrusionBase: { return { type: "identity", property: "min_height" } }
            }

            MapQuickItem{
                id: sample_marker
                anchorPoint.x: marker.width/2
                anchorPoint.y: marker.height/2
    //            zoomLevel: 15
                coordinate: map.center
                sourceItem: Image {
                    id: marker
                    source: "../images/svg_images/close_icon.svg"
                    width: 22
                    height: 22
                }
            }

        }

    }

}
