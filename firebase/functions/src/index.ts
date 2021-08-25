import {isEmulator} from "./utils";
import * as admin from "firebase-admin";
import {onPublicationDisliked, onPublicationLiked} from "./like";
import {onCommentAdded} from "./comment";
import {onFollowHub, onUnFollowHub} from "./follows";

export const appUrl = "https://us-central1-dairo-4593a.cloudfunctions.net";

if (isEmulator) {
  console.log("Running from emulator...");
  admin.initializeApp();
} else {
  const serviceAccount: string = require(`${__dirname}/dairo.json`);
  admin.initializeApp({credential: admin.credential.cert(serviceAccount)});
}

exports.onPublicationLiked = onPublicationLiked;
exports.onPublicationDisliked = onPublicationDisliked;
exports.onCommentAdded = onCommentAdded;
exports.onFollowHub = onFollowHub;
exports.onUnFollowHub = onUnFollowHub;
