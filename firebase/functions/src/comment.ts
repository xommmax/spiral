import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


export const onCommentAdded = functions
    .firestore
    .document("publicationComments/{publicationId}/comments/{commentId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      return updateCounters(snap.ref);
    });

export async function updateCounters(ref: FirebaseFirestore.DocumentReference): Promise<any> {
  const doc = await ref.get();
  const publicationId = ref.parent.parent?.id;
  const parentCommentId = await doc.get("parentCommentId");
  if (publicationId == undefined) return;
  if (parentCommentId != undefined || parentCommentId != null) {
    return updateRepliesCount(publicationId, parentCommentId);
  } else {
    return updateCommentsCount(publicationId);
  }
}

export async function updateCommentsCount(publicationId: string) : Promise<any> {
  const snap = admin.firestore().doc(`hubPublications/${publicationId}`);
  return snap.update({"commentsCount": admin.firestore.FieldValue.increment(1)});
}

export async function updateRepliesCount(publicationId: string, parentCommentId: string)
    : Promise<any> {
  const ref = await admin
      .firestore()
      .doc(`publicationComments/${publicationId}/comments/${parentCommentId}`);
  return ref.update({"repliesCount": admin.firestore.FieldValue.increment(1)});
}
