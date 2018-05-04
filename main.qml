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
    height: 960       // Don`t forget to change it, before build for target
    width: 540


   // height: Screen.height
   // width: Screen.width

    title: qsTr("tic-tac")


    Rectangle{
        id: mainfield
        width: main.width
        height: main.height - head.height
        anchors.top: head.bottom


        Rectangle{
            anchors.fill: parent
            Image {
                anchors.fill: parent
                id: backGround
                source: "qrc:/background.png"
            }
        }



//=================================================================
// expirement

        ListView {
            id: listView1
            interactive: true
            orientation: ListView.Horizontal
            y: head.y + 40
            x: 40

            implicitWidth: main.width - 80


           // width: main.width - 10
            height: (main.height / 9) // 2 +5

            delegate: Item {
                id: item_2
                 width: (main.height / 9) / 2 +10
                 height: width

            Button {
                    id: listButt
                    anchors.fill: parent
                    anchors.margins: 3



                    background: Rectangle{
                        anchors.fill: parent
                        //border.width: 3
                        //border.color: "#4697ee"
                        radius: 3
                        color: "#0f3da0"

                    }

                    Text{
                        anchors.centerIn: parent
                        text: id
                        font.family: "Lato Light"
                        font.pointSize: (main.height / 9) / 2 -5
                        color: "white"
                    }


                    onClicked: {
                        textIndex.text = index
                    }


                    ParallelAnimation{
                        id: moveAnim
                        running: true
                        NumberAnimation{

                            target: item_2
                            properties: "y"
                            from: roword.y
                            to: 0

                            duration: 400
                            easing.type: Easing.OutBack
                        }
                        NumberAnimation{
                            target: listButt
                            properties: "opacity"
                            from: 0
                            to: 1.0
                            duration: 100
                        }

                    }



                }
            }

            model: ListModel {
                id: listModel // setting an id
            }



}

//================================================================


        Grid{
            id: roword
            anchors.topMargin: 50
            anchors.bottomMargin: height * 7
            anchors.rightMargin: 25
            anchors.leftMargin: 25
            width: (main.height / 9) / 2 +5
            height: (main.height / 9) / 2 +5

            x: main.height / 9 / 2
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: mainfield.bottom
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
                       radius: 3
                       color: "#030e47"

                   }
                
                   Text{
                       id: buttontxt
                       anchors.centerIn: parent
                       font.family: "Lato Light"
                       font.pointSize: (main.height / 9) / 2 -10
                       color: "white"

                       text: backend.gimmeLetter()
                   }
                       onClicked: {

                           backend.typeing(buttontxt.text);

                           if(!listView1.positionViewAtEnd())
                            listModel.append({id: buttontxt.text})
                           else listView1.visible = false

                           buttons.enabled = false
                           //buttontxt.visible = false
                          // buttons.visible = false



                       }

                  }

             }  

        }

    }

    Rectangle{
        id: answerPanel
        width: mainfield.width - 100
        height: mainfield.height / 2
        y: - (Screen.height + 500)
        anchors.horizontalCenter: mainfield.horizontalCenter
        radius: 8
        color: "#274f7c"
        opacity: 0.9


        Text {
            id: headLine
            anchors.margins: 15
            anchors.top: answerPanel.top
            anchors.left: answerPanel.left
           // anchors.centerIn: parent.Center
            font.family: "Segoe UI Light"
            font.pointSize: main.height / 96 + 20
            color: "white"

        }



Flickable{
    id: answerFlick
    interactive: true
    width: answerPanel.width
    height: answerPanel.height - panelOkBt.height
    anchors.top: headLine.bottom
    anchors.bottom: panelOkBt.top
    contentWidth: answerPanel.width
    contentHeight: answerPanel.height * 100
    Rectangle{
        id: contentRect
        //anchors.centerIn: parent
        color: answerPanel.color
        Text {
            id: answPanTxt
            anchors.margins: 15
            anchors.top: headLine.bottom
            anchors.left: contentRect.left
           // anchors.centerIn: parent.Center
            font.family: "Segoe UI Light"
            styleColor: "#141d40"
            font.pointSize: main.height / 96 + 15
            color: "white"

        }
    }

}

        Button{
            id: panelOkBt
            width: answerPanel.width / 2
            height: answerPanel.height / 6
            anchors.horizontalCenter: answerPanel.horizontalCenter
            anchors.bottom: answerPanel.bottom
            anchors.bottomMargin: 10
            background: Rectangle{
                anchors.fill: parent
                color: "white"
                radius: 7

                Text {
                    id: pressOkPanel
                    anchors.centerIn: parent
                    font.family: "Segoe UI Light"
                    font.pointSize: 20
                    color: "black"
                    text: qsTr("OK")
                }
            }

            onClicked: {

                answerPanelClose.running = true

                answPanTxt.text = ""

                answPanTxt.text = ""

                checkButton.visible = true

                for(var a = 0; a !== rep.count; ++a)
                {
                    rep.itemAt(a).enabled = true
                    rep.itemAt(a).visible = true

                }



            }
        }

        NumberAnimation{
            id: answerPanelClose
            running: false
            target: answerPanel
            properties: "y"
            from: mainfield.height / 2 - (answerPanel.height / 2)
            to: - (Screen.height + 500)

            duration: 200
            easing.type: Easing.InBack
        }


        ParallelAnimation{
            id: movePanel
            running: false
            NumberAnimation{

                target: answerPanel
                properties: "y"
                from: - (Screen.height + 500)
                to: mainfield.height / 2 - (answerPanel.height / 2)

                duration: 250
                easing.type: Easing.OutBack
            }
            NumberAnimation{
                target: answerPanel
                properties: "opacity"
                from: 0
                to: 0.9
                duration: 100
            }

        }

    }



    Rectangle{
        id: head
        x: 0
        y: 0
        width: main.width
        height: main.height / 11
        color: "#3577d3"
        Text {
            id: headTxt
            anchors.verticalCenter: head.verticalCenter
            anchors.left: head.left
            anchors.leftMargin: 20
            font.family: "Segoe UI Light"
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
                        radius: 18
                        color: "#89a9d3"
                    }

    }







    Button{
        id: checkButton
        width: main.width / 2 - 15 - 7
        height: main.height / 10 - 7
        //anchors.top: mainfield.top
        anchors.bottom: next_stop.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: mainfield.horizontalCenter
        anchors.topMargin: 50
        background: Rectangle{
            anchors.fill: parent
            radius: 4
            color: "#3577d3"
            Text {
                anchors.centerIn: parent
                anchors.leftMargin: 25
                anchors.topMargin: 10
                font.family: "Segoe UI Light"
                font.pointSize: 35
                color: "white"
                text: "OK"
            }
        }
        onClicked: {

            listModel.clear()

            answerPanel.height = mainfield.height / 2

            answerPanel.width = mainfield.width - 100

            answerFlick.contentY = 0


            if(backend.checkIfRight() === "null")
            {
                headLine.text = "No!"
                answPanTxt.text = "There is no such word, <br>please try again!"
            }
            else if(backend.checkIfRight() === "same")
            {
                headLine.text = "No!"
                answPanTxt.text = "You mustn`t use <br> the same word :)"
            }
            else
            {
                headLine.text = "Well done! <br>"
                answPanTxt.text = backend.showLast()
            }

            movePanel.running = true

            backend.clearTyped()
        }
    }

    Row{
        id: next_stop
        width: mainfield.width - 30
        height: main.height / 10
        anchors.bottom: mainfield.bottom
        anchors.bottomMargin: 7
        anchors.horizontalCenter: mainfield.horizontalCenter
        spacing: 5

        Button{
            id: leftBtn
            width: main.width / 2 - 15 - 7
            height: main.height / 10 - 7
            anchors.leftMargin: 15
            background: Rectangle{
                anchors.fill: parent
                radius: 4
                color: "#3577d3"
                Text {
                    anchors.centerIn: parent
                    anchors.leftMargin: 25
                    anchors.topMargin: 10
                    font.family: "Segoe UI Light"
                    font.pointSize: 35
                    color: "white"
                    text: "NEXT"
                }
            }
            onClicked: {

                 backend.initWord()

                 roword.visible = true

                 rep.model = backend.howManyLetter()

                 roword.columns = head.width / (main.height / 9 / 2) - 3

                 listModel.clear()

                 backend.findWordList()



            }

        }

        Button{
            id: rightBtn
            width: main.width / 2 - 15 - 7
            height: main.height / 10 - 7
            background: Rectangle{
                anchors.fill: parent
                radius: 4
                color: "#3577d3"
                Text {
                    anchors.centerIn: parent
                    anchors.leftMargin: 25
                    anchors.topMargin: 10
                    font.family: "Segoe UI Light"
                    font.pointSize: 35
                    color: "white"
                    text: "STOP"
                }
            }
            onClicked: {

                answerPanel.height = mainfield.height / 2 + 100

                answerPanel.width = mainfield.width - 50

                panelOkBt.height = answerPanel.height / 7 - 10

                checkButton.visible = false

                headLine.text = "Results: <br>" + "Points: " + backend.showSessionPoints()
                        + " Total: "
                        + backend.showPoints() +
                        "<br> Possible: " + backend.showPossiblePoints()


                answPanTxt.text = backend.userAnswers()

                listModel.clear()

                answerFlick.contentY = 0

                movePanel.running = true

                backend.clearTyped()


            }

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





















