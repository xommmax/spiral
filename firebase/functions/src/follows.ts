import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onFollowHub = functions
    .firestore
    .document("hubsFollowers/{hubId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const hubId = snap.ref.parent.parent?.id;
      if (hubId == undefined) return;
      return updateFollowersCount(true, hubId);
    });

export const onUnfollowHub = functions
    .firestore
    .document("hubsFollowers/{hubId}/users/{userId}")
// eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const hubId = snap.ref.parent.parent?.id;
      if (hubId == undefined) return;
      return updateFollowersCount(false, hubId);
    });


export async function updateFollowersCount(isFollow: boolean, hubId: string): Promise<any> {
  const snap = admin.firestore().doc(`userHubs/${hubId}`);
  if (isFollow) {
    return snap.update({"followersCount": admin.firestore.FieldValue.increment(1)});
  } else {
    return snap.update({"followersCount": admin.firestore.FieldValue.increment(-1)});
  }
}
