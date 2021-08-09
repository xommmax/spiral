
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {log} from "firebase-functions/lib/logger";


export const onPublicationLiked = functions
    .firestore
    .document("publicationLikes/{publicationId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const publicationId = snap.ref.parent.parent?.id;
      if (publicationId != undefined) {
        updateLikesCount(true, publicationId).then((result) => {
          if (result != -1) {
            log(`'likesCount' value is successfully increased (${result}) on publication: ${publicationId}`);
          } else {
            log(`likesCount' value is not increased on publication: ${publicationId}`);
          }
        });
      } else {
        log("Unable to find publicationId for 'onPublicationLiked' function");
      }
    });

export const onPublicationDisliked = functions
    .firestore
    .document("publicationLikes/{publicationId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const publicationId = snap.ref.parent.parent?.id;
      if (publicationId != undefined) {
        updateLikesCount(false, publicationId).then((result) => {
          if (result != -1) {
            log(`'likesCount' value is successfully decreased (${result}) on publication: ${publicationId}`);
          } else {
            log(`likesCount' value is not decreased on publication: ${publicationId}`);
          }
        });
      } else {
        log("Unable to find publicationId for 'onPublicationDisliked' function");
      }
    });


export async function updateLikesCount(isLiked: boolean, publicationId: string) : Promise<number> {
  let likesCounter = -1;
  try {
    const snap = admin.firestore().doc(`hubPublications/${publicationId}`);
    const doc = await snap.get();
    const count = await doc.get("likesCount");
    if (isLiked) {
      await snap.update({"likesCount": admin.firestore.FieldValue.increment(1)});
    } else if (count > 0) {
      await snap.update({"likesCount": admin.firestore.FieldValue.increment(-1)});
    }
    likesCounter = await doc.get("likesCount");
  } catch (e) {
    log(`An error occurred while running 'updateLikesCount' function: ${e}`);
  }
  return likesCounter;
}
