import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0

import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1
import QtQuick.XmlListModel 2.0
import QtGraphicalEffects 1.0

Window {
    id: main
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("tic-tac")


    Rectangle{
        id: mainfield
        width: Screen.width
        height: Screen.height - head.height
        anchors.top: head.bottom

        Button{
            id: startButton
            width: Screen.width / 2 - 15
            height: Screen.height / 10
            //anchors.top: mainfield.top
            anchors.bottom: mainfield.bottom
            anchors.bottomMargin: 40
            anchors.horizontalCenter: mainfield.horizontalCenter
            anchors.topMargin: 50
            background: Rectangle{
                anchors.fill: parent
                radius: 4
                color: "#73e6d9"
                Text {
                    anchors.centerIn: parent
                    anchors.leftMargin: 25
                    anchors.topMargin: 10
                    font.family: "Noto Sans CJK KR Thin"
                    font.pointSize: 35
                    color: "white"
                    text: "New"
                }
            }
            onClicked: {
               // bigbusy.running = true
                backend.initWord()

                roword.visible = true

                rep.model = backend.howmanyLetter()
                roword.columns = head.width / (Screen.height / 9 / 2) - 3

                //console.log((head.width / (Screen.height / 9)) - 2)



            }
            
        }


        Grid{
            id: roword
            //columns: 8
            anchors.topMargin: 50
            anchors.bottomMargin: height * 5
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            width: (Screen.height / 9) / 2 +5
            height: (Screen.height / 9) / 2 +5

            x: Screen.height / 9 / 2 - 10
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: startButton.top
            spacing: 3
            visible: false

            Repeater{
                id: rep
                Button{
                   id: buttons

                   width: roword.width
                   height: roword.height


                   background: Rectangle{
                       anchors.fill: parent
                       //border.width: 3
                       //border.color: "#4697ee"
                       radius: 3
                       color: "#4e0fa0"

                   }
                
                   Text{
                       id: buttontxt
                       anchors.centerIn: parent
                      // anchors.leftMargin: 25
                      // anchors.topMargin: 10
                       font.family: "Lato Light"
                       font.pointSize: (Screen.height / 9) / 2 -10
                       color: "white"

                       text: backend.gimmeLetter()
                   }
                       onClicked: {
                       
                       }

       }
                             
                
            }


        }

    }

    Rectangle{
        id: head
        x: 0
        y: 0
        width: Screen.width
        height: Screen.height / 9 + 10
        color: "#43c4b5"
        Text {
            id: headTxt
            anchors.verticalCenter: head.verticalCenter
            anchors.left: head.left
            anchors.leftMargin: 20
            font.family: "Noto Sans CJK KR Thin"
            font.pointSize: 20
            color: "white"
            text: "Tic-tac-words"
        }
        layer.enabled: true
                    layer.effect: DropShadow {
                        id: headshadow
                        transparentBorder: true
                        //horizontalOffset: 8
                        verticalOffset: 8
                        samples: 20
                        //spread: 0.6
                        radius: 10
                        color: "gray"
                    }

    }


    BusyIndicator {
             id: bigbusy
             //opacity: 0
             running: false
             //running:
             width: parent.width / 3
             height: parent.width / 3
             anchors.centerIn: parent


             OpacityAnimator {
                     id: bigbusyappear
                     target: bigbusy;
                     from: 0;
                     to: 1;
                     duration: 700
                     running: true
                     easing.type: Easing.InOutExpo
                 }


             contentItem: Item {
                           id: item
                          // x: parent.width / 2 - 32
                          // y: parent.height / 2 - 32
                           //anchors.fill: parent
                           //width: 64
                           //height: 64
                           opacity: bigbusy.running ? 1 : 0

                           Behavior on opacity {
                               OpacityAnimator {
                                   duration: 1500
                               }
                           }

                           RotationAnimator {
                               target: item
                               running: bigbusy.visible && bigbusy.running
                               from: 0
                               to: 360
                               loops: Animation.Infinite
                               duration: 1700
                           }

                           Repeater {
                               id: repeater
                               model: 5

                               Rectangle {
                                   x: item.width / 2 - width / 11
                                   y: item.height / 2 - height / 11
                                   implicitWidth: 70
                                   implicitHeight: 70
                                   radius: 50
                                   color: "#4B94FF"

                                   transform: [
                                       Translate {
                                           y: -Math.min(item.width, item.height) * 0.5 + 5
                                       },
                                       Rotation {
                                           angle: index / repeater.count * 360
                                           origin.x: 5
                                           origin.y: 5
                                       }
                                   ]



                                   }
                               }

                      }

             }


}




















