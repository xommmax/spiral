import {isEmulator} from "./utils";
import * as admin from "firebase-admin";
import {sendLike} from "./like";
import {fetchPublications} from "./publication";

export const appUrl = "https://us-central1-dairo-4593a.cloudfunctions.net";

if (isEmulator) {
  console.log("Running from emulator...");
  admin.initializeApp();
} else {
  const serviceAccount: string = require(`${__dirname}/dairo.json`);
  admin.initializeApp({credential: admin.credential.cert(serviceAccount)});
}

exports.sendLike = sendLike;
exports.fetchPublications = fetchPublications;
