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

    handleDestinationId = (text) => {
        this.state.destinationId = text;
    }

    handleMessageText = (text) => {
        this.state.messageText = text;
    }
   
    render() {
      return (
        <CallView style={styles.callBox} />
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