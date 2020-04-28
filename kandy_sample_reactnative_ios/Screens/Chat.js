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
    NativeEventEmitter
} from 'react-native';

var chatManager = NativeModules.Chat;
var chatEvents = new NativeEventEmitter(NativeModules.Chat)

class Chat extends React.Component {
    static navigationOptions = {
      title: 'Chat',
    };

    state = {
        destinationId: '',
        messageText: ''
    }
    
   chatEvents = chatEvents.addListener(
      "messageReceived",
      res => {
        if(res != null) {
          alert('Message Received Successfully!');
        }
    }
  )

  componentDidMount(){
    chatManager.initChatModule((error, message) =>{
      if(error == null) {
          console.log("Chat initialize");
      }
    });
   }

    handleDestinationId = (text) => {
        this.state.destinationId = text;
    }

    handleMessageText = (text) => {
        this.state.messageText = text;
    }
   
    handleChat = () => {
        chatManager.sendChat(this.state.destinationId,this.state.messageText,(error, message)=>{
              if(error == null) {
                  console.log("Chat Send successfully");
                  alert('Chat Send Successfully!');
              }
        });
    }  

    render() {
      return (
        <View>

          <TextInput style = {styles.input}
                 placeholder = "Destination id"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 onChangeText = {this.handleDestinationId}
          />

         <TextInput style = {styles.input}
                 placeholder = "Enter the text"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 onChangeText = {this.handleMessageText}
          />

          <Button style={styles.buttonStyle}
                title = "Send Chat"
                onPress = {this.handleChat}
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

  export default Chat; 