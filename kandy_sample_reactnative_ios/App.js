/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, {Component,useState} from 'react';
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

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import 'react-native-gesture-handler';

import {NavigationContainer} from '@react-navigation/native';
import {createStackNavigator} from '@react-navigation/stack';

import Login from './Screens/Login';
import SMS from './Screens/SMS';

const Stack = createStackNavigator();

export default class App extends Component{ 

render() 
  {
  return (   
    <NavigationContainer>
    <Stack.Navigator>
      <Stack.Screen
        name="Login"
        options={{
          title: 'Login',
          headerStyle: {
            backgroundColor: '#0391C2',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
        component={Login}
      />
      <Stack.Screen 
        name="SMS"
        options={{
          title: 'SMS',
          headerStyle: {
            backgroundColor: '#0391C2',
          },
          headerTintColor: '#fff',
          headerTitleStyle: {
            fontWeight: 'bold',
          },
        }}
        component={SMS} 
      />
    </Stack.Navigator>
    </NavigationContainer>      
  );
  }
  
}
  


