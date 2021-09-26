import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onFollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
// eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      if (userId == undefined) return;
      return updateFollowingsCount(true, userId);
    });

export const onUnfollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
// eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      if (userId == undefined) return;
      return updateFollowingsCount(false, userId);
    });


export async function updateFollowingsCount(isFollowing: boolean, userId: string): Promise<any> {
  const snap = admin.firestore().doc(`users/${userId}`);
  const doc = await snap.get();
  const count = await doc.get("followingsCount");
  if (isFollowing) {
    return snap.update({"followingsCount": admin.firestore.FieldValue.increment(1)});
  } else if (count > 0) {
    return snap.update({"followingsCount": admin.firestore.FieldValue.increment(-1)});
  } else {
    return "Cannot decrement the value";
  }
}
