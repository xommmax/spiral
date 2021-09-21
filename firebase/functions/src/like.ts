import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


export const onPublicationLiked = functions
    .firestore
    .document("publicationLikes/{publicationId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const publicationId = snap.ref.parent.parent?.id;
      if (publicationId == undefined) return;
      return updateLikesCount(true, publicationId);
    });

export const onPublicationDisliked = functions
    .firestore
    .document("publicationLikes/{publicationId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const publicationId = snap.ref.parent.parent?.id;
      if (publicationId == undefined) return;
      return updateLikesCount(false, publicationId);
    });


export async function updateLikesCount(isLiked: boolean, publicationId: string) : Promise<any> {
  const snap = admin.firestore().doc(`hubPublications/${publicationId}`);
  const doc = await snap.get();
  const count = await doc.get("likesCount");
  if (isLiked) {
    return snap.update({"likesCount": admin.firestore.FieldValue.increment(1)});
  } else if (count > 0) {
    return snap.update({"likesCount": admin.firestore.FieldValue.increment(-1)});
  } else {
    return "Cannot update the value";
  }
}
