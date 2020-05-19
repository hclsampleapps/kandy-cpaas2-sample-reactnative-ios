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
    NativeEventEmitter,
    FlatList,
    ActivityIndicator
} from 'react-native';

var addressBookManager = NativeModules.AddressBook;
var addressBookEvents = new NativeEventEmitter(NativeModules.AddressBook)

class AddressBook extends React.Component {
    static navigationOptions = {
      title: 'AddressBook',
    };

    state = {
        destinationId: '',
        messageText: '',
        contactList:[]
  }

  showLoader = () => { this.setState({ showLoader:true }); };
  hideLoader = () => { this.setState({ showLoader:false }); };

  componentDidMount(){
    this.showLoader();
    addressBookManager.initAddressBookModule((error, response) =>{
      if(error == null) {
          this.setState({ contactList: response });
          console.log(response);
          this.hideLoader();
          console.log("Address module initialize");
      }
    });
   }

   componentWillUnmount() {
        this.state.contactList.length = 0
   }

   FlatListItemSeparator = () => {
    return (
      <View
        style={{
          height: 1,
          width: "100%",
          backgroundColor: "#000",
        }}
      />
    );
   }

    render() {
      return (
      <View>
      <View style={{ position: 'absolute', top:"100%",right: 0, left: 0 }}>
                 <ActivityIndicator animating={this.state.showLoader} size="large" color="grey" />
      </View>
      <FlatList
        data={this.state.contactList}
        keyExtractor={(item, index) => index.toString()}
        ItemSeparatorComponent = { this.FlatListItemSeparator }
        renderItem={({ item }) => (
            <TouchableOpacity>
                <View>
                <View style={{ flexDirection: 'row'}}>
                        <Text style={styles.cell_text}>{item.firstName}</Text>
                    </View>
                </View>
                <View>
                <View style={{ flexDirection: 'row' }}>
                        <Text style={styles.cell_text}>{item.email}</Text>
                    </View>
                </View>
            </TouchableOpacity>
        )}

        />

        </View> 
    );
    }
  }

const styles = StyleSheet.create({   
  cell_text: {
    marginTop: 10,
    marginBottom: 20,
    marginLeft: 20,
    fontSize:12
  },
});  

export default AddressBook; 