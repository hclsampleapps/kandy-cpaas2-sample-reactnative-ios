import React, { Component } from 'react';

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
    requireNativeComponent
} from 'react-native';

var callManager = NativeModules.Call;

const width_proportion = '100%';
const height_proportion = '40%';

const CallView = requireNativeComponent("Call")

class Call extends React.Component {
    static navigationOptions = {
      title: 'Call',
    };

    state = {
        destinationId: '',
        messageText: ''
    }

  componentDidMount(){
    callManager.initCallModule((error, message) =>{
      if(error == null) {
          console.log("Call module initialize");
      }
    });
   }

   handleEndCall = () => {
    callManager.endCall((error, message)=>{
      if(message != 'error') {
        console.log("Call Ended successfully");
              alert("Call Ended successfully");
        } else {
              console.log("Error in ending the call");
              alert('Error in ending the call');
        }
    });
  }

   handleMuteCall = () => {
      callManager.muteCall((error, message)=>{
        if(message != 'error') {
          console.log("Call muted successfully");
                alert("Call muted successfully");
          } else {
                console.log("Error in mute the call");
                alert('Error in mute the call');
          }
      });
    }

    handleUnmuteCall = () => {
        callManager.unmuteCall((error, message)=>{
          if(message != 'error') {
            console.log("Call unmute successfully");
                  alert("Call unmute successfully");
            } else {
                  console.log("Error in unmute the call");
                  alert('Error in unmute the call');
            }
        }); 
      }

      handleHoldCall = () => {
        callManager.holdCall((error, message)=>{
          if(message != 'error') {
            console.log("Call hold successfully");
                  alert("Call hold successfully");
            } else {
                  console.log("Error in hold the call");
                  alert('Error in hold the call');
            }
        }); 
      }


      handleUnHoldCall = () => {
        callManager.holdCall((error, message)=>{
          if(message != 'error') {
            console.log("Call unhold successfully");
                  alert("Call unhold successfully");
            } else {
                  console.log("Error in unhold the call");
                  alert('Error in unhold the call');
            }
        }); 
      }

      handleOutGoingCall = () => {
        callManager.setOutGoingCall("test1@karan.prod.lwjn.att.com",(error, message)=>{
          if(message != 'error') {
            console.log("Call started successfully");
                  alert("Call started successfully");
            } else {
                  console.log("Error in starting call.");
                  alert('Error in starting call.');
            }
        }); 
      }
  
    render() {
      return (
        <View>
        <CallView style={styles.callBox} />
        <View>
        <Button style={styles.buttonStyle}
                title = "End Call"
                onPress = {this.handleEndCall}
        /> 
        <Button style={styles.buttonStyle}
                title = "Mute Call"
                onPress = {this.handleMuteCall}
        /> 
         <Button style={styles.buttonStyle}
                title = "Unmute Call"
                onPress = {this.handleUnmuteCall}
        /> 
         <Button style={styles.buttonStyle}
                title = "Hold Call"
                onPress = {this.handleHoldCall}
        /> 
         <Button style={styles.buttonStyle}
                title = "Unhold Call"
                onPress = {this.handleUnHoldCall}
        /> 
           <Button style={styles.buttonStyle}
                title = "Start Outgoing Call"
                onPress = {this.handleOutGoingCall}
        /> 
        </View>
        </View>
      );
    }
  }

const styles = StyleSheet.create({   
  callBox: {
    width: width_proportion,
    height: height_proportion,
    alignItems: 'center',
    justifyContent: 'center',
  }
});  

  export default Call; 