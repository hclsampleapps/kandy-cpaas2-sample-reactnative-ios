import React, { Component,useState } from 'react';

import {
    SafeAreaView,
    StyleSheet,
    ScrollView,
    View,
    Text,
    StatusBar,
    NativeModules,
    Button,
    TextInput,
    TouchableOpacity,
    ActivityIndicator,
    NativeEventEmitter,
    ActionSheetIOS
} from 'react-native';

var persenceManager = NativeModules.Persence;
var persenceEvents = new NativeEventEmitter(NativeModules.Persence)

class Persence extends React.Component {
    static navigationOptions = {
      title: 'Persence',
    };

    state = {
        messageText: '',
        currentStatus: '',
        subscriberId: ''
    }

    persenceEvents = persenceEvents.addListener(
      "messageReceived",
      res => {
        if(res != null) {
         // alert('Message Received Successfully!');
        }
    }
  )

  openPicker = () => {
    ActionSheetIOS.showActionSheetWithOptions(
      {
        options: ["Cancel", "Available","Unknown", "Other", "Away", "Busy", "Lunch", "OnThePhone", "Vacation"],
        cancelButtonIndex: 0
      },
      buttonIndex => {
        if (buttonIndex === 0) {

        }
        else if (buttonIndex === 1) {
            this.state.currentStatus = "Available"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 2) {
            this.state.currentStatus = "Unknown"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 3) {
            this.state.currentStatus = "Other"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 4) {
            this.state.currentStatus = "Away"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 5) {
            this.state.currentStatus = "Busy"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 6) {
            this.state.currentStatus = "Lunch"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 7) {
            this.state.currentStatus = "OnThePhone"
            this.sendCurrentStatus(this.state.currentStatus)
        } else if (buttonIndex === 8) {
            this.state.currentStatus = "Vacation"
            this.sendCurrentStatus(this.state.currentStatus)
        } 
      }
  );
}

  sendCurrentStatus = () => {
    this.setState({
        currentStatus: this.state.currentStatus
    })
    persenceManager.setPersence(this.state.currentStatus,(error, message)=>{
        if(error == null) {
                alert('Persence Send Successfully!');
          } else {
                alert('Persence Sending failed!');
          }
      });
  }


  componentDidMount(){
    persenceManager.initPresenceModule((error, message) =>{
      if(error == null) {
          console.log("Chat module initialize");
      }
    });
   }

    handleDestinationId = (text) => {
        this.state.destinationId = text;
    }

    handleSubscriberId = (text) => {
      this.state.subscriberId = text;
    }

    checkPersence() {
      persenceManager.getPersence("test",(error, message)=>{
        if(error == null) {
                alert('Persence Send Successfully!');
          } else {
                alert('Persence Sending failed!');
          }
      });
    }
   
    render() {
      return (
        <View>

        <View>
        <Text style={styles.input}>
        {this.state.currentStatus}
        </Text>
        <Button style={styles.buttonStyle}
                title = "Press here to set your status"
                onPress = {this.openPicker}
          /> 
        </View>

        <View>
        <TextInput style = {styles.input}
                 placeholder = "Enter the Subscriber Id"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 onChangeText = {this.handleSubscriberId}
        />

        <Button style={styles.buttonStyle}
                title = "Check status of Subscriber Id"
                onPress = {this.checkPersence}
          /> 
        </View>
        </View> 
    );
    }
  }

const styles = StyleSheet.create({  
    Welcome_text: {
        marginTop: 10,
        marginBottom: 0,
        marginLeft: 20,
        fontSize:25,
        fontWeight: 'bold'
     },
     Login_text: {
         marginTop: 0,
         padding: 20,
         fontSize:17,
         fontWeight: 'normal'
    },
    input: {
      margin: 15,
      height: 40,
      borderColor: 'black',
      borderWidth: 1,
      borderRadius:5,
      borderColor:'gray'
    },
    buttonStyle: {
      marginTop: 20,
      padding: 20,
      borderRadius:10,
      borderColor:'black',
      flex: 60
    }
});  

  export default Persence; 