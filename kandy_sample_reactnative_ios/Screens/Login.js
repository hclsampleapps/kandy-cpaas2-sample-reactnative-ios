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
    ActivityIndicator
} from 'react-native';

import SMS from './SMS'
import DashBoard from './DashBoard'

class Login extends React.Component {
  
    static navigationOptions = {
      title: 'Login',
    };

    state = {
        email: '',
        password: '',
        url: '',
        clientId: '',
        sourceNumber: '',
        destinationNumber: '',
        showLoader:false
    }

    showLoader = () => { this.setState({ showLoader:true }); };
    hideLoader = () => { this.setState({ showLoader:false }); };
  
    handleEmail = (text) => {
        this.state.email = text
    }
    
    handlePassword = (text) => {
        this.state.password = text
    }
    
    handleClientId = (text) => {
        this.state.clientId = text
    }
    
    handleUrl = (text) => {
        this.state.url = text;
    }
        
    handleLogin = () => {
        if(this.state.clientId && this.state.password  && this.state.email != "") {
           this.showLoader();
           var loginManager = NativeModules.login;
           loginManager.loginInApp(this.state.clientId,this.state.password,
             this.state.email,this.state.url,(error, token)=>{
               if(error == null) {
                 console.log(token);
                 this.props.navigation.navigate('DashBoard')
                 this.hideLoader();
               } else {  
                 this.hideLoader();
                 alert('Message Sending Failed!');
               }      
           });
        } else {
            alert('Please fill all the details.');
        }
    }

    render() {
      return (
        <View style={styles.container}>    
       <Text style = {styles.Welcome_text}>
                    Welcome
                  </Text>

                  <Text style = {styles.Login_text}>
                    Login to continue
                  </Text>
                  
                  <TextInput style = {styles.input}
                   placeholder = "Client Id"
                   placeholderTextColor = "black"
                   autoCapitalize = "none"
                   onChangeText = {this.handleClientId}
                  />

                <TextInput style = {styles.input}
                 placeholder = "Password"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 onChangeText = {this.handlePassword}
                 />

                 <TextInput style = {styles.input}
                 placeholder = "Email"
                 placeholderTextColor = "black"
                 autoCapitalize = "none"
                 onChangeText = {this.handleEmail}
                 />

              <View style={{ position: 'absolute', top:"50%",right: 0, left: 0 }}>
                 <ActivityIndicator animating={this.state.showLoader} size="large" color="grey" />
              </View>

          <Button style={styles.buttonStyle}
                title = "Login"
                color = '#0391C2'
                onPress = {this.handleLogin}
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

  export default Login; 