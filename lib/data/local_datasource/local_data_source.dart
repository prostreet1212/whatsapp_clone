import '../../domain/entities/contact_entity.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class LocalDataSource {
  Future<List<ContactEntity>> getDeviceNumbers();
}

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<List<ContactEntity>> getDeviceNumbers() async {
    List<ContactEntity> contacts = [];
    List<Contact> getContactsData = await ContactsService.getContacts();
    getContactsData.forEach((myContact) {
      myContact.phones!.forEach((phoneData) {
        print(myContact.displayName!);
        print(phoneData.value!);
        contacts.add(ContactEntity(
          phoneNumber: phoneData.value!,
          label: myContact.displayName!,
        ));
      });
    });
    return contacts;
  }
}
