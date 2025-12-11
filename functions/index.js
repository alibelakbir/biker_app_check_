const { onDocumentCreated } = require('firebase-functions/v2/firestore');
const admin = require('firebase-admin');

admin.initializeApp({
    credential: admin.applicationDefault(),
  });
  
const db = admin.firestore();

exports.sendNewMessageNotification = onDocumentCreated(
  'chat_rooms_dev/{chatId}/messages/{messageId}',
  async (event) => {
    const message = event.data;
    const chatId = event.params.chatId;

    try {
      const chatDoc = await db.collection('chat_rooms_dev').doc(chatId).get();
      const chatData = chatDoc.data();

      if (!chatData || !chatData.participantUids) {
        return;
      }

      const senderId = message.senderId;

      const notificationPayload = {
        notification: {
          title: chatData.name || 'New Message',
          body: message.text || 'You have a new message',
        },
        data: {
          chatId,
        },
      };

      const tokens = [];

      for (const uid of chatData.participantUids) {
        if (uid === senderId) continue;

        const userDoc = await db.collection('users_dev').doc(uid).get();
        const userData = userDoc.data();

        if (userData && userData.fcmToken) {
          tokens.push(userData.fcmToken);
        }
      }

      if (tokens.length > 0) {
        const response = await admin.messaging().sendToDevice(tokens, notificationPayload);
        console.log('Notification sent:', response);
      }
    } catch (error) {
      console.error('Error sending notification:', error);
    }
  }
);
