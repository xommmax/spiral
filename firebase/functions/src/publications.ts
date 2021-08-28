import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {log} from "firebase-functions/lib/logger";
import {DocumentSnapshot} from "firebase-functions/lib/providers/firestore";

export const onCreatePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onCreate((snap, _) =>
      duplicatePublicationToFollowers(snap, Operation.Create)
    );

export const onUpdatePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onUpdate((snap, _) =>
      duplicatePublicationToFollowers(snap.after, Operation.Update)
    );

export const onDeletePublication = functions
    .firestore
    .document("hubPublications/{publicationId}")
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    .onDelete((snap, _) =>
      duplicatePublicationToFollowers(snap, Operation.Delete)
    );

export async function duplicatePublicationToFollowers(snapshot: DocumentSnapshot, operation: Operation): Promise<void> {
  const hubId = await snapshot.get("hubId");
  if (hubId != null) {
    try {
      const followers = await admin
          .firestore()
          .collection(`hubsFollowers/${hubId}/users`)
          .get()
          .then((snap) => snap.docs.map((doc) => doc.id));
      const data = snapshot.data();
      if (data != undefined) {
        switch (operation) {
          case Operation.Create:
            await Promise.all(
                followers.map((userId) =>
                  admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).create(data)),
            );
            break;
          case Operation.Update:
            await Promise.all(
                followers.map((userId) =>
                  admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).update(data)),
            );
            break;
          case Operation.Delete:
            await Promise.all(
                followers.map((userId) =>
                  admin.firestore().doc(`userFeeds/${userId}/publications/${snapshot.id}`).delete(data)),
            );
            break;
        }
      } else {
        log("Publication data is null, check why document snapshot is empty");
      }
    } catch (e) {
      log("Cannot proceed with publication copy: " + e + "\n" + e.stackTrace);
    }
  } else {
    log("Unable to find userId for 'onCreatePublication' function");
  }
}

enum Operation {
    Create,
    Update,
    Delete
}

