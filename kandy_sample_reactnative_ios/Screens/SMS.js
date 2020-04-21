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
    TouchableOpacity
} from 'react-native';

class SMS extends React.Component {
    static navigationOptions = {
      title: 'SMS',
    };

    state = {
        sourceNumber: '',
        destinationNumber: '',
        messageText: ''
    }
 
    handleSourceNumber = (text) => {
        this.state.sourceNumber = text;
      }
      
    handleDestinationNumber = (text) => {
        this.state.destinationNumber = text;
    }

    handleMessageText = (text) => {
        this.state.messageText = text;
    }
   
    handleSMS = () => {
        var smsManager = NativeModules.SMS;
        smsManager.sendMessage(this.state.destinationNumber,this.state.sourceNumber,this.state.messageText,(error, message)=>{
              if(error == null) {
                  console.log("SMS Send successfully");
                  alert('Message Send Successfully!');
              }
        });
    }  

    render() {
      return (
        <View>
        
                <TextInput style = {styles.input}
                 placeholder = "Source number"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 defaultValue = "+15205829024"
                 onChangeText = {this.handleSourceNumber}
          />

          <TextInput style = {styles.input}
                 placeholder = "Destination number"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 defaultValue = "+18022761022"
                 onChangeText = {this.handleDestinationNumber}
          />

         <TextInput style = {styles.input}
                 placeholder = "Enter the text"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 defaultValue = "SMS"
                 onChangeText = {this.handleMessageText}
          />

          <Button style={styles.buttonStyle}
                title = "Send SMS"
                onPress = {this.handleSMS}
          />  
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

  export default SMS; 