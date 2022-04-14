importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.23.0/firebase-messaging.js");
firebase.initializeApp({
          apiKey: "AIzaSyBAfrEGDzwbA5ei1gnKDvH3XNWIqEJvITY",
            authDomain: "letsgogb-6eb5b.firebaseapp.com",
            projectId: "letsgogb-6eb5b",
            storageBucket: "letsgogb-6eb5b.appspot.com",
            messagingSenderId: "756450874654",
            appId: "1:756450874654:web:6775bbd6517870920ee50f"
});
const messaging = firebase.messaging();


messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.body
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});