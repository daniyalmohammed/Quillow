# Quillow
Quillow is an elegant book management app on the App Store that allows you to search, add and track the books you've consumed.


Open the app here: https://apps.apple.com/us/app/quillow/id1602885135?platform=iphone



**Quillow Features**

ELEGANT USER INTERFACE: - Simple and pretty UI to showcase and record your books - NO ads, in-app purchases and other monetization - Beautiful dark mode is compatible with the app

LOGIN FUNCTIONALITY: - Allows for user authenticated login to keep your booklist private - Able to access the same book list through multiple devices by login functionality

FIND YOUR BOOKS: - Easily search our extensive database of books and add your book to your list - Automatically stores the book's information and provides a detailed view

ADD YOUR FAVOURITES: - Quillow has a favourites functionality that allows for you to favourite a book - Allows you to sort and only show your favourite books

SORT AND DELETE: - Allows you to customize the order of the books - Allows you to completely remove your book


**Quillow Technical Overview**

• Quillow utilizes Google Firebase Authentication to keep track of users and allows them to log in and access their data

• Quillow utilizes Google Firestore to save and store data and allows the user to read the data onto their device

• Quillow utilizes Google Books API to access and collect information from a database of books. Can store this data and create, read, update and delete books from and to the user's book list.

• Quillow uses other dependencies such as SwiftyJSON to allow ease of access when using APIs



Please use the following link: http://daniyalmoha.me/quillow-project.html

**The Quillow Story**

Since my childhood, I have been obsessed with using my iPad. I have always marveled at the ease of use and access to extensive data through the form of apps. Additionally, I am an avid reader and wanted to keep track of the books I have read. However, the apps on the app store either had ugly UI's, ads plastered everywhere and none allowed you to log in to the app so you can access through multiple devices. With this in mind, as soon my university semester 1A ended, (first-year fall term), I decided to build the app, both because I wanted to create something and because my book list was a need I wanted fulfilled. I will now explain the timeline of creating this app.

**Day One: Dec 17, 2021**
On the first day, I used a tutorial on YouTube by KavSoft to create the log in page. I had never used Swift or Xcode before this and it was a major learning curve because I had no clue what the syntax meant. I shortlisted some names for the app (ShowOff, Placed) but I hated them. I enlisted my little sisters as the UX/UI designers which basically meant they had to come up with the name and the app logo.

**Day Two: Dec 18, 2021**
Day Two was highly frustrating because up to this point all I had done was write down the same code as I did in the video. However, I was getting the hang of the Swift syntax. I finally figured out how to connect the Firebase API to the code to allow the user to log in. I then created a search screen to allow the user to search up a book. I connected this to the Google Books API and was able to hardcode a URL into the code to search that URL up in Google Books API.

**Day Three: Dec 19, 2021**
I finally figured out how to take different variables into different structs. This allows me to take what the user inputs in the search screen and search it up into the Google Books API to display the search results. However, I realized a major issue. For some reason, certain searches would crash the app. For example, if the search was random letters it would automatically crash. However, known phrases such as "Harry Potter" worked perfectly. This was annoying but it seemed there was no way to fix this bug.

**Day Four: Dec 20, 2021**
I created a new screen to allow a user to click the search results and it would display a single book. However, Navigation View was incredibly frustrating to use because I wanted to customize the back button and continuously navigating through would cause UI changes and make it look horrendous. I managed to finally fix this by just removing all navigation links and going with simple buttons. I also began to set up a class to store the book information. Additionally, my sister finally did her job and created a beautiful logo with a Quill. In our meeting I mentioned that perhaps we should make it called Quill List. She said Quillow and immidiately I loved the name even though she said it as a joke.

**Day Five: Dec 21, 2021**
I used @EnviromentObject to help the class access different structs and I was amazed at how useful that property wrapper was. This was day I finally figured out how to fix the bug to stop the app from crashing. Turns out when I followed the YouTube tutorial the tutorial converted the author names into an array and in cases where there was no author the code did not handle that case. I fixed it by only taking in the first author and converting that to a string and if there was no author I put an empty string.

**Day Six: Dec 22, 2021**
After 5 amazingly productive days, I felt insane burnout. I did not take a break after the (very tough) school term ended and I had a pounding headache. With immense guilt I told myself I would work on it the next day instead (I lied to myself)

