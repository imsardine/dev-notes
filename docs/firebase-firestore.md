---
title: Firebase / Cloud Firestore
---
# [Firebase](firebase.md) / Cloud Firestore

  - [Cloud Firestore \| Store and sync app data at global scale  \|  Firebase](https://firebase.google.com/products/firestore)

      - Store and sync app data at global scale

      - NoSQL database built for global apps

        Cloud Firestore is a NoSQL document database that lets you easily store, sync, and query data for your mobile and web apps - at global scale.

      - Query and structure data the way you like

        Structure your data easily with COLLECTIONS and DOCUMENTS. Build hierarchies to store related data and easily retrieve the data you need using expressive queries. All queries scale with the size of your result set (note: not your data set ??), so your app is ready to scale from day one.

      - Build truly serverless apps

        Cloud Firestore ships with mobile and web SDKs and a comprehensive set of security rules so you can access your database without needing to stand up your own server. Using Cloud Functions, our serverless compute product, you can execute hosted backend code that responds to data changes in your database.

        Of course, you can also access Cloud Firestore with TRADITIONAL client libraries too (i.e. Node, Python, Go, and Java).

      - Sync data across devices, on or offline

        With Cloud Firestore, you can automatically synchronize your app data between devices. We’ll notify you of data changes as they occur so you can easily build collaborative experiences and realtime apps.

        Your users can access and make changes to their data at any time, even when they're offline. Offline mode is available on iOS, Android and Web!

      - Scale globally

        Powered by Google’s storage infrastructure, Cloud Firestore is built to scale with your business. Now, you can focus on building your app instead of managing servers or worrying about consistency.

      - Strong USER-BASED security

        With our DECLARATIVE security language, you can restrict data access based on user identity data, pattern matching on your data, and more. Cloud Firestore also integrates with Firebase Authentication to give you simple and intuitive user authentication.

  - [Cloud Firestore - Firebase \- Wikipedia](https://en.wikipedia.org/wiki/Firebase#Cloud_Firestore)

    On January 31, 2019, Cloud Firestore was officially brought out of beta, making it an official product of the Firebase lineup. It is the successor to Firebase's original databasing system, Real-time Database, and allows for NESTED documents and FIELDS rather than the TREE-VIEW provided in the Real-time Database.

  - [Cloud Firestore  \|  Firebase](https://firebase.google.com/docs/firestore) #ril

## 新手上路 {: #getting-started }

  - [Get started with Cloud Firestore  \|  Firebase](https://firebase.google.com/docs/firestore/quickstart) #ril

      - This quickstart shows you how to set up Cloud Firestore, add data, then view the data you just added in the Firebase console.

    Create a Cloud Firestore database

     1. If you haven't already, create a Firebase project: In the Firebase console, click Add project, then follow the on-screen instructions to create a Firebase project or to add Firebase services to an existing GCP project.

        所以 Firebase console 看到的其實是啟用 Firebase service 的 GCP project？

     2. Navigate to the Database section of the Firebase console. You'll be prompted to select an existing Firebase project. Follow the database creation workflow.

     3. Select a STARTING MODE for your Cloud Firestore Security Rules:

          - Test mode

            Good for getting started with the mobile and web client libraries, but allows ANYONE to read and overwrite your data. After testing, make sure to review the Secure your data section.

          - Locked mode

            Denies all reads and writes from mobile and web clients. Your authenticated application servers (C#, Go, Java, Node.js, PHP, Python, or Ruby) can still access your database.

     4. Select a location for your database.

          - This location setting is your project's default Google Cloud Platform (GCP) resource location. Note that this location will be used for GCP services in your project that require a location setting, specifically, your default Cloud Storage bucket and your App Engine app (which is required if you use Cloud Scheduler).

          - If you aren't able to select a location, then your project already has a default GCP resource location. It was set either during project creation or when setting up another service that requires a location setting.

        Warning: After you set your project's default GCP resource location, you cannot change it.

     5. Click Done.

        Cloud Firestore and App Engine: You can't use both Cloud Firestore and Cloud Datastore in the same project, which might affect apps using App Engine. Try using Cloud Firestore with a different project.

        When you enable Cloud Firestore, it also enables the API in the Cloud API Manager. ??

## 參考資料 {: #reference }

  - [Cloud Firestore - Firebase](https://firebase.google.com/products/firestore)
