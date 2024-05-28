importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
  apiKey: "AIzaSyBPba_JkVgblFalb5qdxpMn0GdenzEjvC0",
  authDomain: "notification-appmamnon.firebaseapp.com",
  projectId: "notification-appmamnon",
  storageBucket: "notification-appmamnon.appspot.com",
  messagingSenderId: "607720209159",
  appId: "1:607720209159:web:8e3a3e1644ad062f7be3a2",
  measurementId: "G-3EDPJPFEYQ"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});