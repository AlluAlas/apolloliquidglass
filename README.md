# Balackburn's Apollo with Liquid Glass

This method was made possible thanks to [ryannair05](https://github.com/JeffreyCA/Apollo-ImprovedCustomApi/issues/63) who explained how he achieved this with Apollo on iOS 26 beta 2. I simply made the IPA file for you all and using the latest version.

### Steps to replicate:
1. Download the latest Apollo IPA from [Balackburn](https://github.com/Balackburn/Apollo/releases).  
2. Change the extension from `.ipa` to `.zip` and extract it.  
3. Open **Terminal**, `cd` into the extracted `Payload` folder, and run:  

   ```bash
   codesign --remove-signature Apollo.app/Apollo
   vtool -set-build-version ios 15.0 19.0 -replace -output Apollo.app/Apollo Apollo.app/Apollo
   install_name_tool -delete_rpath "@executable_path/Frameworks" Apollo.app/Apollo

4. Compress the Payload folder again, rename from .zip to .ipa, and sideload it.

I also created and included a tweak as a fix for the constant crashes when using Compact Mode and collapsing comments with images. It should be more stable now. If anyone knows Balackburn, tell him I’d like him to take a look at this so that, if he wants, he can implement it in his app and everyone can enjoy this together instead of being split.
