import * as functions from "firebase-functions";
import {validateFirebaseIdToken} from "./utils";
import {log} from "firebase-functions/lib/logger";
import * as express from "express";
import * as admin from "firebase-admin";
import * as publication from "./publication";

export interface LikePublicationRequest {
    isLiked: boolean,
    publicationId: string,
    userId: string
}

export const sendLike = functions.https.onRequest(async (req: express.Request, res: express.Response)=> {
  const user = await validateFirebaseIdToken(req, res);
  if (user === null) {
    return;
  }
  try {
    await saveUserLikedPublication(req.body);
    const json = await updateLikesCount(req.body);
    if (json != undefined) {
      res.status(200).send(json);
    } else {
      log("An error occurred while trying to return json PublicationResponse");
      res.status(412).send("Internal server error, please contact us");
    }
  } catch (e) {
    log("An error occurred while running 'sendLike' request: " + e + "\nstacktrace is: " + e.stackTrace);
    res.status(422).send("Something went wrong, please try again.");
  }
});

export async function saveUserLikedPublication(likePublication: LikePublicationRequest): Promise<void> {
  const path = `hubPublications/${likePublication.publicationId}/usersLiked/${likePublication.userId}`;
  if (likePublication.isLiked) {
    await admin.firestore().doc(path).set({});
  } else {
    await admin.firestore().doc(path).delete();
  }
}

export async function updateLikesCount(likePublication: LikePublicationRequest) : Promise<FirebaseFirestore.DocumentData|undefined> {
  const snap = admin.firestore().doc(`hubPublications/${likePublication.publicationId}`);
  const doc = await snap.get();
  if (likePublication.isLiked) {
    await snap.update({"likesCount": admin.firestore.FieldValue.increment(1)});
  } else {
    await snap.update({"likesCount": admin.firestore.FieldValue.increment(-1)});
  }
  return await publication.getPublication(doc);
}
