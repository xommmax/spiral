import * as functions from "firebase-functions";
import {log} from "firebase-functions/lib/logger";
import * as admin from "firebase-admin";


export const onCommentAdded = functions
    .firestore
    .document("publicationComments/{publicationId}/comments/{commentId}")
    .onCreate((snap, _) => updateCounters(snap.ref));

export async function updateCounters(ref: FirebaseFirestore.DocumentReference): Promise<void> {
  const doc = await ref.get();
  const publicationId = ref.parent.parent?.id;
  const parentCommentId = await doc.get("parentCommentId");
  if (publicationId != undefined) {
    if (parentCommentId != undefined || parentCommentId != null) {
      updateRepliesCount(publicationId, parentCommentId).then((result) => {
        if (result != -1) {
          log(`'repliesCount' value is successfully increased (${result}) on publication: ${publicationId}`);
        } else {
          log(`repliesCount' value is not increased on publication: ${publicationId}`);
        }
      });
    } else {
      updateCommentsCount(publicationId).then((result) => {
        if (result != -1) {
          log(`'commentsCount' value is successfully increased (${result}) on publication: ${publicationId}`);
        } else {
          log(`commentsCount' value is not increased on publication: ${publicationId}`);
        }
      });
    }
  } else {
    log("Unable to find publicationId for 'onCommentAdded' function");
  }
}

export async function updateCommentsCount(publicationId: string) : Promise<number> {
  let commentsCount = -1;
  try {
    const snap = admin.firestore().doc(`hubPublications/${publicationId}`);
    const doc = await snap.get();
    await snap.update({"commentsCount": admin.firestore.FieldValue.increment(1)});
    commentsCount = await doc.get("commentsCount");
  } catch (e) {
    log(`An error occurred while running 'updateLikesCount' function: ${e}`);
  }
  return commentsCount;
}

export async function updateRepliesCount(publicationId: string, parentCommentId: string)
    : Promise<number> {
  let repliesCount = -1;
  try {
    const ref = await admin
        .firestore()
        .doc(`publicationComments/${publicationId}/comments/${parentCommentId}`);
    const doc = await ref.get();
    await ref.update({"repliesCount": admin.firestore.FieldValue.increment(1)});
    repliesCount = await doc.get("repliesCount");
  } catch (e) {
    log(`An error occurred while running 'updateRepliesCount' function: ${e}`);
  }
  return repliesCount;
}
