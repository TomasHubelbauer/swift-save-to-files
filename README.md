# Swift Save to Files

This is a demo application for iOS which allows one to write text files with the current date and time to its
Documents directory.
The project is configured so that the Files app sees the Documents directory of the application this way:

`Info.plist`:

```xml
<key>UIFileSharingEnabled</key>
<true />
<key>LSSupportsOpeningDocumentsInPlace</key>
<true />
```

Additionally, the application displays the creation and expiration date of its provisioning profile.

## The Purpose

This application shows that an application which exposes its files to the Files App can,
after its development provisioning profile expires and the application is reinstalled using XCode,
pick up the existing and write new files to the Files App.

This in turns menas that assuming one is willing to reinstall an application every week,
it is possible to make an application work without installing it through the App Store
while providing it with persistent storage which is user-accessible even outside of the app.
