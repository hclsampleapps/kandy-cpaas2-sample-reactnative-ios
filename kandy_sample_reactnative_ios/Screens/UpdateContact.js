import React, { Component } from 'react';
import {View,NativeModules,Alert} from 'react-native';
import { Input, Button } from 'react-native-elements';

var addressBookManager = NativeModules.AddressBook;

class UpdateContact extends React.Component {
    static navigationOptions = {
      title: 'UpdateContact',
    };
    
    state = {
      contactId: '',
      primaryContactId: '',
      firstName: '',
      lastName:'',
      emailAddress:'',
      homePhoneNumber:'',
      businessPhoneNumber:''
    }

   componentDidMount(){
   }

   componentWillUnmount() {

    }

    handleContactId = (text) => {
      this.state.contactId = text;
    }

    handlePrimaryContactId = (text) => {
      this.state.primaryContactId = text;
    }

    handleFirstName = (text) => {
      this.state.firstName = text;
    }

    handleLastName = (text) => {
      this.state.lastName = text;
    }

    handleEmailAddress = (text) => {
      this.state.emailAddress = text;
    }

    handleHomePhoneNumber = (text) => {
      this.state.homePhoneNumber = text;
    }

    handleBusinessPhoneNumber = (text) => {
      this.state.businessPhoneNumber = text;
    }

    handleUpdate = () => {
      if(this.state.contactId && this.state.primaryContactId  && this.state.firstName  && 
          this.state.lastName  && this.state.emailAddress != "" && 
          this.state.businessPhoneNumber != ""  && 
          this.state.homePhoneNumber != "") {
          var data = {}
          data = {
              contactId: this.state.contactId,
              email: this.state.emailAddress,
              firstName: this.state.firstName,
              lastName: this.state.lastName,
              homePhoneNumber: this.state.homePhoneNumber,
              businessPhoneNumber: this.state.businessPhoneNumber,
            };
            const myObjStr = JSON.stringify(data);
            addressBookManager.updateContact(myObjStr,(error, message)=>{
              if(error != null) {
                   alert('Error in adding contact.');
              } else {
                   alert('Contact added successfully.');
              }
            });
        } else {
              alert('Please fill all the details.');
        }
    }

    render() {

      return (
        <View>
        <Input
           placeholder='Contact Id'
           onChangeText = {this.handleContactId}
       />
         <Input
           placeholder='Primary Contact'
           onChangeText = {this.handlePrimaryContactId}
       />
         <Input
           placeholder='First Name'
           onChangeText = {this.handleFirstName}
       />
         <Input
           placeholder='Last name'
           onChangeText = {this.handleLastName}
       />
         <Input
           placeholder='Email Address'
           onChangeText = {this.handleEmailAddress}
       />
         <Input
           placeholder='Home Phone Number'
           onChangeText = {this.handleHomePhoneNumber}
       />
         <Input
           placeholder='Business Phone Number'
           onChangeText = {this.handleBusinessPhoneNumber}
       />

        <Button 
          title="Update Contact"
          onPress = {this.handleUpdate}
        />
        </View>
    );
    }
}

export default UpdateContact; 