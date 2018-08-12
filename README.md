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

**The purpose of this application is to see whether after the application expires, I can still backup the files.**

I've had a case happen before where I ran my application using the development provisioning profile,
forgot that it will expire in a week and then lost data.
I don't remember if I deleted the application and lost data because of it or if I could restore them
using iTunes or XCode but I didn't know that.
In a week, this application will expire and I will be able to see if I can still access and share
the files.
