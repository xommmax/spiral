import * as functions from "firebase-functions";
import {log} from "firebase-functions/lib/logger";
import * as admin from "firebase-admin";


export const onCommentAdded = functions
    .firestore
    .document("publicationComments/{publicationId}/comments/{commentId}")
    .onCreate((snap, _) => {
      const publicationId = snap.ref.parent.parent?.id;
      if (publicationId != undefined) {
        updateCommentsCount(publicationId).then((result) => {
          if (result != -1) {
            log(`'commentsCount' value is successfully increased (${result}) on publication: ${publicationId}`);
          } else {
            log(`commentsCount' value is not increased on publication: ${publicationId}`);
          }
        });
      } else {
        log("Unable to find publicationId for 'onCommentAdded' function");
      }
    });

export async function updateCommentsCount(publicationId: string) : Promise<number> {
  let commentsCounter = -1;
  try {
    const snap = admin.firestore().doc(`hubPublications/${publicationId}`);
    const doc = await snap.get();
    await snap.update({"commentsCount": admin.firestore.FieldValue.increment(1)});
    commentsCounter = await doc.get("commentsCount");
  } catch (e) {
    log(`An error occurred while running 'updateLikesCount' function: ${e}`);
  }
  return commentsCounter;
}
