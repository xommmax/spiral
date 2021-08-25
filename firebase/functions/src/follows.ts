

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {log} from "firebase-functions/lib/logger";


export const onFollowHub = functions
    .firestore
    .document("hubsFollowers/{hubId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) => {
      const hubId = snap.ref.parent.parent?.id;
      if (hubId != undefined) {
        updateFollowersCount(true, hubId).then((result) => {
          if (result != -1) {
            log(`'followersCount' value is successfully increased (${result}) on hub: ${hubId}`);
          } else {
            log(`followersCount' value is not increased on hub: ${hubId}`);
          }
        });
      } else {
        log("Unable to find hubId for 'onHubFollow' function");
      }
    });

export const onUnFollowHub = functions
    .firestore
    .document("hubsFollowers/{hubId}/users/{userId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) => {
      const hubId = snap.ref.parent.parent?.id;
      if (hubId != undefined) {
        updateFollowersCount(false, hubId).then((result) => {
          if (result != -1) {
            log(`'followersCount' value is successfully decreased (${result}) on hub: ${hubId}`);
          } else {
            log(`followersCount' value is not decreased on hub: ${hubId}`);
          }
        });
      } else {
        log("Unable to find hubId for 'onUnFollowHub' function");
      }
    });


export async function updateFollowersCount(isFollow: boolean, hubId: string) : Promise<number> {
  let followersCount = -1;
  try {
    const snap = admin.firestore().doc(`userHubs/${hubId}`);
    const doc = await snap.get();
    const count = await doc.get("followersCount");
    if (isFollow) {
      await snap.update({"followersCount": admin.firestore.FieldValue.increment(1)});
    } else if (count > 0) {
      await snap.update({"followersCount": admin.firestore.FieldValue.increment(-1)});
    }
    followersCount = await doc.get("followersCount");
  } catch (e) {
    log(`An error occurred while running 'updateFollowersCount' function: ${e}`);
  }
  return followersCount;
}