**Day Seven: Dec 23, 2021**
No progress made. (My best friend's sister was getting married and I stayed over all day)

**Day Eight: Dec 24, 2021**
Much to my horror, I realized my code would automatically login the user even if my password was not correct. I went deep in the code and fixed this issue. I also added the favourites functionality which allowed the user to favourite a book.

**Day Nine: Dec 25, 2021**
No progress made. (Went to drop my Grandma to the airport)

**Day Ten: Dec 26, 2021**
Fixed the ability to sort the book list to only show favourites. I researched how to save the data onto the phone and there seemed to be 3 different options

1. UserDefaults- easy to implement but seemed an issue because UserDefaults is only used to store very little pieces of data.

2. CoreData- best way to store user data, however all the work I had done creating classes and organizing data would go to waste because with CoreData I pretty much would have to restart.

3. Google Firestore - at the time it seemed the only possible solution was Firestore and expecially since I had already used Google Firebase it seemed they would work well together.

So I ultimately chose to do option 3. However, when using Cocoa Pods, Google Firebase refused to download. I tried to use an SDK to download and it would not load up either. I spent so much time trying to figure out why. Eventually with much stress I decided to update XCode and my MacBook, go to sleep and try the next day.

**Day Eleven: Dec 27, 2021**
With immense struggle I managed to download the FirestoreSDK. For the rest of the day, no progress made. (Went to my bestfriend's weddings second event and slept over)

**Day Twelve: Dec 28, 2021**
I completely made a new project in order to rename it and clear all the assets I hadn't used. This time I used no cocoapods and installed everything with an SDK which was far easier.

**Day Thirteen - Fifteen: Dec 29-31, 2021**
I finally got the Firestore Database working and it would automatically save data. I created these functions inside the class. However, now I had to assign firestore rules and I could not figure them out. Instead, I just hardcoded the userID inside the book class and only allowed it to pull where the book userID and the user's userID was the same. I was concerned about lag using this technique because if there was thousands of books in the database then it would have to go through the entire database of books anyone using the app has added to see what matches. However for now, this seemed like an decent fix.

**Day Sixteen: Jan 1, 2021**
I sepnt the $130 dollars to be in the Apple Developer Program :( I then exported my app to the Apple Connect and quickly rushed to make a support URL and privacy policy with the help of online generators and submitted my app. For the rest of the day I was stressed and sad because I knew that if the App reviewers rejected it I would have 0 motivation to fix the issues at this point.

**Day Seventeen: Jan 2, 2021**
To my shock, when I woke up checked my notifications, it said my app had been approved. They only took about 24 hours. I went on the App Store and my app was there. I was utterly gassed. I downloaded it and realized the log in screen photo was not there. Otherwise, the app worked perfectly. I realized I put the picture in the preview assets foler and not in the assets folder. I quickly rushed another update praying to the Apple gods to approve me once again. For the rest of this day, I spent writing on this website (Pretty much what you are reading above). Note: HTML/CSS seems incredibly easy now that I've traversed the land of APIs and bugs and complex syntax).


**Lessons Learned:**

• YouTube Tutorials/Stack Overflow is amazing but you can't rely on them - I learned almost everything through there, but as you develop your own app it becomes its own niche and the same tricks they do in the YT tutorials are not useful anymore for your project so you are forced to rely and find your own fixes.

• Just Do It - As a beginner it is a struggle to get started and when you face problems they seem impossible and it feels easier to give up. However, it is vital to keep the mentality that everything is doable and you will push through it and succeed. Also, don't just completely copy another project from YouTube. We learn by making mistakes and its important to feel comfortable making them.


**Quillow Privacy Policy**

Privacy Policy
Daniyal Mohammed built the Quillow app as a Free app. This SERVICE is provided by Daniyal Mohammed at no cost and is intended for use as is.

This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.

If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Quillow unless otherwise defined in this Privacy Policy.

Information Collection and Use

For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Email Address. The information that I request will be retained on your device and is not collected by me in any way.

The app does use third-party services that may collect information used to identify you.

Link to the privacy policy of third-party service providers used by the app

Google Analytics for Firebase
Log Data

I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.

Cookies

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

I may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analyzing how our Service is used.
I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

Security

I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.

Links to Other Sites

This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

Children’s Privacy

These Services do not address anyone under the age of 13. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.

Changes to This Privacy Policy

I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.

This policy is effective as of 2022-01-02

Contact Us

If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at daniyalmoha@gmail.com. You are also free to contact me using any of the links below.
