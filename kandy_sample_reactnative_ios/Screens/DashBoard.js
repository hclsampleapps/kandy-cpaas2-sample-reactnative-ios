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

class DashBoard extends React.Component {
    static navigationOptions = {
      title: 'DashBoard',
    };

    showLoader = () => { this.setState({ showLoader:true }); };
    hideLoader = () => { this.setState({ showLoader:false }); };

    handleSMS = (text) => {
        this.props.navigation.navigate('SMS')
    }
    
    handleChat = (text) => {
        this.props.navigation.navigate('Login')
    }
        
    render() {
      return (
        <View style={styles.container}>    
        <Button style={styles.buttonStyle}
                title = "SMS"
                color = '#0391C2'
                onPress = {this.handleSMS}
        />    

         <Button style={styles.buttonStyle}
                title = "Chat"
                color = '#0391C2'
                onPress = {this.handleChat}
        />            
     </View> 
    );
    }
  }

  const styles = StyleSheet.create({   
    buttonStyle: {
      marginTop: 20,
      padding: 20,
      borderRadius:10,
      borderColor:'black',
      flex: 60
    }
    });

  export default DashBoard; 