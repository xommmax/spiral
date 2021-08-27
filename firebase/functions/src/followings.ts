

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {log} from "firebase-functions/lib/logger";


export const onFollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      if (userId != undefined) {
        updateFollowingsCount(true, userId).then((result) => {
          if (result != -1) {
            log(`'followingCount' value is successfully increased (${result}) in user: ${userId}`);
          } else {
            log(`followingCount' value is not increased in user: ${userId}`);
          }
        });
      } else {
        log("Unable to find userId for 'onFollowingHub' function");
      }
    });

export const onUnfollowingHub = functions
    .firestore
    .document("usersFollowHubs/{userId}/hubs/{hubId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const userId = snap.ref.parent.parent?.id;
      if (userId != undefined) {
        updateFollowingsCount(false, userId).then((result) => {
          if (result != -1) {
            log(`'followingCount' value is successfully decreased (${result}) in user: ${userId}`);
          } else {
            log(`followingCount' value is not decreased in user: ${userId}`);
          }
        });
      } else {
        log("Unable to find userId for 'onUnFollowingHub' function");
      }
    });


export async function updateFollowingsCount(isFollowing: boolean, userId: string) : Promise<number> {
  let followingsCount = -1;
  try {
    const snap = admin.firestore().doc(`users/${userId}`);
    const doc = await snap.get();
    const count = await doc.get("followingsCount");
    if (isFollowing) {
      await snap.update({"followingsCount": admin.firestore.FieldValue.increment(1)});
    } else if (count > 0) {
      await snap.update({"followingsCount": admin.firestore.FieldValue.increment(-1)});
    }
    followingsCount = await doc.get("followingsCount");
  } catch (e) {
    log(`An error occurred while running 'updateFollowingsCount' function: ${e}`);
  }
  return followingsCount;
}
